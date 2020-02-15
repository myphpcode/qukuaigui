<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\index\controller;

use app\common\controller\IndexBase;
use think\Cache;
use think\Controller;
use think\Db;
use My\DataReturn;

class Index extends IndexBase
{
    //首页
    public function index()
    {
        $piglist = Db::name('task_config')->order('start_time','asc')->select();
        $nowtime = date('H:i');
        $nowday = date('Y-m-d ');
        $time = time();

        foreach ($piglist as $key=>$val) {
            //dump($val);
            //dump($nowtime<$val['start_time'] || $nowtime>$val['end_time']);
            if ($nowtime<$val['start_time'] || $nowtime>$val['end_time']) {
                //echo 'yuyue';
                if (!$this->isYuyue($val['id'])) {
                    $piglist[$key]['game_status'] =1; //预约
                } else {


                    $piglist[$key]['game_status'] =2; //已预约





                }

            }elseif ($nowtime>=$val['start_time']) {



              //  echo 'open';
                //查找可出售的猪
                $pigMap = [];
                $pigMap['pig_id'] = $val['id'];
                $pigMap['status'] = 0;
                $buyPiglist = Db::name('pig_order')->where($pigMap)->select();
                if(empty($buyPiglist) || $val['is_open']==1){
                    $piglist[$key]['game_status'] = 0;//已经售罄
                }else if ($val['is_open'] == 0 && $this->isYuyue($val['id'])) {
                    $piglist[$key]['game_status'] = 4;//开奖中
                }else if($nowtime<$val['end_time']){
                    $piglist[$key]['game_status'] = 4;//抢购
                }else{
                    $piglist[$key]['game_status'] = 4;//开奖中
                }
            } else {
            //echo '00';
                $piglist[$key]['game_status']=0;
            }
        }
        $config=unserialize(Db::name('system')->where('name','site_config')->value('value'));
        $base_config = unserialize(Db::name('system')->where('name','base_config')->value('value'));
        //dump($piglist);die;
        return view()->assign(['piglist'=>$piglist,'nowday'=>$nowday,'nowtime'=>$time,'config'=>$config,'base_config'=>$base_config]);
    }
    public function isYuyue($pig_id)
    {
        $map = [];
        $map['uid'] = $this->user_id;
        $map['pig_id'] = $pig_id;
        $map['status'] = 0;
        $insertData['buy_type'] = ['<>', 1];
        $res = Db::name('yuyue')->where($map)->find();
        return $res ? 1 : 0;
    }
    public function checkGame(){
        $game = model('Game');
        $time = $game->excute_time();
        $now_game_time = strtotime($game->gaming_model['start_time']);
        $now_end_time = strtotime($game->gaming_model['end_time']);
        //dump($game);
        //前端显示开奖剩余时间
        $plus_time = $game->excute_time() - $game->openaward;
//        dump($plus_time);die;
        //id 游戏ID  time 游戏时间  openaward 开奖冷却时间
        DataReturn::returnJson(200,'',['id'=>$game->game_id,'end_time'=> $now_end_time,'openaward'=>$game->openaward,'cool_time'=>$game->getCoolTime() + 1,'start_time'=>$now_game_time,'stage'=>$game->gameTimeArea($now_game_time)]);

    }
    public function yuyue()
    {
        $data = $this->request->param();
        //dump($data);
        $pig_id = $data['id'];
        $pigInfo =  Db::name('task_config')->where('id',$pig_id)->find();
        $nowTime = date('H:i');
        if ($nowTime>$pigInfo['start_time'] && $nowTime<$pigInfo['end_time'])
        {
            $this->error('不是预约时间');
        }
        //是否实名通过
        $authMap = [];
        $authMap['uid'] = $this->user_id;
        $authMap['status'] = 1;
        if (!Db::name('identity_auth')->where($authMap)->find()) $this->error('请先实名');

        $hasYuyue = $this->isYuyue($pig_id);
        if ($hasYuyue) $this->error('已预约');
        //饲料

        if ($this->user['pay_points']<$pigInfo['pay_points']){
            $this->error('饲料不足,请充值');
        }

        $baseConfig = unserialize(Db::name('system')->where('name','base_config')->value('value'));
        $userPigsCount = Db::name('pig_order')->where(['uid'=>$this->user_id])->order('id','desc')->count();
        if (isset($baseConfig['qiangdan_limit'])&&$userPigsCount>=$baseConfig['qiangdan_limit']){
            $this->error('您库存的宠物超过最大限额，请等待成熟转让后再来抢哦');
        }

        $insertData = [];

        $insertData['uid'] = $this->user_id;
        $insertData['pig_id'] = $pig_id;
        $insertData['create_time'] = time();
        $insertData['user_sort'] = $this->user['trade_order'];
        $insertData['credit_score'] = $this->user['credit_score'];
        $insertData['buy_type'] = 0;

        $insertData['pay_points'] = $pigInfo['pay_points'];
        $re = Db::name('yuyue')->insert($insertData);
        if ($re) {
            //减少饲料
            moneyLog($this->user_id,0,'pay_points',-$pigInfo['pay_points'],3,'预约宠物');
            //生成订单hfh 0213
        /*    $pMap=[];
            $pMap['pig_id'] =  $pig_id;
            $pMap['status'] = 1;
            $pMap['uid']=['<>',$this->user_id];
            $ps=    db::name('user_pigs')->where($pMap)->select();
            foreach ($ps as $p) {

                $oMap = [];
                $oMap['pig_id'] = $pig_id;
                $oMap['status'] = 0;
                $oMap['order_no']=create_trade_no();
                $oMap['sell_id']=$p['uid'];
                $oMap['uid']=$this->user_id;
                $oMap['create_time']=time();
                $oMap['price']=$p['price'];
                $oMap['pig_name']=$pigInfo['name'];
               


                $res2 =Db::name('pig_order')->insertGetId($oMap);
               $res= db::name('user_pig')->where('id',$p['id'])->update('order_id',$res2);

                     if(!$res){
                         continue;
                     }
break;
//                    return $res?1:0;

            }*/

            $this->success('预约成功');

        }else {
            $this->error('预约失败');
        }

    }
    public function yuyueStatus()
    {
        $id = $this->request->param('id');

        $map = [];
        $map['uid'] = $this->user_id;
        $map['pig_id'] = $id;
        $map['status'] = 0;
        $res = Db::name('yuyue')->where($map)->find();

        $code = $res ? 1 : 0;
        return json(['code'=>$code]);

    }
    public function checkOpen()
    {

//hfh 2013
        $id = $this->request->param('id');
//dump($id);
//        //查找可出售的猪
//        $pigMap = [];
//        $pigMap['pig_id'] = $id;
//        //$pigMap['from_id'] = 0;
//        $pigMap['status'] = 1;
//
        $pigMap = [];
        $pigMap['pig_id'] = $id;
        //$pigMap['from_id'] = 0;
        $pigMap['status'] = 0;
        $map['user_sort'] = ['<>', 0];

        $piglist = Db::name('pig_order')->where($pigMap)->select();

// hfh 2013
//        dump($piglist);
        //查询预约的人
        $userMap = [];
        $userMap['pig_id'] = $id;
        $userMap['status'] = 0;
//        $userMap['buy_type'] = ['<>', 0]; //buy_type0只预约，1只抢购，2预约加抢购    只预约了，是不能参与的
        $userList = Db::name('yuyue')->where($userMap)->order('create_time,credit_score')->select();
//        dump($userList);
        $redisArr = [];
        $redisName = 'buy_'.date('Ymd').$id;
        if (!empty($piglist)) {
            //有卖单
            foreach ($piglist as $val) {

                //是否有指定
                if ($val['point_id']) {
                    $uid = $val['point_id'];
                } else {
                    $uid = $this->createUserId($val['pig_id'], $val['uid']);
                    if (!$uid) break;

                }

                //hfh 2013  uid 返回买家id

//                $dd[]

                //改变订单
                Db::name('pig_order')
                    ->where('id', $val['id'])
                    ->update([
                        'status' => 1,
                        'uid' => $uid,
                        'sell_id' => $val['uid'],
                        'create_time' => time()
                    ]);
                //改变用户猪的状态
                Db::name('user_pigs')->where('order_id', $val['id'])->setField('status', 3);
                //改变预约状态
                Db::name('yuyue')->where('uid', $uid)->where($userMap)->setField('status', 1);
                array_push($redisArr, $uid);

            }
        }
//        dump($redisArr);

        Cache::set($redisName,$redisArr,86400);
        //dump($id);
     /*   $is_open = Cache::get('is_open'.$id);
        dump($is_open);*/
      /*  if (!$is_open) {
            return json(['code'=>0,'msg'=>'未开奖']);
        } else {*/
            $luckyUsers = Cache::get('buy_'.date('Ymd').$id);
//            dump($luckyUsers);

            $uid = $this->user_id;
            if (!empty($luckyUsers)) {
                if (in_array($uid,$luckyUsers)) {
                    return json(['code'=>1,'msg'=>'恭喜']);
                } else {
                    return json(['code'=>2,'msg'=>'很遗憾']);
                }
            }else{
                return json(['code'=>2,'msg'=>'很遗憾']);
            }

        }

