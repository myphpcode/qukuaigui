-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2020-02-14 21:17:32
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
(1, 0, '普通客户', 5, 10, 1, 0),
(2, 1, 'vip客户', 10, 100, 5, 0),
(3, 2, '公司', 10, 500, 5, 1);

--
-- 转储表的索引
--

--
-- 表的索引 `wym_user_level`
--
ALTER TABLE `wym_user_level`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `wym_user_level`
--
ALTER TABLE `wym_user_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
