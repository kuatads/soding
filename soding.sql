/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.17 : Database - sodingdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sodingdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sodingdb`;

/*Table structure for table `task` */

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `datecreated` date DEFAULT NULL,
  `dateupdated` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `task` */

insert  into `task`(`id`,`name`,`description`,`datecreated`,`dateupdated`) values (1,'Load Task List','This is to list all tasks in a table created by user','2017-09-26','2017-09-27'),(2,'Create Task','Create task using modal form for simplicity','2017-09-26',NULL),(3,'test','test','2017-09-27',NULL),(4,'Update Function','This is to create update function in soding test project','2017-09-27',NULL);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `username` varchar(100) NOT NULL,
  `photo` varchar(100) NOT NULL DEFAULT 'avatar.png',
  `pin` varchar(30) DEFAULT NULL,
  `v1_earnings` int(7) NOT NULL,
  `_status` int(1) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`ID`,`name`,`password`,`email`,`mobile`,`address`,`username`,`photo`,`pin`,`v1_earnings`,`_status`) values (580,'Edsador Tuyco','b46246cc7d6e5d22c876e32107c0c75e','tadslife_02@yahoo.com','09334649021','Davao City','etuyco','','WXFaNDYyc2tXYSs3cENyeFBwZ3haUT',0,0),(581,'','','','','','','avatar.png',NULL,0,0);

/* Procedure structure for procedure `getGeoSummary` */

/*!50003 DROP PROCEDURE IF EXISTS  `getGeoSummary` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getGeoSummary`(IN `uID` INT(10),OUT `sID` INT(10),OUT `cCode` INT(20),OUT `pID` INT(10),OUT `Total` INT(10),OUT `Direct` INT(10),OUT `Indirect` INT(10),OUT `Left` INT(10),OUT `Right` INT(10),OUT `Left_points` INT(10),OUT `Right_points` INT(10),OUT `Direct_points` INT(10),OUT `pv_earning` INT(10))
func:BEGIN

DECLARE user_type TEXT;
DECLARE p_type TEXT;
DECLARE Left_ID TEXT;
DECLARE Right_ID TEXT;

DECLARE Left_type TEXT;
DECLARE Right_type TEXT;

DECLARE UltimateGpaPoints INT DEFAULT 5;
DECLARE PremierGpaPoints INT DEFAULT 2;
DECLARE BasicGpaPoints INT DEFAULT 1;

DECLARE UltimatePaPoints INT DEFAULT 50;
DECLARE PremierPaPoints INT DEFAULT 25;
DECLARE BasicPaPoints INT DEFAULT 15;

DECLARE tmp1 INT DEFAULT 0;
DECLARE tmp2 INT DEFAULT 0;
DECLARE tmp3 INT DEFAULT 0;
DECLARE tmp4 INT DEFAULT 0;

-- This is for unilevel 
DECLARE status TEXT;
DECLARE earning INT DEFAULT 0;

SELECT _type INTO user_type FROM `user-meta` WHERE user_ID = uID;

SELECT payment_type INTO p_type FROM `user-meta` WHERE user_ID = uID;

SELECT COUNT(user_ID) INTO Direct FROM `user-meta` WHERE sponsor_ID = uID AND `payment_type` = "Activation Code";

SELECT COUNT(user_ID) INTO Total FROM `user-meta` WHERE ancestors LIKE CONCAT('%', uID, '%') AND `payment_type` = "Activation Code";

SET Indirect = Total - Direct;

SELECT user_ID,_type INTO Left_ID,Left_type FROM `user-meta` WHERE placement_ID = uID AND `position` = "Left";
SELECT user_ID,_type INTO Right_ID,Right_type FROM `user-meta` WHERE placement_ID = uID AND `position` = "Right"; 

SELECT (COUNT(user_ID)) INTO `Left` FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND payment_type = "Activation Code";
SELECT (COUNT(user_ID)) INTO `Right` FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND payment_type = "Activation Code";

-- count left and right points
IF user_type = "Ultimate" THEN
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * UltimateGpaPoints) INTO tmp1 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Ultimate" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * PremierGpaPoints) INTO tmp2 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Premier" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp3 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Basic" AND `payment_type` = "Activation Code") AS p;
	IF Left_type = "Ultimate" AND p_type = "Activation Code" THEN SET tmp4 = UltimateGpaPoints;
	ELSEIF Left_type = "Premier" AND p_type = "Activation Code" THEN SET tmp4 = PremierGpaPoints;
	ELSEIF Left_type = "Basic" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints; END IF;
ELSEIF user_type = "Premier" THEN
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * PremierGpaPoints) INTO tmp1 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Ultimate" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * PremierGpaPoints) INTO tmp2 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Premier" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp3 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Basic" AND `payment_type` = "Activation Code") AS p;
	IF Left_type = "Ultimate" AND p_type = "Activation Code" THEN SET tmp4 = PremierGpaPoints;
	ELSEIF Left_type = "Premier" AND p_type = "Activation Code" THEN SET tmp4 = PremierGpaPoints;
	ELSEIF Left_type = "Basic" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints; END IF;
ELSEIF user_type = "Basic" THEN
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp1 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Ultimate" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp2 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Premier" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp3 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Left_ID,','), uID, '%') AND _type = "Basic" AND `payment_type` = "Activation Code") AS p;
	IF Left_type = "Ultimate" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints;
	ELSEIF Left_type = "Premier" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints;
	ELSEIF Left_type = "Basic" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints; END IF;
END IF;


SET Left_points = (tmp1 + tmp2 + tmp3);

