/*
SQLyog Professional v9.20 
MySQL - 5.0.45 : Database - teleservices
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`teleservices` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `teleservices`;

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `book` varchar(100) NOT NULL default '',
  `abbr` varchar(6) NOT NULL default '',
  `lower48` varchar(6) NOT NULL default '',
  `longtitle` varchar(80) default NULL,
  `server` varchar(16) default NULL,
  `estart` varchar(5) default '7.00',
  `cstart` varchar(5) default '10.00',
  `mstart` varchar(5) default '10.25',
  `pstart` varchar(5) default '11.00',
  `elunchb` varchar(5) default '11.15',
  `clunchb` varchar(5) default '11.15',
  `mlunchb` varchar(5) default '12.00',
  `plunchb` varchar(5) default '13.00',
  `elunche` varchar(5) default '12.00',
  `clunche` varchar(5) default '13.00',
  `mlunche` varchar(5) default '14.25',
  `plunche` varchar(5) default '15.00',
  `estop` varchar(5) default '14.25',
  `cstop` varchar(5) default '15.15',
  `mstop` varchar(5) default '17.00',
  `pstop` varchar(5) default '23.75',
  PRIMARY KEY  (`book`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `contact` */

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `clientnum` varchar(32) NOT NULL default '',
  `phone` varchar(13) NOT NULL default '',
  `fax` varchar(13) default '',
  `subcode` varchar(10) NOT NULL default '',
  `fname` varchar(30) default '',
  `lname` varchar(30) default '',
  `fullname` varchar(50) default '',
  `title` varchar(30) default '',
  `orgname` varchar(30) default '',
  `department` varchar(30) default '',
  `address` varchar(30) default '',
  `city` varchar(30) default '',
  `st` char(2) default '',
  `country` varchar(30) default '',
  `zip` varchar(10) default '',
  `csr` varchar(30) default '',
  `completed` datetime default '0000-00-00 00:00:00',
  `reason` varchar(30) default '',
  `requeue` datetime default '0000-00-00 00:00:00',
  `reqcnt` int(1) NOT NULL default '0',
  `email` varchar(100) default '',
  `book` varchar(60) NOT NULL default '',
  `extension` varchar(12) default NULL,
  `uniqueid` varchar(80) default NULL,
  PRIMARY KEY  (`book`,`clientnum`),
  FULLTEXT KEY `SELECTOR` (`csr`,`book`,`phone`,`reason`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `donotcall` */

DROP TABLE IF EXISTS `donotcall`;

CREATE TABLE `donotcall` (
  `phone` varchar(15) NOT NULL default '',
  `reason` varchar(60) default NULL,
  PRIMARY KEY  (`phone`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `import_headers` */

DROP TABLE IF EXISTS `import_headers`;

CREATE TABLE `import_headers` (
  `label` varchar(30) NOT NULL,
  `field` varchar(12) NOT NULL,
  PRIMARY KEY  (`label`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `book` varchar(30) NOT NULL default '',
  `phone` varchar(100) NOT NULL default '',
  `clientnum` varchar(32) default NULL,
  `csr` varchar(100) NOT NULL default '',
  `eventTime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `eventType` text NOT NULL,
  `eventData` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `mysql_auth` */

DROP TABLE IF EXISTS `mysql_auth`;

CREATE TABLE `mysql_auth` (
  `username` varchar(25) NOT NULL default '',
  `passwd` varchar(25) default NULL,
  `book` varchar(50) default '',
  `subcode` varchar(12) default '',
  `groups` varchar(25) default NULL,
  `chatmessage` varchar(255) default NULL,
  `extension` varchar(10) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `phonequeue` */

DROP TABLE IF EXISTS `phonequeue`;

CREATE TABLE `phonequeue` (
  `fullname` varchar(50) default '',
  `fname` varchar(30) default '',
  `lname` varchar(30) default '',
  `clientnum` varchar(32) NOT NULL default '',
  `book` varchar(60) NOT NULL default '',
  `phone` varchar(13) NOT NULL default '',
  `ltime` int(1) NOT NULL default '0',
  `requeue` datetime NOT NULL default '0000-00-00 00:00:00',
  `reason` varchar(30) NOT NULL default '',
  `subcode` varchar(10) NOT NULL default '',
  `reqcnt` int(1) NOT NULL default '0',
  PRIMARY KEY  (`reason`,`ltime`,`reqcnt`,`book`,`clientnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `quest2` */

DROP TABLE IF EXISTS `quest2`;

CREATE TABLE `quest2` (
  `cid` varchar(60) NOT NULL default '',
  `qid` varchar(5) NOT NULL default '',
  `qtext` varchar(255) NOT NULL default '',
  `qtype` varchar(5) NOT NULL default '',
  `sid` varchar(5) NOT NULL default '',
  `stext` varchar(255) default NULL,
  `stype` varchar(5) default NULL,
  `qopt` char(1) NOT NULL default 'N',
  `qdef` char(1) NOT NULL default 'Y',
  `qlast` char(1) default 'N',
  PRIMARY KEY  (`cid`,`qid`,`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `questrep` */

DROP TABLE IF EXISTS `questrep`;

CREATE TABLE `questrep` (
  `cid` varchar(60) NOT NULL default '',
  `qid` varchar(5) NOT NULL default '',
  `sid` varchar(5) NOT NULL default '',
  `qresp` varchar(255) default NULL,
  `qother` varchar(255) default NULL,
  `phone` varchar(13) NOT NULL default '',
  `clientnum` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`cid`,`qid`,`sid`,`clientnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `report` */

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
  `abbr` varchar(8) NOT NULL default 'CSV' COMMENT 'Book Abbreviation',
  `reportType` varchar(8) NOT NULL default 'CSV',
  `header` varchar(30) default NULL,
  `srcField` varchar(30) NOT NULL COMMENT 'Database Field',
  `col` int(5) NOT NULL,
  `length` int(4) default NULL,
  `transform` varchar(30) default NULL COMMENT 'Transform Function',
  `literal` varchar(255) default NULL,
  PRIMARY KEY  (`abbr`,`col`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `resp2` */

DROP TABLE IF EXISTS `resp2`;

CREATE TABLE `resp2` (
  `cid` varchar(60) NOT NULL default '',
  `qid` varchar(5) NOT NULL default '',
  `sid` varchar(5) NOT NULL default '',
  `rlabel` varchar(255) NOT NULL default '',
  `rtext` varchar(255) NOT NULL default '',
  `rother` char(1) default NULL,
  PRIMARY KEY  (`cid`,`qid`,`sid`,`rlabel`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `subquestion` */

DROP TABLE IF EXISTS `subquestion`;

CREATE TABLE `subquestion` (
  `qid` varchar(30) default NULL,
  `qnum` int(10) default NULL,
  `ansnum` int(10) default NULL,
  `anstext` varchar(60) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `timezone` */

DROP TABLE IF EXISTS `timezone`;

CREATE TABLE `timezone` (
  `areacode` char(3) NOT NULL default '800',
  `statecode` char(2) NOT NULL default 'XX',
  `utcoffset` int(10) NOT NULL default '-6',
  `lower48` char(1) NOT NULL default 'Y',
  `notes` varchar(250) default NULL,
  PRIMARY KEY  (`areacode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
