<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\admin\controller;

use app\common\controller\AdminBase;
use app\common\model\User as UserModel;
use think\Cache;
use think\Db;

/**
 * 系统配置
 * Class System
 * @package app\admin\controller
 */
class Shuju extends AdminBase

{
    protected $user_model;

    public function _initialize()
    {
        parent::_initialize();
        $this->user_model = new UserModel();
    }


    /**
     * 站点配置
     */
    public function index()
    {
        return 111;
    }

    /**
     * 订单列表
     * @return \think\response\View
     * @throws \think\exception\DbException
     */
    public function jiaoYi()
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

    public function vip(){

       $vids= DB::name('user')->where('ulevel',1)->column('id');
       $m['uid']=['in',$vids];
//       $m['sell_id']=['in',$vids];
       $m['status']=3;
//       $m['sell_id']=['neq',0];

      $order1=db::name('pig_order')->where($m)->field(['uid'=>'vipid',"count('uid')"=>"buy_num","sum(price)"=>'price_sum'])->group('uid')->select();
//        $sm['uid']=['in',$vids];
       $sm['sell_id']=['in',$vids];
       $sm['status']=3;
//       $sm['sell_id']=['neq',0];

        $order2=db::name('pig_order')->where($sm)->field(['sell_id'=>'vipid',"count('sell_id')"=>"sell_num","sum(price)"=>'price_sum'])->group('sell_id')->select();

//             dump($order1);die;


         return $this->fetch('',['order1'=>$order1,'order2'=>$order2]);
    }

}