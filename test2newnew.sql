/*
Navicat MySQL Data Transfer

Source Server         : task1
Source Server Version : 80021
Source Host           : localhost:3306
Source Database       : test2

Target Server Type    : MYSQL
Target Server Version : 80021
File Encoding         : 65001

Date: 2021-05-09 00:16:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection` (
  `username` varchar(255) DEFAULT NULL,
  `id` int DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `amount` float(10,0) DEFAULT NULL,
  `sellname` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `imgs` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dones
-- ----------------------------
DROP TABLE IF EXISTS `dones`;
CREATE TABLE `dones` (
  `goodsname` varchar(255) DEFAULT NULL,
  `id` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `buynum` float DEFAULT NULL,
  `sellname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for houseinfo
-- ----------------------------
DROP TABLE IF EXISTS `houseinfo`;
CREATE TABLE `houseinfo` (
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `amount` float(10,0) DEFAULT NULL,
  `state` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `imgs` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

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
