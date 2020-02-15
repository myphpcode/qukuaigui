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
class Zonghe extends AdminBase

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

 public function addcom(){


        return $this->fetch('add');
    }
public function listcom(){
    $map = [];
    $map['ulevel']=2;
//        $user_num=[];

    $map['status'] = ['eq','1'];
    $user_list=Db::name('user')
        ->where($map)
        ->paginate(15,false);

    //echo Db::name('user')->getLastSql();die;
    return $this->fetch('list', ['user_list' => $user_list]);

}

public function reg(){
    return $this->fetch('reg');
}

    public function listreg(){
        $map = [];
        $map['ulevel']=0;
//        $user_num=[];

        $map['status'] = ['eq','1'];
        $user_list=Db::name('user')
            ->where($map)
            ->paginate(15,false);

        //echo Db::name('user')->getLastSql();die;
        return $this->fetch('listreg', ['user_list' => $user_list]);

    }
    public function vip(){
        return $this->fetch('vip');
    }

    public function listvip(){
        $map = [];
        $map['ulevel']=1;
//        $user_num=[];

        $map['status'] = ['eq','1'];
        $user_list=Db::name('user')
            ->where($map)
            ->paginate(15,false);

        //echo Db::name('user')->getLastSql();die;
        return $this->fetch('listvip', ['user_list' => $user_list]);

    }

    /**
     * 保存用户
     */
    public function save()
    {
        if ($this->request->isPost()) {
//            dump($this->request->post());die;
            $data            = $this->request->except(['money','dt_money']);
            $validate_result = $this->validate($data, 'User');
            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                if ($this->user_model->reg()) {
                    $this->success('保存成功');
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }
    public function ynum(){

        $site_config = Db::name('system')->field('value')->where('name', 'base_config')->find();
        $site_config = unserialize($site_config['value']);
        $qiangdan_limit=$site_config['qiangdan_limit'];

        if ($this->request->isPost()) {
            $ddd=$this->request->param();
         $l=$ddd['qiangdan_limit'];
            $ss = Db::name('system')->field('value')->where('name', 'base_config')->find();

            $ss=unserialize($ss['value']);
            $ss['qiangdan_limit']=$l;

            $data['value']              = serialize($ss);
            if (Db::name('system')->where('name', 'base_config')->update($data) !== false) {
                $this->success('提交成功');
            } else {
                $this->error('提交失败');
            }
            dump($ss);
        }

return $this->fetch('',['qiangdan_limit'=>$qiangdan_limit]);

    }
    public function noyuyue(){
        $time1=strtotime(date("Y-m-d",time()));
        $time2=$time1+3600*24;
$map=[];
        $map['create_time']=['between',[$time1,$time2]];

     $res =   db::name('yuyue')->where($map)->where('status',1)->select();
        foreach ($res as $v){
           $uid=$v['uid'];
          $pig_id=$v['pig_id'];
          $m=[];
          $m['uid']=$v['uid'];
          $m['pig_id']=$v['pig_id'];

        $r  =db::name('pig_order')->where($m)->order('create_time')->find();
   if( $r['create_time']<(time()-3600*2) &&$r['status']==0){

     $price=  $r['price'];
      $no_num= db::name('user')->where('id',$v['uid'])->value('no_num');
       switch ($no_num){
           case  0:
               db::name('user')->where('id',$v['uid'])->setInc('no_num',1);
               db::name('user')->where('id',$v['uid'])->setInc('pay_points',-$price*0.3);
               break;
           case 1:
               db::name('user')->where('id',$v['uid'])->setInc('no_num',1);
               db::name('user')->where('id',$v['uid'])->setInc('pay_points',-$price*0.5);
               break;
           case 2:
               db::name('user')->where('id',$v['uid'])->setInc('no_num',1);
               db::name('user')->where('id',$v['uid'])->setField(['pay_points'=>0,'status'=>0]);
       }


   }

        }
        $user_list =   db::name('user')->where('no_num','neq',0)->paginate();
      return  $this->fetch('',['user_list'=>$user_list]);
    }
}