    /*}*/

    public function createUserId($pig_id, $sell_id)
{
//hfh 0213
    $userMap = [];
    $userMap['pig_id'] = $pig_id;
    $userMap['status'] = 0;
    //所有指定的用户ID
    $pointIds = Db::name('user_pigs')->where('point_id', '<>', 0)->column('point_id');
    array_push($pointIds, $sell_id);
    $userMap['uid'] = ['not in', $pointIds];//hfh 不是自己
    $userMap['user_sort'] = ['<>', 0];
//    $userMap['buy_type']  = ['<>', 0];//buy_type0只预约，1只抢购，2预约加抢购    只预约了，是不能参与的

        //hfh 0213 按时间信用区配
    $yuyue = Db::name('yuyue')->where($userMap)->order('create_time,credit_score', 'desc')->find();
    return $yuyue['uid'];

}


    public function flash_buy()
    {
        $data = $this->request->param();
        //dump($data);
        $pig_id = $data['id'];
        $pigInfo =  Db::name('task_config')->where('id',$pig_id)->find();
        $nowTime = date('H:i');
        if ($nowTime<$pigInfo['start_time'] || $nowTime>$pigInfo['end_time'])
        {
            $this->error('不是开抢时间');
        }
        //是否实名通过
        $authMap = [];
        $authMap['uid'] = $this->user_id;
        $authMap['status'] = 1;
        if (!Db::name('identity_auth')->where($authMap)->find()) $this->error('请先实名');


        $baseConfig = unserialize(Db::name('system')->where('name','base_config')->value('value'));
        $userPigsCount = Db::name('pig_order')->where(['uid'=>$this->user_id])->order('id','desc')->count();
        if (isset($baseConfig['qiangdan_limit'])&&$userPigsCount>=$baseConfig['qiangdan_limit']){
            $this->error('您库存的宠物超过最大限额，请等待成熟转让后再来抢哦');
        }

        $today = strtotime(date('Y-m-d'));
        $map = [];
        $map['uid'] = $this->user_id;
        $map['pig_id'] = $pig_id;
        $map['status'] = 1;
        $map['create_time'] = ['gt',$today];
        $alread_res = Db::name('yuyue')->where($map)->find();
        if($alread_res){
            $this->error('您今天已经抢到一个'.$pigInfo['name'].'了，明天再来哦');
        }

        $map = [];
        $map['uid'] = $this->user_id;
        $map['pig_id'] = $pig_id;
        $map['status'] = 0;
        $insertData['buy_type'] = 1;
        $res = Db::name('yuyue')->where($map)->find();

        if(!$res){
            //饲料
            if ($this->user['pay_points']<$pigInfo['qiang_points']){
                $this->error('饲料不足,请充值');
            }

            $insertData = [];

            $insertData['uid'] = $this->user_id;
            $insertData['pig_id'] = $pig_id;
            $insertData['create_time'] = time();
            $insertData['user_sort'] = $this->user['trade_order'];
            $insertData['credit_score'] = $this->user['credit_score'];
            $insertData['buy_type'] = 1;

            $insertData['pay_points'] = $pigInfo['qiang_points'];
            $re = Db::name('yuyue')->insert($insertData);
            if ($re) {
                //减少饲料
                moneyLog($this->user_id,0,'pay_points',-$pigInfo['qiang_points'],3,'抢购宠物');
                $this->success('进入抢购成功');

            }else {
                $this->error('抢购失败');
            }
        }else if($this->isYuyue($pig_id)){
            $map = [];
            $map['uid'] = $this->user_id;
            $map['pig_id'] = $pig_id;
            $map['status'] = 0;
            $insertData['buy_type'] = ['<>', 1];
            //已经预约的，修改bug_type为2
            $re = Db::name('yuyue')->insert($insertData);
            Db::name('yuyue')->where($map)->update(['buy_type'=>2]);
            $this->success('进入抢购成功');
        }else{
            $this->success('进入抢购成功');
        }
    }

