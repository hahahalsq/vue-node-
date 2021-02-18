/*
Navicat MySQL Data Transfer

Source Server         : task1
Source Server Version : 80021
Source Host           : localhost:3306
Source Database       : test2

Target Server Type    : MYSQL
Target Server Version : 80021
File Encoding         : 65001

Date: 2021-02-18 22:37:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `username` varchar(255) DEFAULT NULL,
  `id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for goodsinfo
-- ----------------------------
DROP TABLE IF EXISTS `goodsinfo`;
CREATE TABLE `goodsinfo` (
  `goodsname` varchar(255) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `amount` float(10,0) DEFAULT NULL,
  `state` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `state` int DEFAULT NULL,
  `level` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
