-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2020-02-07 18:10:09
-- 服务器版本： 8.0.12
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `xingfu`
--

-- --------------------------------------------------------

--
-- 表的结构 `wym_admin_user`
--

CREATE TABLE `wym_admin_user` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

--
-- 转存表中的数据 `wym_admin_user`
--

INSERT INTO `wym_admin_user` (`id`, `username`, `password`, `status`, `create_time`, `last_login_time`, `last_login_ip`) VALUES
(1, 'admin', '74020a2d4667655ed401a7729ed2844b', 1, '2016-10-18 15:28:37', '2020-02-05 15:47:59', '127.0.0.1'),
(3, 'admin2', 'd97986b84950f0213ebc5c4e2bca288a', 1, '2019-06-27 21:11:08', '2019-08-04 16:49:49', '111.173.132.159'),
(4, 'admin3', 'd97986b84950f0213ebc5c4e2bca288a', 1, '2019-06-27 21:11:18', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `wym_article`
--

CREATE TABLE `wym_article` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '文章ID',
  `cid` smallint(5) UNSIGNED NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `introduction` varchar(255) DEFAULT '' COMMENT '简介',
  `content` longtext COMMENT '内容',
  `author` varchar(20) DEFAULT '' COMMENT '作者',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '状态 0 待审核  1 审核',
  `reading` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '阅读量',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `photo` text COMMENT '图集',
  `is_top` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否置顶  0 不置顶  1 置顶',
  `is_recommend` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否推荐  0 不推荐  1 推荐',
  `sort` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `publish_time` datetime NOT NULL COMMENT '发布时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章表';

--
-- 转存表中的数据 `wym_article`
--

INSERT INTO `wym_article` (`id`, `cid`, `title`, `introduction`, `content`, `author`, `status`, `reading`, `thumb`, `photo`, `is_top`, `is_recommend`, `sort`, `create_time`, `publish_time`) VALUES
(5, 1, '热烈庆祝！翠通国际JCTP于2018年9月11日正式上线运行！', '热烈庆祝！翠通国际JCTP于2018年9月11日正式上线运行！', '<p><span style=\"color: rgb(255, 0, 0);\">热烈庆祝！翠通国际JCTP于2018年9月11日正式上线运行！</span></p>', '翠通国际', 1, 0, '', NULL, 1, 1, 0, '2018-09-10 11:48:39', '2018-09-10 11:48:40');

-- --------------------------------------------------------

--
-- 表的结构 `wym_auth_group`
--

CREATE TABLE `wym_auth_group` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL COMMENT '权限规则ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限组表';

--
-- 转存表中的数据 `wym_auth_group`
--

INSERT INTO `wym_auth_group` (`id`, `title`, `status`, `rules`) VALUES
(1, '超级管理组', 1, '1,2,3,74,5,6,7,8,9,10,11,14,13,22,24,15,27,29,30,16,18,49,50,51,52,53,19,31,32,33,34,35,36,37,54,55,60,62,56,65,67,82,87,95,96,109,115,88,89,90,91,114,116,111,117,118,119,120,123,124,125,121,122,126');

-- --------------------------------------------------------

--
-- 表的结构 `wym_auth_group_access`
--

CREATE TABLE `wym_auth_group_access` (
  `uid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限组规则表';

--
-- 转存表中的数据 `wym_auth_group_access`
--

INSERT INTO `wym_auth_group_access` (`uid`, `group_id`) VALUES
(1, 1),
(3, 1),
(4, 1);

-- --------------------------------------------------------

--
-- 表的结构 `wym_auth_rule`
--

CREATE TABLE `wym_auth_rule` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(20) NOT NULL,
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `pid` smallint(5) UNSIGNED NOT NULL COMMENT '父级ID',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `sort` tinyint(4) UNSIGNED NOT NULL COMMENT '排序',
  `condition` char(100) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='规则表';

--
-- 转存表中的数据 `wym_auth_rule`
--

INSERT INTO `wym_auth_rule` (`id`, `name`, `title`, `type`, `status`, `pid`, `icon`, `sort`, `condition`) VALUES
(1, 'admin/System/default', '系统配置', 1, 1, 0, 'fa fa-gears', 99, ''),
(2, 'admin/System/siteConfig', '站点配置', 1, 1, 1, '', 0, ''),
(3, 'admin/System/updateSiteConfig', '更新配置', 1, 0, 1, '', 0, ''),
(5, 'admin/Menu/default', '菜单管理', 1, 1, 0, 'fa fa-bars', 0, ''),
(6, 'admin/Menu/index', '后台菜单', 1, 1, 5, '', 0, ''),
(7, 'admin/Menu/add', '添加菜单', 1, 0, 6, '', 0, ''),
(8, 'admin/Menu/save', '保存菜单', 1, 0, 6, '', 0, ''),
(9, 'admin/Menu/edit', '编辑菜单', 1, 0, 6, '', 0, ''),
(10, 'admin/Menu/update', '更新菜单', 1, 0, 6, '', 0, ''),
(11, 'admin/Menu/delete', '删除菜单', 1, 0, 6, '', 0, ''),
(13, 'admin/Article/cate_index', '栏目管理', 1, 1, 14, 'fa fa-sitemap', 0, ''),
(14, 'admin/Content/default', '内容管理', 1, 0, 0, 'fa fa-file-text', 0, ''),
(15, 'admin/Article/index', '文章管理', 1, 1, 14, '', 0, ''),
(16, 'admin/User/default', '用户管理', 1, 1, 0, 'fa fa-users', 0, ''),
(17, 'admin/User/index', '会员列表', 1, 1, 16, '', 90, ''),
(18, 'admin/Admin/index', '管理员', 1, 1, 16, '', 99, ''),
(19, 'admin/AuthGroup/index', '权限组', 1, 1, 16, '', 98, ''),
(22, 'admin/Article/cate_edit', '编辑栏目', 1, 0, 13, '', 0, ''),
(24, 'admin/Article/cate_delete', '删除栏目', 1, 0, 13, '', 0, ''),
(27, 'admin/Article/edit', '编辑文章', 1, 0, 15, '', 0, ''),
(29, 'admin/Article/delete', '删除文章', 1, 0, 15, '', 0, ''),
(30, 'admin/Article/toggle', '文章审核', 1, 0, 15, '', 0, ''),
(31, 'admin/AuthGroup/add', '添加权限组', 1, 0, 19, '', 0, ''),
(32, 'admin/AuthGroup/save', '保存权限组', 1, 0, 19, '', 0, ''),
(33, 'admin/AuthGroup/edit', '编辑权限组', 1, 0, 19, '', 0, ''),
(34, 'admin/AuthGroup/update', '更新权限组', 1, 0, 19, '', 0, ''),
(35, 'admin/AuthGroup/delete', '删除权限组', 1, 0, 19, '', 0, ''),
(36, 'admin/AuthGroup/auth', '授权', 1, 0, 19, '', 0, ''),
(37, 'admin/AuthGroup/updateAuthGroupRule', '更新权限组规则', 1, 0, 19, '', 0, ''),
(44, 'admin/User/add', '添加用户', 1, 0, 17, '', 0, ''),
(45, 'admin/User/save', '保存用户', 1, 0, 17, '', 0, ''),
(46, 'admin/User/edit', '编辑用户', 1, 1, 17, '', 0, ''),
(47, 'admin/User/update', '更新用户', 1, 1, 17, '', 0, ''),
(49, 'admin/Admin/add', '添加管理员', 1, 0, 18, '', 0, ''),
(50, 'admin/Admin/save', '保存管理员', 1, 0, 18, '', 0, ''),
(51, 'admin/Admin/edit', '编辑管理员', 1, 0, 18, '', 0, ''),
(52, 'admin/Admin/update', '更新管理员', 1, 0, 18, '', 0, ''),
(53, 'admin/Admin/delete', '删除管理员', 1, 0, 18, '', 0, ''),
(54, 'admin/Slide/default', '扩展管理', 1, 1, 0, 'fa fa-wrench', 0, ''),
(55, 'admin/Slide/cate_index', '轮播分类', 1, 1, 54, '', 0, ''),
(56, 'admin/Slide/index', '轮播图管理', 1, 1, 54, '', 0, ''),
(60, 'admin/Slide/cate_edit', '编辑分类', 1, 0, 55, '', 0, ''),
(62, 'admin/Slide/cate_delete', '删除分类', 1, 0, 55, '', 0, ''),
(65, 'admin/Slide/edit', '编辑轮播', 1, 1, 56, '', 0, ''),
(67, 'admin/Slide/delete', '删除轮播', 1, 0, 56, '', 0, ''),
(74, 'admin/Admin/updatePassword', '修改密码', 1, 0, 1, '', 0, ''),
(75, 'admin/user/tj_net', '会员推荐图', 1, 1, 16, '', 0, ''),
(76, 'admin/user/jd_net', '节点图', 1, 0, 16, '', 0, ''),
(82, 'admin/wealth/default', '财富管理', 1, 1, 0, 'fa fa-money', 9, ''),
(87, 'admin/Wealth/setWealth', '充值扣款', 1, 0, 82, '', 0, ''),
(88, 'admin/Shop/default', '商城管理', 1, 0, 0, 'fa fa-home', 90, ''),
(89, 'admin/Shop/index', '商品列表', 1, 1, 88, 'fa fa-home', 0, ''),
(90, 'admin/Shop/cate', '商品分类', 1, 1, 88, '', 0, ''),
(91, 'admin/Shop/order', '订单列表', 1, 1, 88, '', 0, ''),
(93, 'admin/System/baseConfig', '参数配置', 1, 1, 1, '', 0, ''),
(95, 'admin/Shop/withdraw', '提现管理', 1, 1, 82, '', 0, ''),
(96, 'admin/Wealth/index', '全部记录', 1, 1, 82, '', 20, ''),
(104, 'admin/System/marketConfig', '团队奖励', 1, 1, 1, '', 0, ''),
(105, 'admin/System/userLevel', '会员级别', 1, 1, 1, '', 0, ''),
(106, 'admin/System/videoUpload', '新闻公告', 1, 1, 1, '', 0, ''),
(107, 'admin/System/qgPrice', '果实价格设置', 1, 0, 1, '', 0, ''),
(109, 'admin/Wealth/applyRecharge', '充值列表', 1, 1, 82, '', 0, ''),
(110, 'admin/User/identityAuth', '实名管理', 1, 1, 16, '', 0, ''),
(111, 'admin/Task/taskConfig', '宠物列表', 1, 1, 116, '', 0, ''),
(112, 'admin/System/personsConfig', '团队人数配置', 1, 0, 1, '', 0, ''),
(113, 'admin/Wealth/editRecharge', '平台二维码', 1, 1, 1, '', 0, ''),
(114, 'admin/Shop/zcConfig', '众筹管理', 1, 1, 88, '', 0, ''),
(115, 'admin/Wealth/tradeList', '交易管理', 1, 0, 82, '', 0, ''),
(116, 's', '抢狗管理', 1, 1, 0, 'fa fa-bars', 0, ''),
(117, 'admin/Task/nowGame', '今日出售', 1, 1, 116, '', 0, ''),
(118, 'admin/Task/yuyue', '预约列表', 1, 1, 116, '', 0, ''),
(119, 'admin/Task/pigOrder', '交易管理', 1, 1, 116, '', 0, ''),
(120, 'admin/Task/shensu', '申诉管理', 1, 1, 116, '', 0, ''),
(121, '11', '统计报表', 1, 1, 0, 'fa fa-home', 0, ''),
(122, 'admin/Tongji/user', '会员统计', 1, 1, 121, '', 0, ''),
(123, 'admin/Task/userPigs', '领养会员列表', 1, 1, 116, '', 0, ''),
(124, 'admin/Task/destoryPigs', '销毁的宠物', 1, 1, 116, '', 0, ''),
(125, 'admin/Task/deletePigs', '删除的宠物', 1, 1, 116, '', 0, ''),
(126, 'admin/Tongji/pet', '宠物统计', 1, 1, 121, '', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `wym_bank`
--

CREATE TABLE `wym_bank` (
  `id` int(15) UNSIGNED NOT NULL,
  `uid` int(15) NOT NULL DEFAULT '0',
  `true_name` varchar(255) NOT NULL DEFAULT '0',
  `bank_num` varchar(50) NOT NULL DEFAULT '0',
  `bank_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '银行名称',
  `branch` varchar(255) NOT NULL DEFAULT '0' COMMENT '支行',
  `address` varchar(255) NOT NULL,
  `create_time` int(13) NOT NULL DEFAULT '0',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='银行卡信息';

-- --------------------------------------------------------

--
-- 表的结构 `wym_bonus`
--

CREATE TABLE `wym_bonus` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT '0',
  `username` varchar(50) DEFAULT NULL,
  `from_uid` int(11) DEFAULT '0',
  `from_username` varchar(50) DEFAULT '0',
  `type` tinyint(3) DEFAULT '0' COMMENT '1动态奖2分红奖',
  `sourcemoney` decimal(10,2) DEFAULT '0.00' COMMENT '奖金来源表',
  `realmoney` decimal(10,2) DEFAULT '0.00' COMMENT '真实来源',
  `rate` decimal(10,2) DEFAULT '0.00',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  `addtime` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `wym_category`
--

CREATE TABLE `wym_category` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `alias` varchar(50) DEFAULT '' COMMENT '导航别名',
  `content` longtext COMMENT '分类内容',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `icon` varchar(20) DEFAULT '' COMMENT '分类图标',
  `list_template` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `detail_template` varchar(50) DEFAULT '' COMMENT '分类详情模板',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '分类类型  1  列表  2 单页',
  `sort` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `path` varchar(255) DEFAULT '' COMMENT '路径',
  `create_time` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分类表';

--
-- 转存表中的数据 `wym_category`
--

INSERT INTO `wym_category` (`id`, `name`, `alias`, `content`, `thumb`, `icon`, `list_template`, `detail_template`, `type`, `sort`, `pid`, `path`, `create_time`) VALUES
(1, '公告', '', '', '', '', '', '', 1, 0, 0, '0,', '2016-12-22 18:22:24'),
(2, '关于', 'JCTP翠通国际', '<p>全球翡翠信用交易平台翠通国际JCTP</p>', '', '', '', '', 2, 0, 0, '0,', '2018-06-29 15:06:02');

-- --------------------------------------------------------

--
-- 表的结构 `wym_delete_pigs`
--

CREATE TABLE `wym_delete_pigs` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `pig_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0可出售 1已成熟',
  `price` decimal(65,2) NOT NULL DEFAULT '0.00',
  `buy_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `delete_time` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_delete_pigs`
--

INSERT INTO `wym_delete_pigs` (`id`, `uid`, `pig_id`, `status`, `price`, `buy_time`, `end_time`, `delete_time`) VALUES
(14, 1, 8, 3, '200.00', 1562138122, 1562138122, 1562472830),
(15, 1, 8, 1, '200.00', 1562138151, 1562138151, 1562472834),
(16, 56, 9, 1, '10000.00', 1562472921, 1562472921, 1562473147),
(17, 56, 9, 1, '10000.00', 1562472648, 1562472648, 1562473150),
(18, 56, 21, 1, '1000.00', 1562472162, 1562472162, 1562473154),
(19, 56, 7, 1, '600.00', 1562471691, 1562471691, 1562473157),
(20, 1, 8, 1, '300.00', 1562341194, 1562341194, 1562473159),
(21, 53, 8, 1, '110.00', 1562311005, NULL, 1562473161),
(22, 58, 21, 1, '150.00', 1562310224, 1562310224, 1562473164),
(23, 1, 8, 1, '300.00', 1562242967, 1562242967, 1562473166),
(24, 53, 20, 3, '200.00', 1562212327, 1562212327, 1562473171),
(25, 48, 8, 1, '200.00', 1562139290, 1562139290, 1562473180),
(26, 48, 7, 3, '400.00', 1562139566, 1562139566, 1562473183);

-- --------------------------------------------------------

--
-- 表的结构 `wym_destory_pigs`
--

CREATE TABLE `wym_destory_pigs` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `pig_id` int(11) NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `pig_level` varchar(12) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '0可出售 1已成熟',
  `delete_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `wym_errormoney`
--

CREATE TABLE `wym_errormoney` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT '0',
  `username` varchar(50) DEFAULT NULL,
  `walltype` varchar(50) DEFAULT '',
  `lastmoney` decimal(10,2) DEFAULT '0.00' COMMENT '上次统计金额',
  `nowmoney` decimal(10,2) DEFAULT '0.00' COMMENT '现在金额',
  `chamoney` decimal(10,2) DEFAULT '0.00' COMMENT '差额',
  `addtime` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `wym_identity_auth`
--

CREATE TABLE `wym_identity_auth` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `realname` varchar(255) DEFAULT NULL,
  `mobile` char(11) DEFAULT NULL,
  `pusername` char(11) DEFAULT NULL,
  `idCard` char(18) NOT NULL DEFAULT '',
  `bankname` varchar(255) DEFAULT NULL,
  `bankcard` varchar(255) NOT NULL DEFAULT '',
  `alipay_code` varchar(255) DEFAULT NULL,
  `alipay_img` varchar(255) DEFAULT NULL COMMENT '支付宝二维码',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0 待审核 1已审核',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='实名资料';

--
-- 转存表中的数据 `wym_identity_auth`
--

INSERT INTO `wym_identity_auth` (`id`, `uid`, `realname`, `mobile`, `pusername`, `idCard`, `bankname`, `bankcard`, `alipay_code`, `alipay_img`, `status`, `create_time`) VALUES
(28, 63, '季节咯', '13800138000', NULL, '350277196212305228', NULL, '', NULL, NULL, 1, NULL),
(27, 51, '肖景椿', '15980867967', NULL, '360733199306111212', NULL, '', NULL, NULL, 1, NULL),
(29, 1, '张三', '13523773300', NULL, '410183199912123645', NULL, '', NULL, NULL, 1, NULL),
(30, 53, '李四', '18922608764', NULL, '360785198908174253', NULL, '', NULL, NULL, 1, NULL),
(31, 58, '王麻子', '15622609979', NULL, '360785198507251234', NULL, '', NULL, NULL, 1, 1562309181),
(32, 60, '纪念币', '13333445611', NULL, '360785198507251235', NULL, '', NULL, NULL, 1, 1562464236),
(33, 63, '132456', '13800138000', NULL, '552115199908082554', NULL, '', NULL, NULL, 1, 1562471377),
(34, 61, '王麻子', '15605761443', NULL, '552115199908082554', NULL, '', NULL, NULL, 1, 1562472143),
(35, 62, '你好', '17783458776', NULL, '130685198908055231', NULL, '', NULL, NULL, 1, 1562473966),
(36, 66, 'hanhan', '18317332108', NULL, '410527198909095418', NULL, '', NULL, NULL, 1, 1580823481);

-- --------------------------------------------------------

--
-- 表的结构 `wym_money_log`
--

CREATE TABLE `wym_money_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` varchar(255) DEFAULT NULL,
  `from_id` int(11) DEFAULT NULL COMMENT '来自用户ID',
  `from_username` varchar(255) DEFAULT NULL COMMENT '来源用户名',
  `currency` varchar(25) DEFAULT 'currency',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '资产数目',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型 1系统充值 2卖出 3预约4推广收益 5团队收益',
  `note` varchar(255) DEFAULT NULL COMMENT '说明信息',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '资产记录时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='资产记录';

--
-- 转存表中的数据 `wym_money_log`
--

INSERT INTO `wym_money_log` (`id`, `user_id`, `username`, `from_id`, `from_username`, `currency`, `amount`, `type`, `note`, `create_time`) VALUES
(192, 63, '13800138000', 0, '系统操作', 'pay_points', '-6.00', 3, '预约宠物', '2020-02-05 20:34:37'),
(191, 66, '18317332108', 0, '系统操作', 'pay_points', '200.00', 1, '系统充值', '2020-02-05 20:05:55'),
(190, 66, '18317332108', 63, '13800138000', 'pay_points', '60.00', 8, '饲料转增', '2020-02-05 19:15:35'),
(189, 63, '13800138000', 66, '18317332108', 'pay_points', '-60.00', 8, '饲料转增', '2020-02-05 19:15:35'),
(188, 66, '18317332108', 0, '系统操作', 'pay_points', '10.00', 1, '系统充值', '2020-02-05 19:05:20'),
(187, 66, '18317332108', 0, '系统操作', 'pay_points', '10.00', 1, '系统充值', '2020-02-05 19:04:54');

-- --------------------------------------------------------

--
-- 表的结构 `wym_mscode`
--

CREATE TABLE `wym_mscode` (
  `id` int(11) NOT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `sendtime` int(11) DEFAULT '0',
  `state` tinyint(3) DEFAULT '0',
  `endtime` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='手机验证码记录' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `wym_mscode`
--

INSERT INTO `wym_mscode` (`id`, `mobile`, `code`, `sendtime`, `state`, `endtime`) VALUES
(140, '13800138000', '346352', 1561883965, 0, 1561884565),
(141, '13800138000', '695708', 1561883968, 0, 1561884568),
(142, '13800138000', '715249', 1561883971, 0, 1561884571),
(143, '18802046638', '293278', 1561884295, 0, 1561884895),
(144, '13700624309', '547237', 1561884385, 0, 1561884985),
(145, '13700624309', '622191', 1561884388, 0, 1561884988),
(146, '18002003333', '708496', 1561884488, 0, 1561885088),
(147, '18002003333', '416973', 1561884490, 0, 1561885090),
(148, '18002003333', '406540', 1561884491, 0, 1561885091),
(149, '13434167077', '730974', 1561884681, 0, 1561885281),
(150, '13434167077', '247822', 1561884684, 0, 1561885284),
(151, '13434167077', '178588', 1561884788, 0, 1561885388),
(152, '13434167077', '673887', 1561884800, 0, 1561885400),
(153, '13434167077', '776089', 1561884807, 0, 1561885407),
(154, '13434167077', '590403', 1561884853, 0, 1561885453),
(155, '13434167077', '512308', 1561884855, 0, 1561885455),
(156, '13700624309', '362100', 1561888525, 0, 1561889125),
(157, '18802046638', '911902', 1561888666, 0, 1561889266),
(158, '18002003333', '440836', 1561888740, 0, 1561889340),
(159, '13131313131', '160683', 1561889059, 0, 1561889659),
(160, '13131313131', '183849', 1561889061, 0, 1561889661),
(161, '13131313131', '348974', 1561889073, 0, 1561889673),
(162, '13131313131', '439364', 1561889185, 0, 1561889785),
(163, '13131313131', '954660', 1561889770, 0, 1561890370),
(164, '18802046638', '176035', 1561891374, 0, 1561891974),
(165, '13700624309', '408006', 1561891479, 0, 1561892079),
(166, '13800138000', '130590', 1561891540, 0, 1561892140),
(167, '18002003333', '565386', 1561891551, 0, 1561892151),
(168, '13580074666', '368815', 1561892518, 0, 1561893118),
(169, '13580074666', '452492', 1561892666, 0, 1561893266),
(170, '13580074666', '913948', 1561892718, 0, 1561893318),
(171, '13580086888', '902683', 1561892886, 0, 1561893486),
(172, '13580086888', '372223', 1561892888, 0, 1561893488),
(173, '13580086888', '902234', 1561892890, 0, 1561893490),
(174, '13434167077', '492513', 1561892922, 0, 1561893522),
(175, '13580086888', '215077', 1561892989, 0, 1561893589),
(176, '13580086888', '222053', 1561893071, 0, 1561893671),
(177, '15606686666', '364749', 1561893245, 0, 1561893845),
(178, '15606686666', '917007', 1561893247, 0, 1561893847),
(179, '15606686666', '677793', 1561893385, 0, 1561893985),
(180, '15606686666', '511437', 1561893410, 0, 1561894010),
(181, '15606686666', '319392', 1561893461, 0, 1561894061),
(182, '13434167077', '805338', 1561894517, 0, 1561895117),
(183, '13700624309', '715777', 1561898695, 0, 1561899295),
(184, '13613613613', '482381', 1561898697, 0, 1561899297),
(185, '13613613613', '359196', 1561898776, 0, 1561899376),
(186, '13613613613', '431519', 1561898956, 0, 1561899556),
(187, '13523773300', '144698', 1561899193, 0, 1561899793),
(188, '13523773300', '551494', 1561899374, 0, 1561899974),
(189, '13777778888', '356299', 1561900430, 0, 1561901030),
(190, '15606686666', '296714', 1561903895, 0, 1561904495),
(191, '15259386237', '434195', 1561957927, 0, 1561958527),
(192, '15259386237', '219025', 1561957958, 0, 1561958558),
(193, '15259386237', '237464', 1561958026, 0, 1561958626),
(194, '15259386237', '992329', 1561958029, 0, 1561958629),
(195, '18002003333', '859779', 1561959900, 0, 1561960500),
(196, '18802046638', '530601', 1561960197, 0, 1561960797),
(197, '18678264558', '724484', 1561974145, 0, 1561974745),
(198, '18678264558', '799224', 1561974149, 0, 1561974749),
(199, '15711507520', '884431', 1562036083, 0, 1562036683),
(200, '15711507520', '596972', 1562036151, 0, 1562036751),
(201, '15711507520', '113022', 1562036241, 0, 1562036841),
(202, '15711507520', '447139', 1562036483, 0, 1562037083),
(203, '15711507520', '955553', 1562036570, 0, 1562037170),
(204, '15711507520', '845828', 1562037051, 0, 1562037651),
(205, '13720893527', '496713', 1562037944, 0, 1562038544),
(206, '15711507520', '862789', 1562038192, 0, 1562038792),
(207, '15362086999', '949021', 1562038548, 0, 1562039148),
(208, '15362086999', '717507', 1562038573, 0, 1562039173),
(209, '15980867967', '789343', 1562038736, 0, 1562039336),
(210, '15980867967', '747306', 1562038752, 0, 1562039352),
(211, '17092088391', '415406', 1562038931, 0, 1562039531),
(212, '15579893918', '956393', 1562038933, 0, 1562039533),
(213, '15579893918', '769064', 1562038957, 0, 1562039557),
(214, '15579893918', '397360', 1562038985, 0, 1562039585),
(215, '15579893918', '214965', 1562039003, 0, 1562039603),
(216, '17092088392', '353872', 1562039116, 0, 1562039716),
(217, '15980867967', '977231', 1562039220, 0, 1562039820),
(218, '15980867967', '442835', 1562039311, 0, 1562039911),
(219, '15980867967', '553203', 1562039411, 0, 1562040011),
(220, '17092088391', '212369', 1562039502, 0, 1562040102),
(221, '15711507520', '172677', 1562040689, 0, 1562041289),
(222, '15711507520', '454860', 1562040979, 0, 1562041579),
(223, '15711507520', '240155', 1562041001, 0, 1562041601),
(224, '13720893527', '191780', 1562041063, 0, 1562041663),
(225, '15980867967', '637046', 1562041241, 0, 1562041841),
(226, '15980867967', '961082', 1562041306, 0, 1562041906),
(227, '15980867967', '233852', 1562041824, 0, 1562042424),
(228, '15980867967', '650240', 1562041906, 0, 1562042506),
(229, '15980867967', '959405', 1562041934, 0, 1562042534),
(230, '15980867967', '637167', 1562042001, 0, 1562042601),
(231, '13720893527', '718776', 1562042342, 0, 1562042942),
(232, '13720893527', '189065', 1562042377, 0, 1562042977),
(233, '13720893527', '878144', 1562042422, 0, 1562043022),
(234, '18559622528', '404624', 1562072650, 0, 1562073250),
(235, '18559622000', '517689', 1562072700, 0, 1562073300),
(236, '18559622000', '827892', 1562072704, 0, 1562073304),
(237, '13523773300', '975615', 1562075157, 0, 1562075757),
(238, '17092088391', '644096', 1562139266, 0, 1562139866),
(239, '18922608764', '135510', 1562150682, 0, 1562151282),
(240, '18922608764', '230738', 1562161316, 0, 1562161916),
(241, '18922608764', '319509', 1562161462, 0, 1562162062),
(242, '18150850052', '783231', 1562209609, 0, 1562210209),
(243, '18150850052', '268297', 1562209619, 0, 1562210219),
(244, '18172371906', '886727', 1562235504, 0, 1562236104),
(245, '18172371906', '498178', 1562235507, 0, 1562236107),
(246, '13240412886', '383813', 1562255677, 0, 1562256277),
(247, '13240412886', '388285', 1562255694, 0, 1562256294),
(248, '13240412886', '575520', 1562255698, 0, 1562256298),
(249, '15622609979', '231651', 1562308002, 0, 1562308602),
(250, '15622609979', '177693', 1562308319, 0, 1562308919),
(251, '15622609979', '215970', 1562308332, 0, 1562308932),
(252, '15622609979', '192594', 1562308920, 0, 1562309520),
(253, '15622609979', '665355', 1562309013, 0, 1562309613),
(254, '15622609979', '817441', 1562309106, 0, 1562309706),
(255, '13333445617', '829801', 1562341187, 0, 1562341787),
(256, '13888888888', '496367', 1562385705, 0, 1562386305),
(257, '13888888888', '702816', 1562385709, 0, 1562386309),
(258, '13888888888', '191956', 1562385727, 0, 1562386327),
(259, '13333445611', '762200', 1562464110, 0, 1562464710),
(260, '13333445611', '943972', 1562464159, 0, 1562464759),
(261, '15605761443', '867244', 1562469385, 0, 1562469985),
(262, '15605761443', '735423', 1562469394, 0, 1562469994),
(263, '15605761443', '196359', 1562472062, 0, 1562472662),
(264, '17783458776', '614454', 1562473850, 0, 1562474450),
(265, '17783458776', '409344', 1562473876, 0, 1562474476),
(266, '18317332108', '524558', 1580822456, 0, 1580823056),
(267, '18317332108', '437604', 1580822459, 0, 1580823059),
(268, '18317332108', '835696', 1580822461, 0, 1580823061),
(269, '18317332108', '144551', 1580823417, 0, 1580824017),
(270, '13800138000', '548409', 1580889799, 0, 1580890399);

-- --------------------------------------------------------

--
-- 表的结构 `wym_news`
--

CREATE TABLE `wym_news` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `cate` tinyint(3) DEFAULT NULL COMMENT '1 系统消息 2 活动通知 3帮助中心',
  `content` text,
  `create_time` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `wym_pig_order`
--

CREATE TABLE `wym_pig_order` (
  `id` int(11) NOT NULL,
  `order_no` varchar(255) DEFAULT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '所属人ID',
  `pig_id` int(11) NOT NULL DEFAULT '0' COMMENT '宠物ID',
  `sell_id` int(11) NOT NULL DEFAULT '0' COMMENT '出售人ID',
  `source_price` decimal(65,2) DEFAULT NULL COMMENT '原出售价格',
  `price` decimal(65,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '订单状态 0未付款 1已付款 2已完成 3已取消',
  `voucher` varchar(255) DEFAULT NULL COMMENT '付款凭证',
  `pig_name` varchar(255) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `point_id` int(11) DEFAULT NULL,
  `is_lock` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_pig_order`
--

INSERT INTO `wym_pig_order` (`id`, `order_no`, `uid`, `pig_id`, `sell_id`, `source_price`, `price`, `create_time`, `status`, `voucher`, `pig_name`, `update_time`, `point_id`, `is_lock`) VALUES
(30, '0x1257300257032105200', 63, 5, 66, NULL, '901.00', 1580896242, 3, '/public/uploads/paycode/2020020518020069247.png', '动物5', 1580899818, NULL, 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_recharge_mode`
--

CREATE TABLE `wym_recharge_mode` (
  `id` int(11) NOT NULL,
  `server_img` varchar(255) NOT NULL DEFAULT '',
  `wechat_img` varchar(255) DEFAULT NULL,
  `wechat_account` varchar(255) DEFAULT NULL,
  `alipay_img` varchar(255) DEFAULT NULL,
  `alipay_account` varchar(255) DEFAULT NULL,
  `status` tinyint(3) DEFAULT '0' COMMENT '是否启用 0不启用 1启用'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='充值方式';

--
-- 转存表中的数据 `wym_recharge_mode`
--

INSERT INTO `wym_recharge_mode` (`id`, `server_img`, `wechat_img`, `wechat_account`, `alipay_img`, `alipay_account`, `status`) VALUES
(4, '/public/uploads/20190703/ed92126dd5adc9ff8085486457c21106.jpg', '/public/uploads/20200205/ba10d080b5f5ad843037d4363b50e161.jpg', 'hanfvhai', '/public/uploads/20200205/2385b92915c6994c19d970be7efb2269.jpg', '18317332108', 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_shensu`
--

CREATE TABLE `wym_shensu` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单号',
  `content` varchar(255) DEFAULT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '申诉状态 0处理中 1已处理',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `username` varchar(255) NOT NULL DEFAULT '',
  `pig_no` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='申诉';

-- --------------------------------------------------------

--
-- 表的结构 `wym_sign`
--

CREATE TABLE `wym_sign` (
  `id` int(10) UNSIGNED NOT NULL,
  `uid` int(10) NOT NULL DEFAULT '0',
  `money` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='签到记录表';

-- --------------------------------------------------------

--
-- 表的结构 `wym_slide`
--

CREATE TABLE `wym_slide` (
  `id` int(10) UNSIGNED NOT NULL,
  `cid` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '轮播图名称',
  `description` varchar(255) DEFAULT '' COMMENT '说明',
  `link` varchar(255) DEFAULT '' COMMENT '链接',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `image` varchar(255) DEFAULT '' COMMENT '轮播图片',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态  1 显示  0  隐藏',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='轮播图表';

--
-- 转存表中的数据 `wym_slide`
--

INSERT INTO `wym_slide` (`id`, `cid`, `name`, `description`, `link`, `target`, `image`, `status`, `sort`) VALUES
(3, 3, '11', '11', '', '', '/uploads/20180918/a7f82e1351b0ba0c176995ecd9b332cc.png', 1, 1),
(4, 3, '22', '222', '', '', '/uploads/20180918/b992fdcbd899df634191e31dab2c473b.png', 1, 2),
(5, 5, '线下商铺首页1', '', '', '', '/uploads/20180918/5055dbc96fb1efc23aace116085a06ef.jpg', 1, 2),
(6, 5, '线下商铺首页2', '', '', '', '/uploads/20180918/664c71aece004c11b4557fb03ed812ac.jpg', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_slide_category`
--

CREATE TABLE `wym_slide_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '轮播图分类',
  `title` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='轮播图分类表';

--
-- 转存表中的数据 `wym_slide_category`
--

INSERT INTO `wym_slide_category` (`id`, `name`, `title`) VALUES
(3, 'index', '首页分类'),
(4, 'shop_index', '商城首页轮播'),
(5, 'store_index', '线下商铺首页');

-- --------------------------------------------------------

--
-- 表的结构 `wym_suggest`
--

CREATE TABLE `wym_suggest` (
  `id` int(10) UNSIGNED NOT NULL,
  `uid` int(10) NOT NULL DEFAULT '0',
  `content` text,
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `wym_system`
--

CREATE TABLE `wym_system` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '配置项名称',
  `value` text NOT NULL COMMENT '配置项值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统配置表';

--
-- 转存表中的数据 `wym_system`
--

INSERT INTO `wym_system` (`id`, `name`, `value`) VALUES
(1, 'site_config', 'a:13:{s:10:\"site_title\";s:0:\"\";s:9:\"login_img\";s:0:\"\";s:6:\"bg_img\";s:0:\"\";s:6:\"hb_img\";s:0:\"\";s:9:\"index_img\";s:0:\"\";s:10:\"banner_img\";s:61:\"/public/uploads/20200205/2ec746d987db7a7d39dcea4fc933589d.png\";s:8:\"sms_sign\";s:0:\"\";s:11:\"api_account\";s:0:\"\";s:12:\"api_password\";s:0:\"\";s:11:\"app_android\";s:0:\"\";s:7:\"app_ios\";s:0:\"\";s:4:\"open\";s:2:\"on\";s:7:\"content\";s:12:\"维护中...\";}'),
(2, 'price_config', 'a:5:{s:4:\"vpay\";a:3:{i:0;s:6:\"1.0000\";i:1;s:6:\"1.0000\";i:2;s:6:\"1.0000\";}s:3:\"btc\";a:3:{i:0;s:10:\"44133.0000\";i:1;s:10:\"44579.0000\";i:2;s:10:\"44002.0000\";}s:3:\"ltc\";a:3:{i:0;s:8:\"389.0000\";i:1;s:8:\"398.0000\";i:2;s:8:\"363.0000\";}s:3:\"eth\";a:3:{i:0;s:9:\"1492.0000\";i:1;s:9:\"1531.0000\";i:2;s:9:\"1463.0000\";}s:8:\"gogecoin\";a:3:{i:0;s:6:\"0.0394\";i:1;s:6:\"0.0395\";i:2;s:6:\"0.0395\";}}'),
(3, 'profit_config', 'a:14:{s:4:\"jtsf\";s:3:\"0.2\";s:7:\"jtsf_on\";s:2:\"on\";s:11:\"ztjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"ztjs_scale\";a:4:{i:0;s:1:\"7\";i:1;s:1:\"8\";i:2;s:1:\"9\";i:3;s:2:\"10\";}s:13:\"zt_generation\";a:5:{i:0;s:1:\"3\";i:1;s:1:\"6\";i:2;s:1:\"9\";i:3;s:2:\"12\";i:4;s:2:\"15\";}s:2:\"zt\";a:5:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";}s:11:\"tdjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"tdjs_scale\";a:4:{i:0;s:1:\"1\";i:1;s:3:\"1.5\";i:2;s:1:\"2\";i:3;s:1:\"3\";}s:11:\"jdjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"jdjs_scale\";a:4:{i:0;s:1:\"1\";i:1;s:3:\"1.5\";i:2;s:1:\"2\";i:3;s:1:\"3\";}s:11:\"ltjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"ltjs_scale\";a:4:{i:0;s:3:\"0.4\";i:1;s:3:\"0.5\";i:2;s:3:\"0.6\";i:3;s:3:\"0.7\";}s:11:\"ltjl_invest\";s:7:\"1000000\";s:10:\"ltjl_scale\";s:1:\"8\";}'),
(4, 'base_config', 'a:27:{s:11:\"firt_parent\";s:1:\"8\";s:13:\"second_parent\";s:1:\"3\";s:12:\"third_parent\";s:1:\"5\";s:7:\"pig_sxf\";s:1:\"5\";s:8:\"doge_sxf\";s:2:\"10\";s:7:\"jk_open\";s:2:\"on\";s:12:\"jk_open_time\";s:0:\"\";s:10:\"pay_points\";s:2:\"20\";s:9:\"split_num\";s:1:\"0\";s:17:\"zc_integral_limit\";s:7:\"1000000\";s:14:\"qiangdan_limit\";s:3:\"100\";s:5:\"wf_nb\";s:1:\"1\";s:8:\"wf_lownb\";s:1:\"0\";s:11:\"cancel_time\";s:4:\"3600\";s:10:\"enter_time\";s:4:\"3600\";s:13:\"sell_end_time\";s:0:\"\";s:8:\"sell_min\";s:3:\"100\";s:8:\"sell_num\";s:3:\"100\";s:13:\"sare_sell_min\";s:3:\"100\";s:13:\"sare_sell_max\";s:5:\"20000\";s:13:\"sare_sell_num\";s:3:\"100\";s:13:\"team_sell_min\";s:3:\"100\";s:13:\"team_sell_max\";s:5:\"20000\";s:13:\"team_sell_num\";s:3:\"100\";s:11:\"zc_sell_min\";s:3:\"100\";s:11:\"zc_sell_max\";s:5:\"20000\";s:11:\"zc_sell_num\";s:3:\"100\";}'),
(5, 'ub_config', 'a:6:{s:10:\"ubj_invest\";a:4:{i:0;s:3:\"100\";i:1;s:4:\"1000\";i:2;s:4:\"5000\";i:3;s:5:\"10000\";}s:9:\"ubj_scale\";a:4:{i:0;s:3:\"0.1\";i:1;s:3:\"0.1\";i:2;s:3:\"0.2\";i:3;s:3:\"0.3\";}s:9:\"zj_invest\";a:4:{i:0;s:3:\"100\";i:1;s:4:\"1000\";i:2;s:4:\"5000\";i:3;s:5:\"10000\";}s:8:\"zj_scale\";a:4:{i:0;s:3:\"0.1\";i:1;s:3:\"0.1\";i:2;s:3:\"0.2\";i:3;s:3:\"0.3\";}s:11:\"team_invest\";a:4:{i:0;s:3:\"100\";i:1;s:4:\"1000\";i:2;s:4:\"5000\";i:3;s:5:\"10000\";}s:10:\"team_scale\";a:4:{i:0;s:4:\"0.01\";i:1;s:4:\"0.01\";i:2;s:4:\"0.02\";i:3;s:4:\"0.03\";}}');

-- --------------------------------------------------------

--
-- 表的结构 `wym_task_config`
--

CREATE TABLE `wym_task_config` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `cycle` int(11) NOT NULL DEFAULT '0' COMMENT '任务周期',
  `min_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最小价值',
  `max_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最大价值',
  `contract_revenue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '只能合约收益',
  `doge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'DOGE收益',
  `pig` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'PIG收益',
  `pay_points` varchar(255) NOT NULL DEFAULT '' COMMENT '预约积分',
  `qiang_points` varchar(255) DEFAULT '' COMMENT '即抢积分',
  `img` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) NOT NULL DEFAULT '' COMMENT '领养开始时间',
  `end_time` varchar(255) DEFAULT NULL COMMENT '领养结束时间',
  `selled_stock` int(4) DEFAULT '0' COMMENT '已放库存',
  `max_stock` int(4) DEFAULT NULL COMMENT '最大库存',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态 1开启 0关闭',
  `is_open` tinyint(3) NOT NULL DEFAULT '0' COMMENT '今日是否开过奖 0未开奖 1已开奖',
  `is_flush_open` tinyint(3) DEFAULT '0' COMMENT '今日抢购是否开过奖 0未开奖 1已开奖'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='任务配置';

--
-- 转存表中的数据 `wym_task_config`
--

INSERT INTO `wym_task_config` (`id`, `name`, `cycle`, `min_price`, `max_price`, `contract_revenue`, `doge`, `pig`, `pay_points`, `qiang_points`, `img`, `start_time`, `end_time`, `selled_stock`, `max_stock`, `status`, `is_open`, `is_flush_open`) VALUES
(1, '动物1', 1, '100.00', '300.00', '21.00', '30.00', '3.00', '2', '4', '/public/uploads/20190630/0851883576d35454a42121fb334f3679.png', '15:44', '23:46', 2, 100, 1, 0, 0),
(2, '动物2', 1, '301.00', '900.00', '15.00', '20.00', '1.00', '6', '12', '/public/uploads/20190630/0ad2b1eb8447c1ce6da99c9d0e71e02a.png', '15:45', '15:47', 1, 1, 1, 0, 0),
(3, '动物3', 1, '200.00', '6000.00', '14.00', '8.00', '2.00', '15', '30', '/public/uploads/20190630/166896369a0fe90303c14fa2ed122195.png', '17:26', '17:50', 2, 3, 1, 0, 0),
(4, '动物4', 1, '100.00', '2500.00', '5.00', '10.00', '1.40', '3', '10', '/public/uploads/20190630/f839220eed3a4aeea51276d7b76494ba.png', '16:30', '23:35', 0, 10, 1, 0, 0),
(5, '动物5', 1, '901.00', '2500.00', '21.00', '18.00', '1.50', '11', '22', '/public/uploads/20190630/6b6fad88b253a90ad0e86d84ea11cf03.png', '15:30', '18:30', 0, 1, 1, 0, 0),
(6, '动物6', 1, '6001.00', '15000.00', '40.00', '5.00', '4.00', '25', '50', '/public/uploads/20190630/0837b7ed474be415a9cd9a11ae4aceb1.png', '12:25', '13:25', 2, 2, 1, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_tixian`
--

CREATE TABLE `wym_tixian` (
  `id` int(10) UNSIGNED NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `mobile` char(11) NOT NULL DEFAULT '',
  `currency` varchar(255) DEFAULT '' COMMENT '币种',
  `wallet_address` varchar(255) NOT NULL DEFAULT '' COMMENT '钱包地址',
  `num` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '提币数目',
  `tx_rate` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '提现手续费',
  `realmoney` varchar(10) DEFAULT '' COMMENT '到账金额',
  `sxf` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '手续',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '0审核1通过2拒绝',
  `create_time` varchar(255) DEFAULT NULL,
  `examine_time` varchar(255) DEFAULT NULL COMMENT '审核时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_tixian`
--

INSERT INTO `wym_tixian` (`id`, `uid`, `mobile`, `currency`, `wallet_address`, `num`, `tx_rate`, `realmoney`, `sxf`, `state`, `create_time`, `examine_time`) VALUES
(2, 1, '13523773300', 'doge', '123', '10.00', '10.00', '9', '1.00', 1, '1562381009', '1562381046'),
(3, 1, '13523773300', 'doge', '123', '10.00', '10.00', '9', '1.00', 0, '1562381016', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `wym_user`
--

CREATE TABLE `wym_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `pay_password` char(32) DEFAULT NULL,
  `ulevel` int(5) DEFAULT '0' COMMENT '会员等级',
  `head_img` varchar(255) DEFAULT '' COMMENT '头像',
  `nickname` varchar(255) NOT NULL,
  `mobile` varchar(11) DEFAULT '' COMMENT '手机',
  `email` varchar(50) DEFAULT '' COMMENT '邮箱',
  `totalmoney` decimal(65,2) DEFAULT '0.00' COMMENT '总的收益量',
  `share_integral` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '推广收益',
  `pay_points` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '微分',
  `contract_revenue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合约收益',
  `pig` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'PIG币',
  `doge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'DOGE币',
  `rc_count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计充值',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户状态  1 正常  2 禁止',
  `trade_order` int(11) NOT NULL DEFAULT '1' COMMENT '排单序号 0 不排单 1正常排单',
  `credit_score` int(11) NOT NULL DEFAULT '100' COMMENT '信用积分',
  `create_time` int(13) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `reg_ip` varchar(255) DEFAULT NULL,
  `last_login_time` int(13) NOT NULL DEFAULT '0' COMMENT '最后登陆时间',
  `last_login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `total_share_integral` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_nb` int(1) DEFAULT '0' COMMENT '是否内部帐号',
  `team_integral` decimal(12,2) DEFAULT '0.00' COMMENT '团队收益',
  `zc_integral` decimal(12,2) DEFAULT '0.00' COMMENT '收益转存'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

--
-- 转存表中的数据 `wym_user`
--

INSERT INTO `wym_user` (`id`, `username`, `password`, `pay_password`, `ulevel`, `head_img`, `nickname`, `mobile`, `email`, `totalmoney`, `share_integral`, `pay_points`, `contract_revenue`, `pig`, `doge`, `rc_count`, `status`, `trade_order`, `credit_score`, `create_time`, `reg_ip`, `last_login_time`, `last_login_ip`, `total_share_integral`, `is_nb`, `team_integral`, `zc_integral`) VALUES
(65, '13800138002', 'd97986b84950f0213ebc5c4e2bca288a', NULL, 0, '', '6bscn2', '13800138002', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1, 1, 100, 1564909725, '111.173.132.159', 0, '', '0.00', 0, '0.00', '0.00'),
(63, '13800138000', '1022ae019378eceaeed2258e10fa2849', 'd97986b84950f0213ebc5c4e2bca288a', 0, '', '本色源码', '13800138000', '', '0.00', '1000.00', '872.00', '0.00', '1.50', '0.00', '0.00', 1, 1, 100, 1564909580, '111.173.132.159', 1580889018, '127.0.0.1', '0.00', 0, '2000.00', '1600.00'),
(64, '13800138001', 'd97986b84950f0213ebc5c4e2bca288a', NULL, 0, '', '6bscn1', '13800138001', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1, 1, 100, 1564909673, '111.173.132.159', 0, '', '0.00', 0, '0.00', '0.00'),
(66, '18317332108', '1022ae019378eceaeed2258e10fa2849', 'd97986b84950f0213ebc5c4e2bca288a', 1, '', 'hanhan', '18317332108', '', '0.00', '0.00', '704.00', '0.00', '0.00', '0.00', '260.00', 1, 1, 100, 1580822620, '127.0.0.1', 1580872899, '127.0.0.1', '0.00', 0, '0.00', '0.00');

-- --------------------------------------------------------

--
-- 表的结构 `wym_user_level`
--

CREATE TABLE `wym_user_level` (
  `id` int(11) NOT NULL,
  `level` tinyint(3) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '级别名',
  `cnt` int(11) NOT NULL DEFAULT '0',
  `money` int(11) DEFAULT NULL,
  `ratio` int(11) DEFAULT NULL COMMENT '团队奖励',
  `add_sell_num` int(11) DEFAULT '0' COMMENT '增加每日出售限制'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_user_level`
--

INSERT INTO `wym_user_level` (`id`, `level`, `name`, `cnt`, `money`, `ratio`, `add_sell_num`) VALUES
(1, 2, '初级合伙人', 10, 500, 1, 1),
(2, 3, '中级合伙人', 30, 3000, 3, 0),
(3, 4, '高级合伙人', 60, 5000, 5, 0),
(4, 1, 'vip会员', 0, 100, 0, 0),
(5, 0, '普通会员', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_user_payment`
--

CREATE TABLE `wym_user_payment` (
  `id` int(11) NOT NULL,
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支付方式 1支付宝 2微信 3银行卡',
  `account` varchar(255) DEFAULT NULL COMMENT '账号',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '收款人名称',
  `qrcode_url` varchar(255) DEFAULT NULL COMMENT '收款码',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '银行名称',
  `branch_name` varchar(255) DEFAULT NULL COMMENT '支行名称',
  `uid` int(11) NOT NULL DEFAULT '0',
  `mobile` char(11) NOT NULL DEFAULT '',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_user_payment`
--

INSERT INTO `wym_user_payment` (`id`, `type`, `account`, `name`, `qrcode_url`, `bank_name`, `branch_name`, `uid`, `mobile`, `status`, `create_time`) VALUES
(11, 1, '13720893527', '哦哦哦', '/public/uploads/paycode/2019070212393618824.jpeg', NULL, NULL, 50, '13720893527', 0, 1562042385),
(10, 2, '13720893527', '哦哦哦', '/public/uploads/paycode/2019070212390095638.jpeg', NULL, NULL, 50, '13720893527', 0, 1562042349),
(9, 3, '6227001935561517870', '肖景椿', NULL, '中国建设银行', '厦门嘉庚支行', 51, '15980867967', 0, 1562042012),
(8, 1, '15980867967', '肖景椿', '/public/uploads/paycode/2019070212321340470.jpeg', NULL, NULL, 51, '15980867967', 0, 1562041941),
(7, 2, '15980867967', '肖景椿', '/public/uploads/paycode/2019070212314543065.png', NULL, NULL, 51, '15980867967', 0, 1562041913),
(6, 3, '6227001935561517870', '肖景椿', NULL, '中国建设银行', '厦门分行', 44, '15980867967', 0, 1562039416),
(12, 3, '6217001930002665778', '哦哦哦', NULL, '中国银行', '六角恐龙', 50, '13720893527', 0, 1562042427),
(13, 3, '1231234', '1231234', NULL, '中国银行', '1231234', 1, '13523773300', 0, 1562075163),
(14, 3, '685755855475', '李四', NULL, '中国银行', '广州市花都支行', 53, '18922608764', 0, 1562161333),
(15, 1, '6855486556@qq.com', '李四', '/public/uploads/paycode/2019070321441980039.png', NULL, NULL, 53, '18922608764', 0, 1562161471),
(16, 1, '38578555585', '王麻子', '/public/uploads/paycode/2019070514440796520.jpeg', NULL, NULL, 58, '15622609979', 0, 1562309050),
(17, 3, '658648348684585', '王麻子', NULL, '中国银行', '馔辉', 58, '15622609979', 0, 1562309153),
(19, 1, '1387745147666', '急救包', '/public/uploads/paycode/2019070709482528069.jpeg', NULL, NULL, 60, '13333445611', 0, 1562464120),
(20, 3, '69494646696698866669', '娇娇女', NULL, '中国银行', '广东', 60, '13333445611', 0, 1562464165),
(21, 3, '888777888', '112', NULL, '中国银行', '1212', 61, '15605761443', 0, 1562472070),
(22, 2, '17783458776', '你好', '/public/uploads/paycode/2019070712304647164.png', NULL, NULL, 62, '17783458776', 0, 1562473855),
(23, 3, '6222524345457575764', '你好', NULL, '中国银行', '工行', 62, '17783458776', 0, 1562473896),
(24, 3, '6221884960024286512', '韩福海', NULL, '中国邮政储蓄银行', '楚旺', 66, '18317332108', 0, 1580823462),
(25, 3, '350277196212305228', '小小', NULL, '中国农业银行', '长葛', 63, '13800138000', 0, 1580889807);

-- --------------------------------------------------------

--
-- 表的结构 `wym_user_pigs`
--

CREATE TABLE `wym_user_pigs` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `pig_id` varchar(255) DEFAULT NULL COMMENT '猪ID',
  `pig_name` varchar(255) NOT NULL DEFAULT '',
  `pig_no` varchar(255) NOT NULL DEFAULT '0' COMMENT '宠物编号',
  `price` decimal(65,2) DEFAULT NULL COMMENT '价格',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态 0 不可出售 1可出售',
  `point_id` int(11) NOT NULL DEFAULT '0' COMMENT '指向ID',
  `from_id` int(11) NOT NULL DEFAULT '0' COMMENT '来源用户',
  `create_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `cycle` int(11) NOT NULL DEFAULT '0' COMMENT '领养周期',
  `contract_revenue` varchar(255) DEFAULT NULL COMMENT '智能合约产出率',
  `doge` decimal(65,2) NOT NULL DEFAULT '0.00' COMMENT 'DOGE产出率',
  `total_revenue` decimal(65,2) NOT NULL DEFAULT '0.00',
  `order_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户的猪';

--
-- 转存表中的数据 `wym_user_pigs`
--

INSERT INTO `wym_user_pigs` (`id`, `uid`, `pig_id`, `pig_name`, `pig_no`, `price`, `status`, `point_id`, `from_id`, `create_time`, `end_time`, `cycle`, `contract_revenue`, `doge`, `total_revenue`, `order_id`) VALUES
(29, 63, '5', '动物5', '0x1257300257032105200', '901.00', 0, 0, 66, 1580899818, 1580986218, 1, NULL, '0.00', '0.00', 30);

-- --------------------------------------------------------

--
-- 表的结构 `wym_user_relation`
--

CREATE TABLE `wym_user_relation` (
  `id` int(11) UNSIGNED NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `username` varchar(100) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `pusername` varchar(100) DEFAULT NULL,
  `rel` varchar(255) NOT NULL DEFAULT '' COMMENT '推荐关系字符集',
  `create_time` int(13) NOT NULL DEFAULT '0',
  `pid2` int(11) DEFAULT NULL COMMENT '二级推荐人',
  `pid3` int(11) DEFAULT NULL COMMENT '三级推荐人',
  `cnt` int(11) NOT NULL DEFAULT '0' COMMENT '直推人数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='推荐关系表';

--
-- 转存表中的数据 `wym_user_relation`
--

INSERT INTO `wym_user_relation` (`id`, `uid`, `username`, `pid`, `pusername`, `rel`, `create_time`, `pid2`, `pid3`, `cnt`) VALUES
(1, 1, '13523773300', 0, NULL, ',0', 1560508850, NULL, NULL, 7),
(2, 48, '17092088391', 1, '13523773300', ',1,0', 1562039530, 0, NULL, 0),
(3, 49, '15711507520', 1, '13523773300', ',1,0', 1562040702, 0, NULL, 1),
(4, 50, '13720893527', 49, '15711507520', ',49,1,0', 1562041073, 1, NULL, 2),
(5, 51, '15980867967', 50, '13720893527', ',50,49,1,0', 1562041856, 49, 1, 0),
(6, 52, '18559622000', 50, '13720893527', ',50,49,1,0', 1562072722, 49, 1, 0),
(7, 53, '18922608764', 1, '13523773300', ',1,0', 1562150744, 0, NULL, 2),
(8, 54, '18150850052', 53, '18922608764', ',53,1,0', 1562209677, 1, NULL, 1),
(9, 55, '13523773301', 1, '13523773300', ',1,0', 1562214063, 0, NULL, 0),
(10, 56, '13888888888', 54, '18150850052', ',54,53,1,0', 1562214489, 53, 1, 1),
(11, 57, '18172371906', 1, '13523773300', ',1,0', 1562235589, 0, NULL, 0),
(12, 58, '15622609979', 53, '18922608764', ',53,1,0', 1562308050, 1, NULL, 0),
(13, 59, '13333445617', 1, '13523773300', ',1,0', 1562341062, 0, NULL, 1),
(14, 60, '13333445611', 59, '13333445617', ',59,1,0', 1562463848, 1, NULL, 0),
(15, 61, '15605761443', 1, '13523773300', ',1,0', 1562469993, 0, NULL, 0),
(16, 62, '17783458776', 56, '13888888888', ',56,54,53,1,0', 1562473741, 54, 53, 0),
(17, 63, '13800138000', 0, NULL, ',0', 1564909580, NULL, NULL, 2),
(18, 64, '13800138001', 63, '13800138000', ',63,0', 1564909673, 0, NULL, 1),
(19, 65, '13800138002', 64, '13800138001', ',64,63,0', 1564909725, 63, NULL, 0),
(20, 66, '18317332108', 63, '13800138000', ',63,0', 1580822620, 0, NULL, 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_user_reward`
--

CREATE TABLE `wym_user_reward` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `from_id` int(11) NOT NULL DEFAULT '0' COMMENT '奖金来源',
  `currency` varchar(255) NOT NULL DEFAULT '' COMMENT '币种',
  `amount` decimal(65,2) NOT NULL DEFAULT '0.00' COMMENT '收益数额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '获取时间',
  `note` varchar(255) NOT NULL DEFAULT '',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '收益类型 1智能合约 2直推收益 3团队收益'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户奖金表';

--
-- 转存表中的数据 `wym_user_reward`
--

INSERT INTO `wym_user_reward` (`id`, `uid`, `from_id`, `currency`, `amount`, `create_time`, `note`, `type`) VALUES
(1, 53, 0, 'contract_revenue', '10.00', 1562397432, '智能合约', 1),
(2, 53, 0, 'doge', '20.00', 1562397432, 'DOGE收益', 5),
(3, 1, 53, 'share_integral', '0.80', 1562397432, '一代推广', 2),
(4, 63, 0, '', '1.50', 1580899818, '交易奖励wia', 5);

-- --------------------------------------------------------

--
-- 表的结构 `wym_wealth`
--

CREATE TABLE `wym_wealth` (
  `id` int(15) UNSIGNED NOT NULL,
  `uid` int(15) NOT NULL DEFAULT '0',
  `username` varchar(255) NOT NULL DEFAULT '0',
  `walltype` varchar(50) NOT NULL DEFAULT '0',
  `oldmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变化前的金额',
  `num` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `newmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变化后的金额',
  `mark` varchar(100) NOT NULL DEFAULT '0' COMMENT '简要说明',
  `plain` varchar(100) DEFAULT NULL COMMENT '详细说明',
  `type` tinyint(3) DEFAULT '0' COMMENT '1充值（投资money）2充值（score）3扣款4动态奖5分红6支付宝充值（投资）7余额转基金(投资)8提现（余额）9退还（余额）10扣除余额',
  `addtime` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(3) DEFAULT '0' COMMENT '0成功1失败'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='金额变动记录表';

-- --------------------------------------------------------

--
-- 表的结构 `wym_yuyue`
--

CREATE TABLE `wym_yuyue` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `pig_id` int(11) NOT NULL DEFAULT '0' COMMENT '宠物ID',
  `pay_points` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '消耗微分',
  `create_time` int(11) DEFAULT NULL COMMENT '预约时间',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态 0未开始 1中奖 2未中奖',
  `user_sort` int(11) NOT NULL DEFAULT '1' COMMENT '排单序号',
  `credit_score` int(11) NOT NULL DEFAULT '100',
  `buy_type` tinyint(3) DEFAULT '0' COMMENT '0:预约，1:抢购'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_yuyue`
--

INSERT INTO `wym_yuyue` (`id`, `uid`, `pig_id`, `pay_points`, `create_time`, `status`, `user_sort`, `credit_score`, `buy_type`) VALUES
(82, 63, 2, '6.00', 1580906077, 0, 1, 100, 0),
(81, 66, 5, '22.00', 1580896385, 2, 1, 100, 1),
(80, 66, 5, '22.00', 1580896350, 2, 1, 100, 1),
(79, 63, 5, '11.00', 1580895230, 1, 1, 100, 2),
(78, 63, 6, '25.00', 1580895229, 0, 1, 100, 0),
(77, 66, 5, '11.00', 1580895211, 2, 1, 100, 2),
(76, 66, 6, '25.00', 1580895210, 0, 1, 100, 0);

-- --------------------------------------------------------

--
-- 表的结构 `wym_zc_order`
--

CREATE TABLE `wym_zc_order` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `num` decimal(10,2) DEFAULT NULL COMMENT '数目',
  `username` varchar(255) DEFAULT NULL COMMENT '用户姓名',
  `mobile` varchar(255) DEFAULT NULL,
  `voucher` varchar(255) DEFAULT NULL COMMENT '支付凭证',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态 0待审核 1已审核',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '认购时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `wym_zc_order`
--

INSERT INTO `wym_zc_order` (`id`, `uid`, `num`, `username`, `mobile`, `voucher`, `status`, `create_time`) VALUES
(5, 1, '50.00', NULL, '13523773300', 'public/uploads/paycode/2019070421321661442.png', 1, 1562247138),
(6, 66, '200.00', NULL, '18317332108', 'public/uploads/paycode/2020020520042350781.jpeg', 1, 1580904268);

--
-- 转储表的索引
--

--
-- 表的索引 `wym_admin_user`
--
ALTER TABLE `wym_admin_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- 表的索引 `wym_article`
--
ALTER TABLE `wym_article`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_auth_group`
--
ALTER TABLE `wym_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_auth_group_access`
--
ALTER TABLE `wym_auth_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `wym_auth_rule`
--
ALTER TABLE `wym_auth_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`) USING BTREE;

--
-- 表的索引 `wym_bank`
--
ALTER TABLE `wym_bank`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_bonus`
--
ALTER TABLE `wym_bonus`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_category`
--
ALTER TABLE `wym_category`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_delete_pigs`
--
ALTER TABLE `wym_delete_pigs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_destory_pigs`
--
ALTER TABLE `wym_destory_pigs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_errormoney`
--
ALTER TABLE `wym_errormoney`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_identity_auth`
--
ALTER TABLE `wym_identity_auth`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_money_log`
--
ALTER TABLE `wym_money_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_mscode`
--
ALTER TABLE `wym_mscode`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_news`
--
ALTER TABLE `wym_news`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_pig_order`
--
ALTER TABLE `wym_pig_order`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_recharge_mode`
--
ALTER TABLE `wym_recharge_mode`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_shensu`
--
ALTER TABLE `wym_shensu`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_sign`
--
ALTER TABLE `wym_sign`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_slide`
--
ALTER TABLE `wym_slide`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_slide_category`
--
ALTER TABLE `wym_slide_category`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_suggest`
--
ALTER TABLE `wym_suggest`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_system`
--
ALTER TABLE `wym_system`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_task_config`
--
ALTER TABLE `wym_task_config`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_tixian`
--
ALTER TABLE `wym_tixian`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_user`
--
ALTER TABLE `wym_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `wym_user_level`
--
ALTER TABLE `wym_user_level`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_user_payment`
--
ALTER TABLE `wym_user_payment`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_user_pigs`
--
ALTER TABLE `wym_user_pigs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_user_relation`
--
ALTER TABLE `wym_user_relation`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_user_reward`
--
ALTER TABLE `wym_user_reward`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_wealth`
--
ALTER TABLE `wym_wealth`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_yuyue`
--
ALTER TABLE `wym_yuyue`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `wym_zc_order`
--
ALTER TABLE `wym_zc_order`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `wym_admin_user`
--
ALTER TABLE `wym_admin_user`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `wym_article`
--
ALTER TABLE `wym_article`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章ID', AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `wym_auth_group`
--
ALTER TABLE `wym_auth_group`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `wym_auth_rule`
--
ALTER TABLE `wym_auth_rule`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- 使用表AUTO_INCREMENT `wym_bank`
--
ALTER TABLE `wym_bank`
  MODIFY `id` int(15) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `wym_bonus`
--
ALTER TABLE `wym_bonus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `wym_category`
--
ALTER TABLE `wym_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `wym_delete_pigs`
--
ALTER TABLE `wym_delete_pigs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- 使用表AUTO_INCREMENT `wym_destory_pigs`
--
ALTER TABLE `wym_destory_pigs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `wym_errormoney`
--
ALTER TABLE `wym_errormoney`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `wym_identity_auth`
--
ALTER TABLE `wym_identity_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- 使用表AUTO_INCREMENT `wym_money_log`
--
ALTER TABLE `wym_money_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- 使用表AUTO_INCREMENT `wym_mscode`
--
ALTER TABLE `wym_mscode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- 使用表AUTO_INCREMENT `wym_news`
--
ALTER TABLE `wym_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `wym_pig_order`
--
ALTER TABLE `wym_pig_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- 使用表AUTO_INCREMENT `wym_recharge_mode`
--
ALTER TABLE `wym_recharge_mode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `wym_shensu`
--
ALTER TABLE `wym_shensu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `wym_sign`
--
ALTER TABLE `wym_sign`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `wym_slide`
--
ALTER TABLE `wym_slide`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `wym_slide_category`
--
ALTER TABLE `wym_slide_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `wym_suggest`
--
ALTER TABLE `wym_suggest`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `wym_system`
--
ALTER TABLE `wym_system`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `wym_task_config`
--
ALTER TABLE `wym_task_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- 使用表AUTO_INCREMENT `wym_tixian`
--
ALTER TABLE `wym_tixian`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `wym_user`
--
ALTER TABLE `wym_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- 使用表AUTO_INCREMENT `wym_user_level`
--
ALTER TABLE `wym_user_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `wym_user_payment`
--
ALTER TABLE `wym_user_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- 使用表AUTO_INCREMENT `wym_user_pigs`
--
ALTER TABLE `wym_user_pigs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- 使用表AUTO_INCREMENT `wym_user_relation`
--
ALTER TABLE `wym_user_relation`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- 使用表AUTO_INCREMENT `wym_user_reward`
--
ALTER TABLE `wym_user_reward`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `wym_wealth`
--
ALTER TABLE `wym_wealth`
  MODIFY `id` int(15) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- 使用表AUTO_INCREMENT `wym_yuyue`
--
ALTER TABLE `wym_yuyue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- 使用表AUTO_INCREMENT `wym_zc_order`
--
ALTER TABLE `wym_zc_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