    public function checkFlushOpen()
    {
        $id = $this->request->param('id');
        $config = unserialize(Db::name('system')->where('name','base_config')->value('value'));
//        dump($config);die;
        if(isset($config['jk_open'])&&$config['jk_open']){
            $result = $this->lijiqiang($id);
            if($result==1){
                return json(['code'=>1,'msg'=>'恭喜']);
            }else if($result==2){
                return json(['code'=>2,'msg'=>'很遗憾']);
            }else{
                return json(['code'=>0,'msg'=>'未开奖']);
            }
        }else{
            $endtime = $this->request->param('endtime');
            $uid = $this->user_id;
            $nowTime = date('H:i:s',time()-90);

            $is_open = Cache::get('is_open'.$id);
            if (!$is_open || $nowTime<=$endtime) {
                return json(['code'=>0,'msg'=>'未开奖']);
            } else {
                $luckyUsers = Cache::get('buy_'.date('Ymd'). $id);
                //dump($luckyUsers);die;

                if (!empty($luckyUsers)) {
                    if (in_array($uid,$luckyUsers)) {
                        return json(['code'=>1,'msg'=>'恭喜']);
                    } else {
                        return json(['code'=>2,'msg'=>'很遗憾']);
                    }
                }else{
                    return json(['code'=>2,'msg'=>'很遗憾']);
                }

            }
        }


    }


