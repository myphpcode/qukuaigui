<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\admin\controller;

use app\common\controller\AdminBase;
use think\Cache;
use think\Db;

/**
 * 系统配置
 * Class System
 * @package app\admin\controller
 */
class Task extends AdminBase
{
    public function _initialize()
    {
        parent::_initialize();
    }


      public function taskConfig()
      {
          //hfh 0214
         // $taskConfig = Db::name('task_config')->order('start_time','asc')->select();
          $taskConfig = Db::name('task_config')->order('id')->select();
          return view()->assign('taskConfig',$taskConfig);
      }

    /**
     * 添加任务
     * @return \think\response\View
     */
      public function taskAdd()
      {
          if ($this->request->isPost()) {
              $data = $this->request->post();
              $res = Db::name('task_config')->insert($data);
              $res ? $this->success('添加成功','taskConfig') : $this->error('操作失败');
          }
          return view();
      }

    /**
     * 任务修改
     * @return \think\response\View
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
      public function taskEdit()
      {
          $id = $this->request->param('id');
          $taskInfo = Db::name('task_config')->where('id',$id)->find();


          if ($this->request->isPost()) {
              $data = $this->request->post();
              $res = Db::name('task_config')->where('id',$data['id'])->update($data);
              //echo Db::name('task_config')->getLastSql();die;
              $res ? $this->success('修改成功','taskConfig') : $this->error('操作失败');
          }
          return view()->assign('taskInfo',$taskInfo);
      }

    /**
     * 删除
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
      public function taskDel()
      {
          $id = $this->request->param('id');
          $res = Db::name('task_config')->where('id',$id)->delete();
          $res ? $this->success('操作成功') : $this->error('操作失败');
      }
public function vip(){
    $id = $this->request->param('id');
    $taskInfo = Db::name('task_config')->where('id',$id)->find();
$vip=db::name('user')->where('ulevel',1)->select();
//dump($vip);die;
    return view()->assign(['taskInfo'=>$taskInfo,'vip'=>$vip]);
}

//hfh 0213
public function vipAdd(){

    if ($this->request->isPost()) {
        $data = $this->request->post();
$num=floor((int)$data['num']);


        $data['create_time'] = time();

        $data['from_id'] = 0;

        $data['status'] = 1;
        $data['total_revenue'] = 0;
        $data['pig_no'] = create_trade_no();
        $data['end_time'] = time();

//          dump($data);die;

        $data1=[
            'uid' => $data['uid'],
            'pig_id' => $data['pig_id'],
            'sell_id' => 0,
            'price' => $data['price'],
            'create_time' => time(),
            'status'=>0,
            'pig_name'=>$data['pig_name'],
            'order_no'=> create_trade_no()
        ];

//        dump($data1);die;
        unset($data['num']);
        for ($i=0;$i<$num;++$i){

            $userPigsId = Db::name('user_pigs')->insertGetId($data);
            //挂卖到交易市场
            $newOrderId = Db::name('PigOrder')->insertGetId($data1);
            $dd['order_id']=$newOrderId;
            $res = Db::name('user_pigs')->where('id',$userPigsId)->update($dd);
        }


        $res ? $this->success('添加成功', 'taskConfig') : $this->error('操作失败');
    }
}
public function _vipAdd(){
    if ($this->request->isPost()) {
        $data = $this->request->post();

        $data['create_time']=time();
$data1=$data;
        $data['from_id']=0;

        $data['status']=1;
        $data['total_revenue']=$data['contract_revenue']*$data['price']/100;
        $data['pig_no']=create_trade_no();
        $data['end_time']=time();

        $data1['sell_id']=0;

        $data1['status']=0;
        $data1['order_no']=create_trade_no();
        unset($data1['cycle']);
        unset($data1['contract_revenue']);
        unset($data1['doge']);
//          dump($data1);die;
        $res1 = Db::name('user_pigs')->insertGetId($data);
        $res2 = Db::name('pig_order')->insertGetId($data1);
        $dd['order_id']=$res2;
        $res = Db::name('user_pigs')->where('id',$res1)->update($dd);
        $res ? $this->success('添加成功','taskConfig') : $this->error('操作失败');








//        dump($data);die;
//        $res = Db::name('user_pigs')->insert($data);
//        $res2 = Db::name('pig_order')->insertGetId($data);
  /*      $data1['order_id']=$res1;
        $data1['pig_no']=$data['order_no'];
        $data1['from_id']=$data['sell_id'];
        $data1['end_time']=time()+3600*24*$data1['cycle'];

        $data1['total_revenue']=$data1['contract_revenue']*$data1['price']/100;
        unset($data1['order_no']);
        $res2 = Db::name('user_pigs')->insert($data1);
        $res =$res1 && $res2;*/

    }

}
    /**
     * 今日开抢
     * @return \think\response\View
     * @throws \think\exception\DbException
     */
      public function nowGame()
      {
          $req = $this->request->get();
          $map = [];
          $map['status'] = 0;
          if (!empty($req['pig_id'])) $map['pig_id'] = $req['pig_id'];
          if (!empty($req['status']) && $req['status'] == '1'){
              $map['point_id'] = ['neq',''];
          }else if(!empty($req['status']) && $req['status'] == '2'){
              $map['point_id'] = null;
          }
          //dump($map);
          if (!empty($req['username'])) {
              $uid = Db::name('user')->where('mobile',$req['username'])->value('id');
              $map['uid'] = $uid;
          }
          $tasklist = Db::name('task_config')->field('id,name')->select();
          $piglist = Db::name('pig_order')
              ->where($map)
              ->order('id','desc')
              ->paginate(15,false,['query'=>$this->request->param()])
          ->each(function ($item,$key){
              $item['mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
              $item['pig_attr'] = Db::name('task_config')->where('id',$item['pig_id'])->field('name, start_time, end_time')->find();
              return $item;
          });
          $map['point_id'] = null;
          $Statistics['non_point_num'] = Db::name('pig_order')->where($map)->count();
          $map['point_id'] = ['neq',''];
          $Statistics['point_num'] = Db::name('pig_order')->where($map)->count();
          return view()->assign(['piglist'=>$piglist,'tasklist'=>$tasklist,'Statistics'=>$Statistics]);
      }

    /**
     * 修改价值
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
      public function editPrice()
      {
          $id = $this->request->param('id');
          //dump($id);
          $pigInfo = Db::name('pig_order')->where('id',$id)->field('id,price')->find();
          if ($this->request->isPost()) {
              $data  = $this->request->post();
              //dump($data);die;
              empty($data['price']) ? $this->error('价格不能为空') : '';
              $res = Db::name('pig_order')->where('id',$id)->setField('price',$data['price']);
              //echo Db::name('pig_order')->getLastSql();
              $res ? $this->success('修改成功') : $this->error('您没做任何修改');
          }
          //dump($pigInfo);die;
          return view()->assign('pigInfo',$pigInfo);
      }

    /**
     * 指定ID
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
      public function pointId($page = 1)
      {
          $id = $this->request->param('id');
          $pigInfo = Db::name('pig_order')->where('id',$id)->field('id,uid,pig_id,point_id')->find();
          $user_list = Db::name('user')
              ->alias('User')->join('yuyue','yuyue.uid = User.id', 'LEFT')
              ->field('User.*')
              ->where(['yuyue.pig_id'=>$pigInfo['pig_id'],'yuyue.status'=>'0'])
              ->paginate(15,false,['query'=>$this->request->param()]);
          if ($this->request->isPost()) {
              $data  = $this->request->post();
              //不能指定给自己
              if ($data['uid'] == $pigInfo['uid']) $this->error('不能指定给卖家');
              //是否预约
              $yyMap = [];
              $yyMap['uid'] = $data['uid'];
              $yyMap['pig_id'] = $pigInfo['pig_id'];
              $yyMap['status'] = 0;
              if (!Db::name('yuyue') ->where($yyMap)->find())
              {
                  $this->error('此用户还没预约');
              }
              //是否禁止排单
              $tradeOrder = Db::name('user')->where('id',$data['uid'])->value('trade_order');
              if ($tradeOrder==0) $this->error('此用户禁止排单');
              $res = Db::name('pig_order')->where('id',$id)->setField('point_id',$data['uid']);
              $res ? $this->success('修改成功') : $this->error('您没做任何修改');
          }
          return view()->assign(['pigInfo'=>$pigInfo,'user_list'=>$user_list]);
      }

    /**
     * 预约管理
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
      public function yuyue()
      {
          $req = $this->request->get();
          //dump($req);die;
          $map = [];
          if (!empty($req['status']) && $req['status']!='') {
              $map['status'] = $req['status'] == 3 ? '0' : $req['status'];
          }
          //$map['status'] = 1;c
          if (!empty($req['pig_id'])) $map['pig_id'] = $req['pig_id'];
          //dump($map);
          if (!empty($req['username'])) {
              $uid = Db::name('user')->where('mobile',$req['username'])->value('id');
              $map['uid'] = $uid;
          }
          if (!empty($req['start_time']) && !empty($req['end_time'])) {
              $map['create_time'] = ['between',[strtotime($req['start_time']),strtotime($req['end_time'])+86400]];
          } elseif (!empty($req['start_time']) && empty($req['end_time'])) {
              $map['create_time'] = ['gt',strtotime($req['start_time'])];
          } elseif (empty($req['start_time']) && !empty($req['end_time'])) {
              $map['create_time'] = ['lt',strtotime($req['end_time'])+86400];
          }

          //dump($map);die;
          //echo strtotime($req['start_time']);
          $list = Db::name('yuyue')
              ->where($map)
              ->order('create_time','desc')
              ->paginate(15,false,['query'=>$this->request->param()])
              ->each(function ($item,$key){
                  $item['mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
                  $item['pig_level'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
                  return $item;
              });
          //echo Db::name('yuyue')->getLastSql();die;
          unset($map['uid']);
          $piggroup =  Db::name('yuyue')->where($map)->group('pig_id')->field('count(pig_id) as c, pig_id')->select();
          foreach($piggroup as &$item){
              $item['pig_name'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
          };
          $tasklist = Db::name('task_config')->field('id,name')->select();
          return view()->assign(['list'=>$list,'tasklist'=>$tasklist,'piggroup'=>$piggroup]);
      }

    /**
     * 订单列表
     * @return \think\response\View
     * @throws \think\exception\DbException
     */
      public function pigOrder()
      {
          $data = $this->request->param();
          //dump($data);die;
          $map = [];
          if (!empty($data['buy_mobile'])) {
              $map['uid'] = Db::name('user')->where('mobile',$data['buy_mobile'])->value('id');
          }
          if (!empty($data['sell_mobile'])) {
              $map['sell_id'] = Db::name('user')->where('mobile',$data['sell_mobile'])->value('id');
          }
          if (!empty($data['pig_id'])) {
              $map['pig_id'] = $data['pig_id'];
          }
          if (!empty($data['status']) && $data['status']!='') {
              $map['status'] = $data['status'];
          }else{
              $map['status'] = ['gt',0];
          }
          $orderlist = Db::name('pig_order')
              ->where($map)
              ->order('id','desc')
              ->paginate(15,false,['query'=>$this->request->param()])
          ->each(function ($item,$key){
              $item['buy_mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
              $item['sell_mobile'] = Db::name('user')->where('id',$item['sell_id'])->value('mobile');
              $item['pig_name'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
              return $item;
          });
          //猪的种类
          $piglist = Db::name('task_config')->field('id,name')->select();
          return view()->assign(['orderlist'=>$orderlist,'piglist'=>$piglist]);
      }

    /**
     * 取消订单
     */
      public function orderDel()
      {
          $id = $this->request->param('order_id');
         //dump($id);
          $res = model('PigOrder')->cancel($id);
          $res ? $this->success('操作成功') : $this->error('操作失败');
      }

    /**
     * 订单确认
     */
      public function orderConfirm()
      {
          $id = $this->request->param('order_id');
          //dump($id);
          $res = model('PigOrder')->confirm($id);
          $res ? $this->success('操作成功') : $this->error('操作失败');
      }
      public function orderUnlock()
      {
          $id = $this->request->param('order_id');
          //dump($id);
          $res = model('PigOrder')->where('id',$id)->update(['is_lock'=>0,'update_time'=>time()]);
          $res ? $this->success('操作成功') : $this->error('操作失败');
      }

    /**
     * 申诉列表
     * @return $this
     */
    public function shensu()
    {
        $orderlist = Db::name('shensu')
            ->paginate(15,false,['query'=>$this->request->param()])
            ->each(function ($item,$key){
                $item['user_mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
                //$item['sell_mobile'] = Db::name('user')->where('id',$item['sell_id'])->value('mobile');
                //$item['pig_name'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
                return $item;
            });
        return view()->assign('orderlist',$orderlist);
    }

    public function shensuConfirm()
    {
        $id = $this->request->param('order_id');
        //申诉信息
        $ssInfo = Db::name('shensu')->where('id',$id)->find();
        //订单信息
        $orderInfo = Db::name('pig_order')->where('id',$ssInfo['order_id'])->find();
        if ($ssInfo['uid'] == $orderInfo['uid']) {
           $conres =  model('PigOrder')->confirm($orderInfo['id']);
        } else {
            $conres = model('PigOrder')->cancel($orderInfo['id']);
        }
        //改变申诉状态
        if ($conres) {
            Db::name('shensu')->where('id',$id)->setField('status',1);
            $this->success('处理成功');
        } else {
            $this->error('处理失败');
        }
    }

    /**
     * 用户的宠物
     * @return $this
     */
    public function userPigs()
    {
        $data = $this->request->param();
        $map = [];
        if (!empty($data['username'])) {
            $map['uid'] = Db::name('user')->where('mobile',$data['username'])->value('id');
        }
        if (!empty($data['pig_id'])) {
            $map['pig_id'] = $data['pig_id'];
        }
        if (!empty($data['status']) && $data['status']!='') {
            $map['status'] = $data['status'] == 2 ? 0 : $data['status'];
        }

        if (!empty($data['buy_start_time']) && !empty($data['buy_end_time'])) {
            $map['create_time'] = ['between',[strtotime($data['buy_start_time']),strtotime($data['buy_end_time'])+86400]];
        } elseif (!empty($data['buy_start_time']) && empty($data['buy_end_time'])) {
            $map['create_time'] = ['gt',strtotime($data['buy_start_time'])];
        } elseif (empty($data['buy_start_time']) && !empty($data['buy_end_time'])) {
            $map['create_time'] = ['lt',strtotime($data['buy_end_time'])+86400];
        }
        if (!empty($data['sell_start_time']) && !empty($data['sell_end_time'])) {
            $map['end_time'] = ['between',[strtotime($data['sell_start_time']),strtotime($data['sell_end_time'])+86400]];
        } elseif (!empty($data['sell_start_time']) && empty($data['sell_end_time'])) {
            $map['end_time'] = ['gt',strtotime($data['sell_start_time'])];
        } elseif (empty($data['sell_start_time']) && !empty($data['sell_end_time'])) {
            $map['end_time'] = ['lt',strtotime($data['sell_end_time'])+86400];
        }
        $tasklist = Db::name('task_config')->field('id,name')->select();
        $piglist = Db::name('user_pigs')
            ->where($map)
            ->order('create_time desc')
            ->paginate(15,false,['query'=>$this->request->param()])
            ->each(function ($item,$key){
                $item['mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
                $item['pig_level'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
                if($item['total_revenue'] >0){
                    $item['buy_price'] = $item['price'] - $item['total_revenue'];
                    $item['sell_price'] = $item['price'];
                }else{
                    $item['buy_price'] = $item['price'];
                    $item['sell_price'] = 0;
                }
                $item['days'] = intval(($item['end_time'] - time())/86400);
                $item['days'] = $item['days'] < 1 ? 0 : $item['days'];
                return $item;
            });
        return view()->assign(['tasklist'=>$tasklist,'piglist'=>$piglist]);
    }

    public function userPigDel()
    {
        $id = $this->request->param('id');
        $userPig = Db::name('user_pigs')->where('id',$id)->find();
        //添加到删除记录表
        $res1 = Db::name('delete_pigs')->insert([
           'uid'=>$userPig['uid'],
            'pig_id'=>$userPig['pig_id'],
            'price'=>$userPig['price'],
            'status'=>$userPig['status'],
            'buy_time'=>$userPig['create_time'],
            'end_time'=>$userPig['end_time'],
            'delete_time'=>time()
        ]);
        if ($res1) {
            //删除
            $res2 = Db::name('user_pigs')->where('id',$id)->delete();
            $res2 ? $this->success('操作成功') : $this->error('操作失败');

        } else {
            $this->error('操作失败');
        }

    }

    /**
     *销毁的宠物
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function destoryPigs()
    {
        $pigList = Db::name('destory_pigs')->paginate(15,false,['query'=>$this->request->param()])
            ->each(function ($item,$key){
                $item['mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
                $item['pig_level'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
                return $item;
            });
        $taskList = Db::name('task_config')->field('id,name')->select();
        return view()->assign(['piglist'=>$pigList,'tasklist'=>$taskList]);
    }

    public function deletePigs()
    {
        $pigList = Db::name('delete_pigs')->paginate(15,false,['query'=>$this->request->param()])
            ->each(function ($item,$key){
                $item['mobile'] = Db::name('user')->where('id',$item['uid'])->value('mobile');
                $item['pig_level'] = Db::name('task_config')->where('id',$item['pig_id'])->value('name');
                return $item;
            });
        $taskList = Db::name('task_config')->field('id,name')->select();
        return view()->assign(['piglist'=>$pigList,'tasklist'=>$taskList]);
    }


}