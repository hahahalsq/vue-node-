/*
Navicat MySQL Data Transfer

Source Server         : demo
Source Server Version : 80019
Source Host           : 127.0.0.1:3306
Source Database       : test2

Target Server Type    : MYSQL
Target Server Version : 80019
File Encoding         : 65001

Date: 2021-02-19 10:50:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `username` varchar(255) DEFAULT NULL,
  `id` int DEFAULT NULL,
  `goodsname` varchar(255) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `buynum` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cars
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodsinfo
-- ----------------------------
INSERT INTO `goodsinfo` VALUES ('1111', '11.00', '111111', '1', 'aaa', '1111', '8');
INSERT INTO `goodsinfo` VALUES ('222', '2222.00', '22222', '1', 'aaa', '222', '9');
INSERT INTO `goodsinfo` VALUES ('33', '3333.00', '33', '1', 'aaa', '33333', '10');

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

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('admin', 'admin', '1', '1');
INSERT INTO `user` VALUES ('aaa', 'aaa', '1', '2');
INSERT INTO `user` VALUES ('bbb', 'bbb', '1', '3');