    public function lijiqiang($id){
        $map['id'] = $id;
        $map['is_open'] = 0;
        $pigInfo = Db::name('task_config')->where($map)->order('start_time')->find();
        if (!$pigInfo) return 0;
        //查找可出售的猪
        $pigMap = [];
        $pigMap['pig_id'] = $id;
        $pigMap['status'] = 0;
        $piglist = Db::name('pig_order')->where($pigMap)->select();

        //查询预约的人
        $userMap = [];
        $userMap['uid'] = $this->user_id;
        $userMap['pig_id'] = $id;
        $userMap['status'] = 0;
        $userMap['buy_type'] = ['<>', 0]; //buy_type0只预约，1只抢购，2预约加抢购    只预约了，是不能参与的

        $yuyueInfo = Db::name('yuyue')->where($userMap)->find();
// dump($yuyueInfo);die;
        $uid = $this->user_id;
        if (!empty($piglist) && $yuyueInfo) {
            //有卖单
            foreach ($piglist as $val) {
                if($val['uid']==$uid){
                    continue;//不能抢自己的
                }

                //改变订单
                Db::name('pig_order')
                    ->where('id', $val['id'])
                    ->update([
                        'status' => 1,
                        'uid' => $uid,
//                        'sell_id' => $val['uid'],
                        'create_time' => time()
                    ]);
                //改变用户猪的状态
                Db::name('user_pigs')->where('order_id', $val['id'])->setField('status', 3);
                //改变预约状态
                Db::name('yuyue')->where('uid', $uid)->where($userMap)->setField('status', 1);
                return 1;
            }
        }

        //改变预约状态
        Db::name('yuyue')->where('uid', $uid)->where($userMap)->setField('status', 2);

        if($yuyueInfo['buy_type']==1){
            moneyLog($yuyueInfo['uid'], 0, 'pay_points', $yuyueInfo['pay_points'], 4, '抢购未中奖立返');
        }else{
            moneyLog($yuyueInfo['uid'], 0, 'pay_points', $yuyueInfo['pay_points'], 4, '预约未中奖立返');
        }
        return 2;
    }




}
