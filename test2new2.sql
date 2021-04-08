/*
Navicat MySQL Data Transfer

Source Server         : task1
Source Server Version : 80021
Source Host           : localhost:3306
Source Database       : test2

Target Server Type    : MYSQL
Target Server Version : 80021
File Encoding         : 65001

Date: 2021-04-09 00:47:59
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
  `content` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of collection
-- ----------------------------
INSERT INTO `collection` VALUES ('ccc', '11', '北京市海淀区幸福大街1栋', '40000.00', '78', 'aaa', '请联系我xxxx');
INSERT INTO `collection` VALUES ('ccc', '12', '山西省大同市长安路1栋', '3123.00', '1223', 'aaa', '发送到发送到发发生');

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
-- Records of dones
-- ----------------------------

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of houseinfo
-- ----------------------------
INSERT INTO `houseinfo` VALUES ('1111', '11.00', '111111', '0', 'aaa', '1111', '8');
INSERT INTO `houseinfo` VALUES ('222', '2222.00', '22222', '0', 'aaa', '222', '9');
INSERT INTO `houseinfo` VALUES ('33', '3333.00', '33', '0', 'aaa', '33333', '10');
INSERT INTO `houseinfo` VALUES ('北京市海淀区幸福大街1栋', '40000.00', '78', '1', 'aaa', '请联系我xxxx', '11');
INSERT INTO `houseinfo` VALUES ('山西省大同市长安路1栋', '3123.00', '1223', '1', 'aaa', '发送到发送到发发生', '12');

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
INSERT INTO `user` VALUES ('bbb', 'bbb', '1', '3');
INSERT INTO `user` VALUES ('ccc', 'ccc', '1', '3');
INSERT INTO `user` VALUES ('aaa', 'aaa', '1', '2');