IF user_type = "Ultimate"  THEN
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * UltimateGpaPoints) INTO tmp1 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Ultimate" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * PremierGpaPoints) INTO tmp2 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Premier" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp3 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Basic" AND `payment_type` = "Activation Code") AS p;
	IF Right_type = "Ultimate" AND p_type = "Activation Code" THEN SET tmp4 = UltimateGpaPoints;
	ELSEIF Right_type = "Premier" AND p_type = "Activation Code" THEN SET tmp4 = PremierGpaPoints;
	ELSEIF Right_type = "Basic" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints; END IF;
ELSEIF user_type = "Premier" THEN
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * PremierGpaPoints) INTO tmp1 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Ultimate" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * PremierGpaPoints) INTO tmp2 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Premier" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp3 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Basic" AND `payment_type` = "Activation Code") AS p;
	IF Right_type = "Ultimate" AND p_type = "Activation Code" THEN SET tmp4 = PremierGpaPoints;
	ELSEIF Right_type = "Premier" AND p_type = "Activation Code" THEN SET tmp4 = PremierGpaPoints;
	ELSEIF Right_type = "Basic" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints; END IF;
ELSEIF user_type = "Basic" THEN
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp1 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Ultimate" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp2 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Premier" AND `payment_type` = "Activation Code") AS p;
	SELECT (SUM(IF(p._tmp1=0,0,p._tmp1)) * BasicGpaPoints) INTO tmp3 FROM (SELECT COUNT(user_ID) AS _tmp1 FROM `user-meta` WHERE ancestors LIKE CONCAT(CONCAT('%', Right_ID,','), uID, '%') AND _type = "Basic" AND `payment_type` = "Activation Code") AS p;
	IF Right_type = "Ultimate" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints;
	ELSEIF Right_type = "Premier" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints;
	ELSEIF Right_type = "Basic" AND p_type = "Activation Code" THEN SET tmp4 = BasicGpaPoints; END IF;
END IF;

SET Right_points = (tmp1 + tmp2 + tmp3);
-- end count left and right points

-- count PA points
IF user_type = "Ultimate" THEN
	SELECT ( COUNT(user_ID) * UltimatePaPoints ) INTO tmp1 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Ultimate" AND `payment_type` = "Activation Code";
	SELECT ( COUNT(user_ID) * PremierPaPoints ) INTO tmp2 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Premier" AND `payment_type` = "Activation Code";
	SELECT ( COUNT(user_ID) * BasicPaPoints ) INTO tmp3 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Basic" AND `payment_type` = "Activation Code";
ELSEIF user_type = "Premier" THEN
	SELECT ( COUNT(user_ID) * PremierPaPoints ) INTO tmp1 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Ultimate" AND `payment_type` = "Activation Code";
	SELECT ( COUNT(user_ID) * PremierPaPoints ) INTO tmp2 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Premier" AND `payment_type` = "Activation Code";
	SELECT ( COUNT(user_ID) * BasicPaPoints ) INTO tmp3 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Basic" AND `payment_type` = "Activation Code";
ELSEIF user_type = "Basic" THEN
	SELECT ( COUNT(user_ID) * BasicPaPoints ) INTO tmp1 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Ultimate" AND `payment_type` = "Activation Code";
	SELECT ( COUNT(user_ID) * BasicPaPoints ) INTO tmp2 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Premier" AND `payment_type` = "Activation Code";
	SELECT ( COUNT(user_ID) * BasicPaPoints ) INTO tmp3 FROM `user-meta` WHERE sponsor_ID = uID AND _type = "Basic" AND `payment_type` = "Activation Code";
END IF;

SET Direct_points = (tmp1 + tmp2 + tmp3);

-- end count PA points


-- levels (up to 10 levels)
-- level 1
DROP TEMPORARY TABLE IF EXISTS temp_lvl;
DROP TEMPORARY TABLE IF EXISTS temp_lvl2;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_lvl (_level CHAR(10) NOT NULL,
						uID CHAR(10) NOT NULL,
						sID CHAR(10) NOT NULL,
						pID CHAR(10) NOT NULL,
						uName CHAR(20) NOT NULL,
						sName CHAR(20) NOT NULL,
						pName CHAR(20) NOT NULL,
						cCode CHAR(20) NOT NULL,
						_type CHAR(10) NOT NULL) ENGINE=MEMORY;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_lvl2 (_level CHAR(10) NOT NULL,
						uID CHAR(10) NOT NULL,
						sID CHAR(10) NOT NULL,
						pID CHAR(10) NOT NULL,
						uName CHAR(20) NOT NULL,
						sName CHAR(20) NOT NULL,
						pName CHAR(20) NOT NULL,
						cCode CHAR(20) NOT NULL,
						_type CHAR(10) NOT NULL) ENGINE=MEMORY;

INSERT INTO temp_lvl
SELECT 	
		"1" AS _level,
	    u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b
WHERE 	u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		s.ID = uID;
		
INSERT INTO temp_lvl2
SELECT 	
		"2" AS _level,
	    u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "1" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"3" AS _level,
	    u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "2" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"4" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "3" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"5" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "4" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"6" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "5" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"7" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "6" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"8" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "7" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"9" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "8" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2; TRUNCATE temp_lvl2;

INSERT INTO temp_lvl2
SELECT 	
		"10" AS _level,
	        u.ID AS _uID,
	    s.ID,
	    p.ID,
		u.name AS uName, 
		s.name AS sName, 
		p.name AS pName,
		b.payment_type AS cCode,
		b._type AS _type
FROM `users` AS u, `users` AS s, `users` AS p,  `user-meta` AS b, temp_lvl AS c
WHERE 		u.ID = b.user_ID AND 
		s.ID = b.sponsor_ID AND
		p.ID = b.placement_ID AND
		c._level = "9" AND
		c.uID = b.sponsor_ID;		
INSERT INTO temp_lvl SELECT * FROM temp_lvl2;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
