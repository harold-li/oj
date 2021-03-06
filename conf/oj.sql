/*
Navicat MySQL Data Transfer

Source Server         : Debian32
Source Server Version : 50535
Source Host           : 10.121.122.50:3306
Source Database       : oj

Target Server Type    : MYSQL
Target Server Version : 50535
File Encoding         : 65001

Date: 2014-03-21 17:48:55
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `board`
-- ----------------------------
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `cid` int(9) NOT NULL DEFAULT '0',
  `uid` int(9) NOT NULL,
  `solved` int(5) NOT NULL DEFAULT '0',
  `penalty` int(11) NOT NULL DEFAULT '0',
  `A_SolvedTime` int(11) DEFAULT '0',
  `A_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `B_SolvedTime` int(11) DEFAULT '0',
  `B_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `C_SolvedTime` int(11) DEFAULT '0',
  `C_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `D_SolvedTime` int(11) DEFAULT '0',
  `D_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `E_SolvedTime` int(11) DEFAULT '0',
  `E_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `F_SolvedTime` int(11) DEFAULT '0',
  `F_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `G_SolvedTime` int(11) DEFAULT '0',
  `G_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `H_SolvedTime` int(11) DEFAULT '0',
  `H_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `I_SolvedTime` int(11) DEFAULT '0',
  `I_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `J_SolvedTime` int(11) DEFAULT '0',
  `J_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `K_SolvedTime` int(11) DEFAULT '0',
  `K_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `L_SolvedTime` int(11) DEFAULT '0',
  `L_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `M_SolvedTime` int(11) DEFAULT '0',
  `M_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `N_SolvedTime` int(11) DEFAULT '0',
  `N_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `O_SolvedTime` int(11) DEFAULT '0',
  `O_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `P_SolvedTime` int(11) DEFAULT '0',
  `P_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `Q_SolvedTime` int(11) DEFAULT '0',
  `Q_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `R_SolvedTime` int(11) DEFAULT '0',
  `R_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `S_SolvedTime` int(11) DEFAULT '0',
  `S_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `T_SolvedTime` int(11) DEFAULT '0',
  `T_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `U_SolvedTime` int(11) DEFAULT '0',
  `U_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `V_SolvedTime` int(11) DEFAULT '0',
  `V_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `W_SolvedTime` int(11) DEFAULT '0',
  `W_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `X_SolvedTime` int(11) DEFAULT '0',
  `X_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `Y_SolvedTime` int(11) DEFAULT '0',
  `Y_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `Z_SolvedTime` int(11) DEFAULT '0',
  `Z_WrongNum` tinyint(5) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of board
-- ----------------------------

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `parent` int(9) NOT NULL DEFAULT '0',
  `name` varchar(2048) NOT NULL,
  `zh` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '0', 'Graph Theory', '图论');
INSERT INTO `category` VALUES ('2', '1', '2-SAT', '2-SAT');
INSERT INTO `category` VALUES ('3', '1', 'Articulation/Bridge/Biconnected Component', '连通性');
INSERT INTO `category` VALUES ('4', '1', 'Cycles/Topological Sorting/Strongly Connected Component', '环/拓扑/强连通');
INSERT INTO `category` VALUES ('5', '1', 'Shortest Path', '最短路径');
INSERT INTO `category` VALUES ('6', '5', 'Bellman Ford/SPFA', 'Bellman Ford/SPFA');
INSERT INTO `category` VALUES ('7', '5', 'Dijkstra/Floyd Warshall', 'Dijkstra/Floyd Warshall');
INSERT INTO `category` VALUES ('8', '1', 'Euler Trail/Circuit', '欧拉路径/欧拉回路');
INSERT INTO `category` VALUES ('9', '1', 'Heavy-Light Decomposition', '动态树');
INSERT INTO `category` VALUES ('10', '1', 'Minimum Spanning Tree', '最小生成树');
INSERT INTO `category` VALUES ('11', '1', 'Directed Minimum Spanning Tree', '有向最小生成树');
INSERT INTO `category` VALUES ('12', '1', 'Stable Marriage Problem', '稳定婚姻匹配问题');
INSERT INTO `category` VALUES ('13', '1', 'Trees', '树');
INSERT INTO `category` VALUES ('14', '1', 'Flow/Matching', '流/匹配');
INSERT INTO `category` VALUES ('15', '14', 'Graph Matching', '一般图匹配');
INSERT INTO `category` VALUES ('16', '15', 'Bipartite Matching', '2分图匹配');
INSERT INTO `category` VALUES ('17', '15', 'Hopcroft–Karp Bipartite Matching', 'HK匹配');
INSERT INTO `category` VALUES ('18', '15', 'Weighted Bipartite Matching/Hungarian Algorithm', '加权图匹配/匈牙利算法');
INSERT INTO `category` VALUES ('19', '14', 'Flow', '流');
INSERT INTO `category` VALUES ('20', '19', 'Max Flow/Min Cut', '最大流/最小割');
INSERT INTO `category` VALUES ('21', '19', 'Min Cost Max Flow', '最小费用最大流');
INSERT INTO `category` VALUES ('22', '0', 'DFS-like', '搜索');
INSERT INTO `category` VALUES ('23', '22', 'Backtracking with Pruning/Branch and Bound', '回溯剪枝/分枝界限法\r\n');
INSERT INTO `category` VALUES ('24', '22', 'Basic Recursion', '递归');
INSERT INTO `category` VALUES ('25', '22', 'IDA* Search', '迭代加深搜索');
INSERT INTO `category` VALUES ('26', '22', 'Parsing/Grammar', '语法分析');
INSERT INTO `category` VALUES ('27', '22', 'Breadth First Search/Depth First Search', '广度/深度优先搜索');
INSERT INTO `category` VALUES ('28', '22', 'Advanced Search Techniques', '高级搜索技术');
INSERT INTO `category` VALUES ('29', '28', 'Binary Search/Bisection', '二分搜索');
INSERT INTO `category` VALUES ('30', '28', 'Ternary Search', '三叉树搜索');
INSERT INTO `category` VALUES ('31', '0', 'Geometry', '几何');
INSERT INTO `category` VALUES ('32', '32', 'Basic Geometry', '简单几何');
INSERT INTO `category` VALUES ('33', '32', 'Computational Geometry', '计算几何');
INSERT INTO `category` VALUES ('34', '32', 'Convex Hull', '凸包');
INSERT INTO `category` VALUES ('35', '32', 'Pick\'s Theorem', '皮克定理');
INSERT INTO `category` VALUES ('36', '0', 'Game Theory', '博弈论');
INSERT INTO `category` VALUES ('37', '36', 'Green Hackenbush/Colon Principle/Fusion Principle', 'Green Hackenbush/Colon Principle/Fusion Principle');
INSERT INTO `category` VALUES ('38', '36', 'Nim', 'Nim');
INSERT INTO `category` VALUES ('39', '36', 'Sprague-Grundy Number', 'SG值');
INSERT INTO `category` VALUES ('40', '0', 'Matrix', '矩阵');
INSERT INTO `category` VALUES ('41', '41', 'Gaussian Elimination', '高斯消元');
INSERT INTO `category` VALUES ('42', '41', 'Matrix Exponentiation', '矩阵求幂');
INSERT INTO `category` VALUES ('43', '0', 'Data Structures', '数据结构');
INSERT INTO `category` VALUES ('44', '43', 'Basic Data Structures', '简单数据结构');
INSERT INTO `category` VALUES ('45', '43', 'Binary Indexed Tree', '树状数组');
INSERT INTO `category` VALUES ('46', '43', 'Binary Search Tree', '二叉搜索树');
INSERT INTO `category` VALUES ('47', '43', 'Hashing', '哈希');
INSERT INTO `category` VALUES ('48', '43', 'Orthogonal Range Search', '正交范围搜索');
INSERT INTO `category` VALUES ('49', '43', 'Range Minimum Query/Lowest Common Ancestor', 'RMQ/LCA');
INSERT INTO `category` VALUES ('50', '43', 'Segment Tree/Interval Tree', '线段树/区间树');
INSERT INTO `category` VALUES ('51', '43', 'Trie Tree', '字典树');
INSERT INTO `category` VALUES ('52', '43', 'Sorting', '排序');
INSERT INTO `category` VALUES ('53', '43', 'Disjoint Set', '并查集');
INSERT INTO `category` VALUES ('54', '0', 'String', '字符串');
INSERT INTO `category` VALUES ('55', '54', 'Aho Corasick', 'AC自动机');
INSERT INTO `category` VALUES ('56', '54', 'Knuth-Morris-Pratt', 'KMP匹配');
INSERT INTO `category` VALUES ('57', '54', 'Suffix Array/Suffix Tree', '后缀数组/后缀树');
INSERT INTO `category` VALUES ('58', '0', 'Math', '数学');
INSERT INTO `category` VALUES ('59', '58', 'Basic Math', '基础数学');
INSERT INTO `category` VALUES ('60', '58', 'Big Integer Arithmetic', '高精度');
INSERT INTO `category` VALUES ('61', '58', 'Number Theory', '数论');
INSERT INTO `category` VALUES ('62', '61', 'Chinese Remainder Theorem', '中国同余定理');
INSERT INTO `category` VALUES ('64', '61', 'Inclusion/Exclusion', '容斥');
INSERT INTO `category` VALUES ('65', '61', 'Modular Arithmetic', '模运算');
INSERT INTO `category` VALUES ('66', '58', 'Combinatorics', '组合数学');
INSERT INTO `category` VALUES ('67', '66', 'Group Theory/Burnside\'s lemma', '集团理论/伯恩赛德引理');
INSERT INTO `category` VALUES ('68', '66', 'Counting', '计数');
INSERT INTO `category` VALUES ('69', '58', 'Probability/Expected Value', '概率/期望');
INSERT INTO `category` VALUES ('70', '0', 'Others', '其它');
INSERT INTO `category` VALUES ('71', '71', 'Tricky', '技巧');
INSERT INTO `category` VALUES ('72', '71', 'Hardest', '困难');
INSERT INTO `category` VALUES ('73', '71', 'Unusual', '罕见');
INSERT INTO `category` VALUES ('74', '71', 'Brute Force', '暴力');
INSERT INTO `category` VALUES ('75', '71', 'Implementation', '实现');
INSERT INTO `category` VALUES ('76', '71', 'Constructive Algorithms', '构造算法');
INSERT INTO `category` VALUES ('77', '71', 'Two Pointer', '');
INSERT INTO `category` VALUES ('78', '71', 'Bitmask', '位掩码');
INSERT INTO `category` VALUES ('79', '71', 'Beginner', '入门');
INSERT INTO `category` VALUES ('80', '71', 'Discrete Logarithm/Shank\'s Baby-step Giant-step Algorithm', '离散对数/');
INSERT INTO `category` VALUES ('81', '71', 'Greedy', '贪心');
INSERT INTO `category` VALUES ('82', '71', 'Divide and Conquer', '分治');
INSERT INTO `category` VALUES ('83', '0', 'Dynamic Programming', '动态规划');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `threadId` int(9) NOT NULL,
  `quoteId` int(9) DEFAULT NULL,
  `content` text NOT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for `contest`
-- ----------------------------
DROP TABLE IF EXISTS `contest`;
CREATE TABLE `contest` (
  `cid` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `startTime` int(11) DEFAULT '0',
  `endTime` int(11) DEFAULT '0',
  `description` text,
  `report` text,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `pass` varchar(255) DEFAULT NULL,
  `freeze` tinyint(1) NOT NULL DEFAULT '0',
  `atime` int(11) DEFAULT NULL,
  `ctime` int(11) DEFAULT NULL,
  `mtime` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cid`),
  KEY `search` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contest
-- ----------------------------

-- ----------------------------
-- Table structure for `contest_clarify`
-- ----------------------------
DROP TABLE IF EXISTS `contest_clarify`;
CREATE TABLE `contest_clarify` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `cid` int(9) NOT NULL,
  `num` tinyint(5) DEFAULT NULL,
  `uid` int(9) NOT NULL,
  `admin` int(9) DEFAULT NULL,
  `question` text NOT NULL,
  `reply` text,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL,
  `atime` int(11) DEFAULT NULL COMMENT 'answer timestamp',
  `mtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contest_clarify
-- ----------------------------

-- ----------------------------
-- Table structure for `contest_problem`
-- ----------------------------
DROP TABLE IF EXISTS `contest_problem`;
CREATE TABLE `contest_problem` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `cid` int(9) NOT NULL,
  `pid` int(9) NOT NULL,
  `title` char(255) NOT NULL,
  `num` tinyint(5) NOT NULL DEFAULT '0',
  `accepted` int(5) NOT NULL DEFAULT '0',
  `submission` int(5) NOT NULL DEFAULT '0',
  `firstBloodUid` int(9) NOT NULL DEFAULT '0' COMMENT 'first user(uid) solved this problem',
  `firstBloodTime` int(9) NOT NULL DEFAULT '-1' COMMENT 'first time(minutes) solved this problem',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contest_problem
-- ----------------------------

-- ----------------------------
-- Table structure for `contest_solution`
-- ----------------------------
DROP TABLE IF EXISTS `contest_solution`;
CREATE TABLE `contest_solution` (
  `sid` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `pid` int(9) NOT NULL,
  `cid` int(9) NOT NULL DEFAULT '0',
  `num` int(3) DEFAULT NULL,
  `result` int(5) NOT NULL,
  `time` int(9) DEFAULT NULL,
  `memory` int(9) DEFAULT NULL,
  `language` int(3) NOT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `test` tinyint(3) NOT NULL DEFAULT '0',
  `error` text,
  `source` text NOT NULL,
  `codeLen` int(9) NOT NULL DEFAULT '0',
  `systemError` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contest_solution
-- ----------------------------

-- ----------------------------
-- Table structure for `contest_user`
-- ----------------------------
DROP TABLE IF EXISTS `contest_user`;
CREATE TABLE `contest_user` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `cid` int(9) NOT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contest_user
-- ----------------------------

-- ----------------------------
-- Table structure for `freeze_board`
-- ----------------------------
DROP TABLE IF EXISTS `freeze_board`;
CREATE TABLE `freeze_board` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `cid` int(9) NOT NULL DEFAULT '0',
  `uid` int(9) NOT NULL,
  `solved` int(5) NOT NULL DEFAULT '0',
  `penalty` int(11) NOT NULL DEFAULT '0',
  `A_SolvedTime` int(11) DEFAULT '0',
  `A_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `B_SolvedTime` int(11) DEFAULT '0',
  `B_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `C_SolvedTime` int(11) DEFAULT '0',
  `C_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `D_SolvedTime` int(11) DEFAULT '0',
  `D_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `E_SolvedTime` int(11) DEFAULT '0',
  `E_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `F_SolvedTime` int(11) DEFAULT '0',
  `F_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `G_SolvedTime` int(11) DEFAULT '0',
  `G_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `H_SolvedTime` int(11) DEFAULT '0',
  `H_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `I_SolvedTime` int(11) DEFAULT '0',
  `I_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `J_SolvedTime` int(11) DEFAULT '0',
  `J_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `K_SolvedTime` int(11) DEFAULT '0',
  `K_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `L_SolvedTime` int(11) DEFAULT '0',
  `L_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `M_SolvedTime` int(11) DEFAULT '0',
  `M_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `N_SolvedTime` int(11) DEFAULT '0',
  `N_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `O_SolvedTime` int(11) DEFAULT '0',
  `O_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `P_SolvedTime` int(11) DEFAULT '0',
  `P_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `Q_SolvedTime` int(11) DEFAULT '0',
  `Q_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `R_SolvedTime` int(11) DEFAULT '0',
  `R_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `S_SolvedTime` int(11) DEFAULT '0',
  `S_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `T_SolvedTime` int(11) DEFAULT '0',
  `T_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `U_SolvedTime` int(11) DEFAULT '0',
  `U_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `V_SolvedTime` int(11) DEFAULT '0',
  `V_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `W_SolvedTime` int(11) DEFAULT '0',
  `W_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `X_SolvedTime` int(11) DEFAULT '0',
  `X_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `Y_SolvedTime` int(11) DEFAULT '0',
  `Y_WrongNum` tinyint(5) unsigned DEFAULT '0',
  `Z_SolvedTime` int(11) DEFAULT '0',
  `Z_WrongNum` tinyint(5) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of freeze_board
-- ----------------------------

-- ----------------------------
-- Table structure for `friend`
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `gid` int(9) NOT NULL DEFAULT '1',
  `userId` int(9) NOT NULL,
  `friendUid` int(9) NOT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend
-- ----------------------------

-- ----------------------------
-- Table structure for `friend_group`
-- ----------------------------
DROP TABLE IF EXISTS `friend_group`;
CREATE TABLE `friend_group` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `name` varchar(35) NOT NULL,
  `count` int(9) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend_group
-- ----------------------------
INSERT INTO `friend_group` VALUES ('1', '0', '', '0', '0');

-- ----------------------------
-- Table structure for `level`
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level` (
  `level` int(5) NOT NULL AUTO_INCREMENT,
  `exp` int(9) NOT NULL,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of level
-- ----------------------------
INSERT INTO `level` VALUES ('1', '10');
INSERT INTO `level` VALUES ('2', '20');
INSERT INTO `level` VALUES ('3', '40');
INSERT INTO `level` VALUES ('4', '80');
INSERT INTO `level` VALUES ('5', '160');
INSERT INTO `level` VALUES ('6', '320');
INSERT INTO `level` VALUES ('7', '640');
INSERT INTO `level` VALUES ('8', '1280');
INSERT INTO `level` VALUES ('9', '2560');
INSERT INTO `level` VALUES ('10', '5120');
INSERT INTO `level` VALUES ('11', '10240');
INSERT INTO `level` VALUES ('12', '20480');
INSERT INTO `level` VALUES ('13', '40960');
INSERT INTO `level` VALUES ('14', '81920');
INSERT INTO `level` VALUES ('15', '163840');
INSERT INTO `level` VALUES ('16', '327680');
INSERT INTO `level` VALUES ('17', '655360');
INSERT INTO `level` VALUES ('18', '1310720');
INSERT INTO `level` VALUES ('19', '2621440');
INSERT INTO `level` VALUES ('20', '5242880');

-- ----------------------------
-- Table structure for `loginlog`
-- ----------------------------
DROP TABLE IF EXISTS `loginlog`;
CREATE TABLE `loginlog` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL DEFAULT '0',
  `name` varchar(35) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginlog
-- ----------------------------

-- ----------------------------
-- Table structure for `mail`
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `mid` int(9) NOT NULL COMMENT 'mail id',
  `user` int(9) NOT NULL COMMENT 'user id',
  `peer` int(9) NOT NULL COMMENT 'peer uid',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=new, 1=read, 2=deleted',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mail
-- ----------------------------

-- ----------------------------
-- Table structure for `mail_banlist`
-- ----------------------------
DROP TABLE IF EXISTS `mail_banlist`;
CREATE TABLE `mail_banlist` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `bannedUid` int(9) NOT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mail_banlist
-- ----------------------------

-- ----------------------------
-- Table structure for `mail_content`
-- ----------------------------
DROP TABLE IF EXISTS `mail_content`;
CREATE TABLE `mail_content` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `fromUid` int(9) NOT NULL,
  `toUid` int(9) NOT NULL,
  `content` text,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mail_content
-- ----------------------------

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `editorUid` int(9) DEFAULT NULL,
  `cid` int(9) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `startTime` int(11) NOT NULL,
  `endTime` int(11) NOT NULL,
  `content` text,
  `atime` int(11) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) DEFAULT NULL,
  `view` int(9) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `module` varchar(20) NOT NULL,
  `type` tinyint(2) NOT NULL DEFAULT '1',
  `name` varchar(64) NOT NULL,
  `title` varchar(64) NOT NULL,
  `parentID` int(9) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', 'root', '1', '*', '所有权限', '0', '1');
INSERT INTO `permission` VALUES ('2', 'admin', '1', 'admin', '管理', '1', '1');
INSERT INTO `permission` VALUES ('3', 'admin', '1', 'admin:view:actionLog', '查看行为日志', '2', '1');
INSERT INTO `permission` VALUES ('4', 'admin', '1', 'admin:delete:actionLog', '删除行为日志', '2', '1');
INSERT INTO `permission` VALUES ('5', 'admin', '1', 'admin:view:setting', '查看设置', '2', '1');
INSERT INTO `permission` VALUES ('6', 'admin', '1', 'admin:view:content', '查看内容管理', '2', '1');
INSERT INTO `permission` VALUES ('7', 'admin', '1', 'admin:view:user', '查看用户管理', '2', '1');
INSERT INTO `permission` VALUES ('8', 'admin', '1', 'admin:edit:user', '编辑用户管理', '2', '1');
INSERT INTO `permission` VALUES ('9', 'admin', '1', 'admin:view:system', '查看系统管理', '2', '1');
INSERT INTO `permission` VALUES ('10', 'admin', '1', 'admin:edit:system', '编辑系统管理', '2', '1');
INSERT INTO `permission` VALUES ('11', 'admin', '1', 'admin:configure', '配置', '2', '1');
INSERT INTO `permission` VALUES ('12', 'admin', '1', 'admin:add:menu', '添加菜单', '2', '1');
INSERT INTO `permission` VALUES ('13', 'admin', '1', 'admin:edit:menu', '编辑菜单', '2', '1');
INSERT INTO `permission` VALUES ('14', 'admin', '1', 'admin:delete:menu', '删除菜单', '2', '1');
INSERT INTO `permission` VALUES ('15', 'admin', '1', 'admin:add:navigation', '添加导航', '2', '1');
INSERT INTO `permission` VALUES ('16', 'admin', '1', 'admin:edit:navigation', '编辑导航', '2', '1');
INSERT INTO `permission` VALUES ('17', 'admin', '1', 'admin:delete:navigation', '删除导航', '2', '1');
INSERT INTO `permission` VALUES ('18', 'admin', '1', 'admin:upload', '上传', '2', '1');
INSERT INTO `permission` VALUES ('19', 'admin', '1', 'admin:download', '下载', '2', '1');
INSERT INTO `permission` VALUES ('20', 'admin', '1', 'admin:add:plugin', '添加插件', '2', '1');
INSERT INTO `permission` VALUES ('21', 'admin', '1', 'admin:delete:plugin', '删除插件', '2', '1');
INSERT INTO `permission` VALUES ('22', 'system', '1', 'system', '系统', '1', '1');
INSERT INTO `permission` VALUES ('23', 'system', '1', 'system:viewInfo', '查看信息', '22', '1');
INSERT INTO `permission` VALUES ('24', 'system', '1', 'system:viewTask', '查看任务', '22', '1');
INSERT INTO `permission` VALUES ('25', 'system', '1', 'system:killTask', '杀死任务', '22', '1');
INSERT INTO `permission` VALUES ('26', 'system', '1', 'system:backup', '备份', '22', '1');
INSERT INTO `permission` VALUES ('27', 'system', '1', 'system:backup:db', '数据库', '26', '1');
INSERT INTO `permission` VALUES ('28', 'system', '1', 'system:restore:db', '恢复', '22', '1');
INSERT INTO `permission` VALUES ('29', 'system', '1', 'system:optimize:db', '优化', '22', '1');
INSERT INTO `permission` VALUES ('30', 'system', '1', 'system:repair:db', '修复', '22', '1');
INSERT INTO `permission` VALUES ('31', 'user', '1', 'user', '用户', '1', '1');
INSERT INTO `permission` VALUES ('32', 'user', '1', 'user:view', '查看', '31', '1');
INSERT INTO `permission` VALUES ('33', 'user', '1', 'user:view:normal', '普通', '32', '1');
INSERT INTO `permission` VALUES ('34', 'user', '1', 'user:view:self', '自己', '32', '1');
INSERT INTO `permission` VALUES ('35', 'user', '1', 'user:view:privacy', '隐私', '32', '1');
INSERT INTO `permission` VALUES ('36', 'user', '1', 'user:view:share', '分享', '32', '1');
INSERT INTO `permission` VALUES ('37', 'admin', '1', 'user:viewLog', '查看日志', '31', '1');
INSERT INTO `permission` VALUES ('38', 'user', '1', 'user:viewLog:self', '自己的', '37', '1');
INSERT INTO `permission` VALUES ('39', 'admin', '1', 'user:deleteLog', '删除日志', '31', '1');
INSERT INTO `permission` VALUES ('40', 'user', '1', 'user:deleteLog:self', '自己的', '39', '1');
INSERT INTO `permission` VALUES ('41', 'user', '1', 'user:search', '搜索', '31', '1');
INSERT INTO `permission` VALUES ('42', 'admin', '1', 'user:archive', '存档', '31', '1');
INSERT INTO `permission` VALUES ('43', 'user', '1', 'user:archive:self', '自己', '42', '1');
INSERT INTO `permission` VALUES ('44', 'admin', '1', 'user:add', '添加', '31', '1');
INSERT INTO `permission` VALUES ('45', 'admin', '1', 'user:edit', '编辑', '31', '1');
INSERT INTO `permission` VALUES ('46', 'user', '1', 'user:edit:self', '自己', '45', '1');
INSERT INTO `permission` VALUES ('47', 'user', '1', 'user:edit:nick', '昵称', '45', '1');
INSERT INTO `permission` VALUES ('48', 'user', '1', 'user:edit:password', '密码', '45', '1');
INSERT INTO `permission` VALUES ('49', 'user', '1', 'user:upload:avatar', '上传头像', '31', '1');
INSERT INTO `permission` VALUES ('50', 'admin', '1', 'user:delete', '删除', '31', '1');
INSERT INTO `permission` VALUES ('51', 'admin', '1', 'user:switch', '切换', '31', '1');
INSERT INTO `permission` VALUES ('52', 'admin', '1', 'user:forbid', '禁用', '31', '1');
INSERT INTO `permission` VALUES ('53', 'admin', '1', 'user:resume', '启用', '31', '1');
INSERT INTO `permission` VALUES ('54', 'admin', '1', 'user:build', '重建统计信息', '31', '1');
INSERT INTO `permission` VALUES ('55', 'admin', '1', 'user:buildRank', '重建排名', '31', '1');
INSERT INTO `permission` VALUES ('56', 'group', '1', 'group', '用户组', '1', '1');
INSERT INTO `permission` VALUES ('57', 'group', '1', 'group:view', '查看', '56', '1');
INSERT INTO `permission` VALUES ('58', 'admin', '1', 'group:add', '添加', '56', '1');
INSERT INTO `permission` VALUES ('59', 'admin', '1', 'group:addUser', '添加用户', '56', '1');
INSERT INTO `permission` VALUES ('60', 'admin', '1', 'group:removeUser', '移除用户', '56', '1');
INSERT INTO `permission` VALUES ('61', 'admin', '1', 'group:edit', '编辑', '56', '1');
INSERT INTO `permission` VALUES ('62', 'admin', '1', 'group:delete', '删除', '56', '1');
INSERT INTO `permission` VALUES ('63', 'admin', '1', 'group:forbid', '禁用', '56', '1');
INSERT INTO `permission` VALUES ('64', 'admin', '1', 'group:resume', '启用', '56', '1');
INSERT INTO `permission` VALUES ('65', 'admin', '1', 'permission', '权限', '1', '1');
INSERT INTO `permission` VALUES ('66', 'admin', '1', 'permission:add', '添加', '65', '1');
INSERT INTO `permission` VALUES ('67', 'admin', '1', 'permission:view', '查看', '65', '1');
INSERT INTO `permission` VALUES ('68', 'admin', '1', 'permission:edit', '编辑', '65', '1');
INSERT INTO `permission` VALUES ('69', 'admin', '1', 'permission:delete', '删除', '65', '1');
INSERT INTO `permission` VALUES ('70', 'admin', '1', 'permission:forbid', '禁用', '65', '1');
INSERT INTO `permission` VALUES ('71', 'admin', '1', 'permission:resume', '启用', '65', '1');
INSERT INTO `permission` VALUES ('72', 'problem', '1', 'problem', '题目', '1', '1');
INSERT INTO `permission` VALUES ('73', '', '1', 'problem:view', '查看', '72', '1');
INSERT INTO `permission` VALUES ('74', 'problem', '1', 'problem:view:normal', '普通', '73', '1');
INSERT INTO `permission` VALUES ('75', 'problem', '1', 'problem:status', '状态', '72', '1');
INSERT INTO `permission` VALUES ('76', 'problem', '1', 'problem:discuss', '讨论', '72', '1');
INSERT INTO `permission` VALUES ('77', 'problem', '1', 'problem:submit', '提交', '72', '1');
INSERT INTO `permission` VALUES ('78', 'problem', '1', 'problem:search', '搜索', '72', '1');
INSERT INTO `permission` VALUES ('79', 'admin', '1', 'problem:add', '添加', '72', '1');
INSERT INTO `permission` VALUES ('80', 'admin', '1', 'problem:edit', '编辑', '72', '1');
INSERT INTO `permission` VALUES ('81', 'admin', '1', 'problem:edit:title', '标题', '80', '1');
INSERT INTO `permission` VALUES ('82', 'admin', '1', 'problem:edit:hint', '提示', '80', '1');
INSERT INTO `permission` VALUES ('83', 'admin', '1', 'problem:edit:source', '来源', '80', '1');
INSERT INTO `permission` VALUES ('84', '', '1', 'problem:addTag', '添加标签', '72', '1');
INSERT INTO `permission` VALUES ('85', 'problem', '1', 'problem:viewTag', '查看标签', '72', '1');
INSERT INTO `permission` VALUES ('86', 'admin', '1', 'problem:editTag', '编辑标签', '72', '1');
INSERT INTO `permission` VALUES ('87', 'admin', '1', 'problem:deleteTag', '删除标签', '72', '1');
INSERT INTO `permission` VALUES ('88', 'admin', '1', 'problem:delete', '删除', '72', '1');
INSERT INTO `permission` VALUES ('89', 'admin', '1', 'problem:forbid', '禁用', '72', '1');
INSERT INTO `permission` VALUES ('90', 'admin', '1', 'problem:resume', '启用', '72', '1');
INSERT INTO `permission` VALUES ('91', 'admin', '1', 'problem:rejudge', '重判', '72', '1');
INSERT INTO `permission` VALUES ('92', 'admin', '1', 'problem:rebuild', '重建统计信息', '72', '1');
INSERT INTO `permission` VALUES ('93', 'admin', '1', 'problem:import', '导入', '72', '1');
INSERT INTO `permission` VALUES ('94', 'admin', '1', 'problem:export', '导出', '72', '1');
INSERT INTO `permission` VALUES ('95', 'admin', '1', 'problem:upload', '上传', '72', '1');
INSERT INTO `permission` VALUES ('96', 'admin', '1', 'problem:upload:image', '图片', '95', '1');
INSERT INTO `permission` VALUES ('97', 'admin', '1', 'problem:upload:data', '数据', '95', '1');
INSERT INTO `permission` VALUES ('98', 'admin', '1', 'problem:viewData', '查看数据', '72', '1');
INSERT INTO `permission` VALUES ('99', 'admin', '1', 'problem:editData', '编辑数据', '72', '1');
INSERT INTO `permission` VALUES ('100', 'admin', '1', 'problem:deleteData', '删除数据', '72', '1');
INSERT INTO `permission` VALUES ('101', 'contest', '1', 'contest', '比赛', '1', '1');
INSERT INTO `permission` VALUES ('102', 'contest', '1', 'contest:view', '查看', '101', '1');
INSERT INTO `permission` VALUES ('103', 'contest', '1', 'contest:view:normal', '普通', '102', '1');
INSERT INTO `permission` VALUES ('104', 'contest', '1', 'contest:view:public', '公开', '102', '1');
INSERT INTO `permission` VALUES ('105', 'contest', '1', 'contest:view:private', '私有', '102', '1');
INSERT INTO `permission` VALUES ('106', 'contest', '1', 'contest:view:password', '密码访问', '102', '1');
INSERT INTO `permission` VALUES ('107', 'contest', '1', 'contest:viewCode', '查看代码', '101', '1');
INSERT INTO `permission` VALUES ('108', 'contest', '1', 'contest:viewCode:self', '自己', '101', '1');
INSERT INTO `permission` VALUES ('109', 'contest', '1', 'contest:submit', '提交', '101', '1');
INSERT INTO `permission` VALUES ('110', 'contest', '1', 'contest:discuss', '讨论', '101', '1');
INSERT INTO `permission` VALUES ('111', 'admin', '1', 'contest:add', '添加', '101', '1');
INSERT INTO `permission` VALUES ('112', 'admin', '1', 'contest:edit', '编辑', '101', '1');
INSERT INTO `permission` VALUES ('113', 'admin', '1', 'contest:edit:title', '标题', '112', '1');
INSERT INTO `permission` VALUES ('114', 'admin', '1', 'contest:edit:time', '时间', '112', '1');
INSERT INTO `permission` VALUES ('115', 'admin', '1', 'contest:edit:type', '类型', '112', '1');
INSERT INTO `permission` VALUES ('116', 'admin', '1', 'contest:edit:description', '描述', '112', '1');
INSERT INTO `permission` VALUES ('117', 'admin', '1', 'contest:freezeBoard', '封榜', '101', '1');
INSERT INTO `permission` VALUES ('118', 'admin', '1', 'contest:notify', '通知', '101', '1');
INSERT INTO `permission` VALUES ('119', 'admin', '1', 'contest:addProblem', '添加题目', '101', '1');
INSERT INTO `permission` VALUES ('120', 'contest', '1', 'contest:viewProblem', '查看题目', '101', '1');
INSERT INTO `permission` VALUES ('121', 'admin', '1', 'contest:editProblem', '编辑题目', '101', '1');
INSERT INTO `permission` VALUES ('122', 'admin', '1', 'contest:removeProblem', '移除题目', '101', '1');
INSERT INTO `permission` VALUES ('123', 'admin', '1', 'contest:addUser', '添加用户', '101', '1');
INSERT INTO `permission` VALUES ('124', 'admin', '1', 'contest:removeUser', '移除用户', '101', '1');
INSERT INTO `permission` VALUES ('125', 'admin', '1', 'contest:addGroup', '添加用户组', '101', '1');
INSERT INTO `permission` VALUES ('126', 'admin', '1', 'contest:removeGroup', '移除用户组', '101', '1');
INSERT INTO `permission` VALUES ('127', 'admin', '1', 'contest:copy', '复制', '101', '1');
INSERT INTO `permission` VALUES ('128', 'admin', '1', 'contest:import', '导入', '101', '1');
INSERT INTO `permission` VALUES ('129', 'admin', '1', 'contest:export', '导出', '101', '1');
INSERT INTO `permission` VALUES ('130', 'admin', '1', 'contest:rejudge', '重判', '101', '1');
INSERT INTO `permission` VALUES ('131', 'admin', '1', 'contest:buildRank', '重建排名', '101', '1');
INSERT INTO `permission` VALUES ('132', 'code', '1', 'code', '代码', '1', '1');
INSERT INTO `permission` VALUES ('133', 'admin', '1', 'code:view', '查看', '132', '1');
INSERT INTO `permission` VALUES ('134', 'code', '1', 'code:view:self', '自己', '133', '1');
INSERT INTO `permission` VALUES ('135', 'code', '1', 'code:view:share', '分享', '133', '1');
INSERT INTO `permission` VALUES ('136', 'code', '1', 'code:search', '搜索', '132', '1');
INSERT INTO `permission` VALUES ('137', 'code', '1', 'code:add', '添加', '132', '1');
INSERT INTO `permission` VALUES ('138', 'code', '1', 'code:edit', '编辑', '132', '1');
INSERT INTO `permission` VALUES ('139', 'code', '1', 'code:edit:self', '自己', '138', '1');
INSERT INTO `permission` VALUES ('140', 'code', '1', 'code:judge', '评测', '132', '1');
INSERT INTO `permission` VALUES ('141', 'admin', '1', 'code:rejudge', '重判', '132', '1');
INSERT INTO `permission` VALUES ('142', 'mail', '1', 'mail', '邮件', '1', '1');
INSERT INTO `permission` VALUES ('143', '', '1', 'mail:view', '查看', '142', '1');
INSERT INTO `permission` VALUES ('144', 'mail', '1', 'mail:view:self', '自己', '143', '1');
INSERT INTO `permission` VALUES ('145', 'mail', '1', 'mail:send', '发送', '142', '1');
INSERT INTO `permission` VALUES ('146', 'admin', '1', 'mail:massSend', '群发', '142', '1');
INSERT INTO `permission` VALUES ('147', '', '1', 'mail:delete', '删除', '142', '1');
INSERT INTO `permission` VALUES ('148', 'mail', '1', 'mail:delete:self', '自己', '147', '1');
INSERT INTO `permission` VALUES ('149', 'mail', '1', 'mail:clean:self', '清空', '142', '1');
INSERT INTO `permission` VALUES ('150', 'comment', '1', 'comment', '评论', '1', '1');
INSERT INTO `permission` VALUES ('151', '', '1', 'comment:view', '查看', '150', '1');
INSERT INTO `permission` VALUES ('152', 'comment', '1', 'comment:view:normal', '普通', '151', '1');
INSERT INTO `permission` VALUES ('153', 'comment', '1', 'comment:add', '添加', '150', '1');
INSERT INTO `permission` VALUES ('154', 'admin', '1', 'comment:edit', '编辑', '150', '1');
INSERT INTO `permission` VALUES ('155', 'comment', '1', 'comment:edit:self', '自己', '154', '1');
INSERT INTO `permission` VALUES ('156', 'admin', '1', 'comment:delete', '删除', '150', '1');
INSERT INTO `permission` VALUES ('157', 'comment', '1', 'comment:delete:self', '自己', '156', '1');
INSERT INTO `permission` VALUES ('158', 'admin', '1', 'comment:audit', '审核', '150', '1');
INSERT INTO `permission` VALUES ('159', 'admin', '1', 'comment:top', '置顶', '150', '1');
INSERT INTO `permission` VALUES ('160', 'admin', '1', 'comment:forbid', '禁用', '150', '1');
INSERT INTO `permission` VALUES ('161', 'admin', '1', 'comment:resume', '启用', '150', '1');
INSERT INTO `permission` VALUES ('162', 'announcement', '1', 'announcement', '公告', '1', '1');
INSERT INTO `permission` VALUES ('163', '', '1', 'announcement:view', '查看', '162', '1');
INSERT INTO `permission` VALUES ('164', 'announcement', '1', 'announcement:view:normal', '普通', '163', '1');
INSERT INTO `permission` VALUES ('165', '', '1', 'announcement:list', '列表', '162', '1');
INSERT INTO `permission` VALUES ('166', 'announcement', '1', 'announcement:list:normal', '普通', '165', '1');
INSERT INTO `permission` VALUES ('167', 'admin', '1', 'announcement:add', '添加', '162', '1');
INSERT INTO `permission` VALUES ('168', 'admin', '1', 'announcement:edit', '编辑', '162', '1');
INSERT INTO `permission` VALUES ('169', 'admin', '1', 'announcement:edit:title', '标题', '168', '1');
INSERT INTO `permission` VALUES ('170', 'admin', '1', 'announcement:edit:time', '时间', '168', '1');
INSERT INTO `permission` VALUES ('171', 'admin', '1', 'announcement:delete', '删除', '168', '1');
INSERT INTO `permission` VALUES ('172', 'admin', '1', 'announcement:forbid', '禁用', '162', '1');
INSERT INTO `permission` VALUES ('173', 'admin', '1', 'announcement:resume', '启用', '162', '1');

-- ----------------------------
-- Table structure for `problem`
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem` (
  `pid` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `input` text,
  `output` text,
  `sampleInput` text,
  `sampleOutput` text,
  `hint` text,
  `source` varchar(255) DEFAULT NULL,
  `sampleProgram` text,
  `timeLimit` int(5) NOT NULL DEFAULT '1000',
  `memoryLimit` int(5) NOT NULL DEFAULT '65536',
  `atime` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `stime` int(11) NOT NULL DEFAULT '0',
  `accepted` int(5) NOT NULL DEFAULT '0',
  `solved` int(5) NOT NULL DEFAULT '0',
  `submission` int(5) NOT NULL DEFAULT '0',
  `submitUser` int(5) NOT NULL DEFAULT '0',
  `error` int(5) NOT NULL DEFAULT '0',
  `ratio` tinyint(4) NOT NULL DEFAULT '0',
  `difficulty` tinyint(4) NOT NULL DEFAULT '0',
  `view` int(9) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problem
-- ----------------------------

-- ----------------------------
-- Table structure for `problem_category`
-- ----------------------------
DROP TABLE IF EXISTS `problem_category`;
CREATE TABLE `problem_category` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `pid` int(9) NOT NULL,
  `cid` int(9) NOT NULL,
  `weight` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problem_category
-- ----------------------------

-- ----------------------------
-- Table structure for `program_language`
-- ----------------------------
DROP TABLE IF EXISTS `program_language`;
CREATE TABLE `program_language` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `extTime` int(9) NOT NULL DEFAULT '0',
  `extMemory` int(9) NOT NULL DEFAULT '0',
  `timeFactor` tinyint(3) NOT NULL DEFAULT '1',
  `memoryFactor` tinyint(3) NOT NULL DEFAULT '1',
  `ext` varchar(9) NOT NULL,
  `exe` varchar(9) NOT NULL,
  `complieOrder` tinyint(3) NOT NULL DEFAULT '0',
  `compileCmd` varchar(255) NOT NULL,
  `brush` varchar(15) DEFAULT '' COMMENT 'SyntaxHighlighter brush',
  `script` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of program_language
-- ----------------------------
INSERT INTO `program_language` VALUES ('1', 'GCC', '', '0', '996', '1', '1', 'c', 'exe', '1', 'C:\\power\\oj\\JudgeOnline\\bin\\gcc\\bin\\gcc.exe -fno-asm -s -w -O1 -DONLINE_JUDGE -o %PATH%%NAME% %PATH%%NAME%.%EXT%', 'cpp', '0', '1');
INSERT INTO `program_language` VALUES ('2', 'G++', '', '0', '996', '1', '1', 'cc', 'exe', '1', 'C:\\power\\oj\\JudgeOnline\\bin\\gcc\\bin\\g++.exe -fno-asm -s -w -O1 -DONLINE_JUDGE -o %PATH%%NAME% %PATH%%NAME%.%EXT%', 'cpp', '0', '1');
INSERT INTO `program_language` VALUES ('3', 'Pascal', '', '0', '1000', '1', '1', 'pas', 'exe', '0', 'C:\\power\\oj\\JudgeOnline\\bin\\fpc\\fpc.exe -Sg -dONLINE_JUDGE %PATH%%NAME%.%EXT%', 'pascal', '0', '1');
INSERT INTO `program_language` VALUES ('4', 'Java', '', '0', '8000', '3', '3', 'java', 'class', '2', 'C:\\power\\oj\\JudgeOnline\\bin\\Java\\Java.bat %PATH%', 'java', '0', '1');
INSERT INTO `program_language` VALUES ('5', 'Python', '', '0', '7000', '4', '3', 'py', 'exe', '1', 'C:\\power\\oj\\JudgeOnline\\bin\\Python\\Python.bat %PATH% %NAME% %EXT%', 'python', '0', '1');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(80) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'root', 'root', '1');
INSERT INTO `role` VALUES ('2', 'admin', 'administrator', '1');
INSERT INTO `role` VALUES ('3', 'user', 'normal user', '1');

-- ----------------------------
-- Table structure for `role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `rid` int(9) NOT NULL,
  `pid` int(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '1', '1');
INSERT INTO `role_permission` VALUES ('2', '2', '2');
INSERT INTO `role_permission` VALUES ('3', '3', '77');

-- ----------------------------
-- Table structure for `session`
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `sessionId` varchar(40) NOT NULL DEFAULT '0',
  `uid` int(9) NOT NULL DEFAULT '0',
  `name` varchar(35) DEFAULT NULL,
  `ipAddress` varchar(45) NOT NULL DEFAULT '0',
  `userAgent` varchar(255) DEFAULT '',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT 'Session create time.',
  `lastActivity` int(11) NOT NULL DEFAULT '0',
  `sessionExpires` int(11) NOT NULL,
  `uri` varchar(255) DEFAULT '',
  PRIMARY KEY (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of session
-- ----------------------------

-- ----------------------------
-- Table structure for `solution`
-- ----------------------------
DROP TABLE IF EXISTS `solution`;
CREATE TABLE `solution` (
  `sid` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `pid` int(9) NOT NULL,
  `cid` int(9) NOT NULL DEFAULT '0',
  `num` int(3) DEFAULT NULL,
  `result` int(5) NOT NULL,
  `time` int(9) DEFAULT NULL,
  `memory` int(9) DEFAULT NULL,
  `language` int(3) NOT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `test` tinyint(3) NOT NULL DEFAULT '0',
  `error` text,
  `source` text NOT NULL,
  `codeLen` int(9) NOT NULL DEFAULT '0',
  `systemError` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of solution
-- ----------------------------

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `pid` int(5) unsigned NOT NULL DEFAULT '0',
  `uid` int(9) DEFAULT NULL,
  `tag` varchar(45) NOT NULL DEFAULT '',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for `team`
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `tid` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `name1` varchar(30) NOT NULL,
  `stuId1` varchar(16) NOT NULL,
  `college1` varchar(50) NOT NULL,
  `class1` varchar(20) NOT NULL,
  `gender1` enum('female','male') NOT NULL,
  `contact1` varchar(100) NOT NULL,
  `name2` varchar(30) DEFAULT NULL,
  `stuId2` varchar(16) DEFAULT NULL,
  `college2` varchar(50) DEFAULT NULL,
  `class2` varchar(20) DEFAULT NULL,
  `gender2` enum('female','male') DEFAULT NULL,
  `contact2` varchar(100) DEFAULT NULL,
  `name3` varchar(30) DEFAULT NULL,
  `stuId3` varchar(16) DEFAULT NULL,
  `college3` varchar(50) DEFAULT NULL,
  `class3` varchar(20) DEFAULT NULL,
  `gender3` enum('female','male') DEFAULT NULL,
  `contact3` varchar(100) DEFAULT NULL,
  `notice` tinyint(1) NOT NULL DEFAULT '1',
  `comment` varchar(200) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `history` text,
  `year` int(4) DEFAULT NULL,
  `isGirlTeam` tinyint(1) NOT NULL DEFAULT '0',
  `isRookieTeam` tinyint(1) NOT NULL DEFAULT '0',
  `isSpecialTeam` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of team
-- ----------------------------

-- ----------------------------
-- Table structure for `topic`
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `pid` int(9) DEFAULT NULL,
  `threadId` int(9) DEFAULT 0,
  `parentId` int(9) DEFAULT 0,
  `orderNum` int(9) DEFAULT 0,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `view` int(9) NOT NULL DEFAULT '0',
  `atime` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(9) NOT NULL AUTO_INCREMENT COMMENT 'Unique user ID, internal use.',
  `tid` int(9) NOT NULL DEFAULT '0' COMMENT 'refere team id.',
  `name` varchar(35) NOT NULL COMMENT 'unique user login name.',
  `password` varchar(128) NOT NULL COMMENT 'User password (hashed).',
  `nick` varchar(255) DEFAULT NULL COMMENT 'nick',
  `realName` varchar(35) DEFAULT NULL,
  `regEmail` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL COMMENT 'User’s e-mail address.',
  `emailVerified` tinyint(1) NOT NULL DEFAULT '0',
  `language` int(5) NOT NULL DEFAULT '0',
  `school` varchar(65) DEFAULT NULL,
  `solved` int(6) NOT NULL DEFAULT '0' COMMENT 'the number of problems user solved',
  `accepted` int(6) NOT NULL DEFAULT '0',
  `submission` int(6) NOT NULL DEFAULT '0' COMMENT 'the number of user submit code',
  `atime` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `mtime` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user edit its profile.',
  `loginTime` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user last login.',
  `loginIP` varchar(64) DEFAULT NULL,
  `phone` varchar(35) DEFAULT NULL,
  `qq` varchar(15) DEFAULT NULL,
  `blog` varchar(255) DEFAULT NULL,
  `gender` enum('female','male','secret') NOT NULL DEFAULT 'secret',
  `comeFrom` varchar(35) DEFAULT NULL,
  `online` int(9) NOT NULL DEFAULT '0',
  `shareCode` tinyint(1) NOT NULL DEFAULT '0',
  `avatar` varchar(255) DEFAULT NULL COMMENT 'user avatar path',
  `signature` varchar(255) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT 'Whether the user is active(1) or blocked(0).',
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1000', '0', 'root', '$2a$10$lyKeLNMNYC6eXhmTb6CMb.NvtMS1SfQTIZRCddnoes6sGfk4gwsQS', null, null, 'admin@local.host', 'admin@local.host', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '127.0.0.1', null, null, null, 'secret', null, '118', '0', '', null, '1', null);

-- ----------------------------
-- Table structure for `user_ext`
-- ----------------------------
DROP TABLE IF EXISTS `user_ext`;
CREATE TABLE `user_ext` (
  `uid` int(9) NOT NULL,
  `tid` int(9) NOT NULL DEFAULT '0',
  `realName` varchar(35) DEFAULT NULL,
  `phone` varchar(35) DEFAULT NULL,
  `qq` varchar(15) DEFAULT NULL,
  `blog` varchar(255) DEFAULT NULL,
  `shareCode` tinyint(1) NOT NULL DEFAULT '0',
  `online` int(9) NOT NULL DEFAULT '0',
  `level` int(9) NOT NULL DEFAULT '1',
  `credit` int(9) NOT NULL DEFAULT '0',
  `experience` int(9) NOT NULL DEFAULT '0',
  `checkin` int(11) NOT NULL DEFAULT '0',
  `checkinTimes` tinyint(5) NOT NULL DEFAULT '0',
  `totalCheckin` int(9) NOT NULL DEFAULT '0',
  `lastSendDrift` int(11) NOT NULL DEFAULT '0',
  `sendDriftNum` tinyint(3) NOT NULL DEFAULT '0',
  `lastGetDrift` int(11) NOT NULL DEFAULT '0',
  `getDriftNum` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_ext
-- ----------------------------
INSERT INTO `user_ext` VALUES ('1000', '0', null, null, null, null, '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `rid` int(9) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1000', '1', '1');

-- ----------------------------
-- Table structure for `variable`
-- ----------------------------
DROP TABLE IF EXISTS `variable`;
CREATE TABLE `variable` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `stringValue` varchar(255) DEFAULT NULL,
  `booleanValue` tinyint(1) DEFAULT NULL,
  `intValue` int(11) DEFAULT NULL,
  `textValue` text,
  `type` enum('boolean','int','string','text') NOT NULL DEFAULT 'string',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of variable
-- ----------------------------
INSERT INTO `variable` VALUES ('1', 'workPath', '/home/power/oj/temp', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('2', 'dataPath', '/home/power/oj/data', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('3', 'runShell', 'C:\\power\\oj\\JudgeOnline\\bin\\run.exe', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('4', 'compileShell', 'C:\\power\\oj\\JudgeOnline\\bin\\com.exe', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('5', 'adminName', 'root', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('6', 'adminMail', 'root@localhost.com', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('7', 'debugFile', 'debug.log', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('8', 'errorFile', 'error.log', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('9', 'deleteTmpFile', '1', '1', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('10', 'debug', '0', '0', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('11', 'enableLogin', '1', '1', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('12', 'enableMail', '1', '1', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('13', 'enableSource', '1', '1', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('14', 'enableArchive', '1', '1', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('15', 'openid_qq', '', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('16', 'openkey_qq', '', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('17', 'redirect_qq', 'http://power-oj.com/api/oauth/qq/callback', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('18', 'enable_qq_login', '1', '1', null, null, 'boolean', null);
INSERT INTO `variable` VALUES ('19', 'openid_sina', '', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('20', 'openkey_sina', '', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('21', 'redirect_sina', 'http://power-oj.com/api/oauth/sina/callback', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('22', 'adminEmail', 'swust_acm@163.com', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('23', 'emailServer', 'smtp.163.com', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('24', 'emailUser', '', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('25', 'emailPass', '', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('26', 'version', '20140221', null, null, null, 'string', null);
INSERT INTO `variable` VALUES ('27', 'siteTitle', 'Power OJ', null, null, null, 'string', null);

-- ----------------------------
-- Table structure for `web_login`
-- ----------------------------
DROP TABLE IF EXISTS `web_login`;
CREATE TABLE `web_login` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `openId` varchar(64) NOT NULL,
  `uid` int(9) DEFAULT NULL,
  `nick` varchar(64) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_login
-- ----------------------------
