/*
SQLyog Community v13.1.1 (64 bit)
MySQL - 8.0.13 : Database - medical
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`medical` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `medical`;

/*Table structure for table `billing_master` */

DROP TABLE IF EXISTS `billing_master`;

CREATE TABLE `billing_master` (
  `billID` bigint(20) NOT NULL,
  `finalAmount` double DEFAULT NULL,
  `numItems` int(11) DEFAULT NULL,
  `timeStamp` varchar(255) DEFAULT NULL,
  `totalAmount` double DEFAULT NULL,
  `totalDiscount` double DEFAULT NULL,
  `totalTax` double DEFAULT NULL,
  `transactionID` bigint(20) DEFAULT NULL,
  `trolleyID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`billID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `billing_master` */

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customerID` int(11) NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `customers` */

/*Table structure for table `discountdetails` */

DROP TABLE IF EXISTS `discountdetails`;

CREATE TABLE `discountdetails` (
  `discountID` int(11) NOT NULL,
  `discontDescription` varchar(255) DEFAULT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`discountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `discountdetails` */

/*Table structure for table `itemcategory` */

DROP TABLE IF EXISTS `itemcategory`;

CREATE TABLE `itemcategory` (
  `catID` int(11) NOT NULL,
  `itemDesc` varchar(255) DEFAULT NULL,
  `itemName` varchar(255) DEFAULT NULL,
  `itemPrice` double DEFAULT NULL,
  PRIMARY KEY (`catID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `itemcategory` */

/*Table structure for table `itemdetails` */

DROP TABLE IF EXISTS `itemdetails`;

CREATE TABLE `itemdetails` (
  `itemDetailsID` int(11) NOT NULL,
  `discountID` int(11) DEFAULT NULL,
  `catID` int(11) DEFAULT NULL,
  `taxPlanId` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemDetailsID`),
  KEY `FKo9y2jnhrlpu9cp1dd63yp81p7` (`discountID`),
  KEY `FKenr89kpbwqmld7iom24misqsq` (`catID`),
  KEY `FKqxynkbajot543k3s8yd9hbxvd` (`taxPlanId`),
  CONSTRAINT `FKenr89kpbwqmld7iom24misqsq` FOREIGN KEY (`catID`) REFERENCES `itemcategory` (`catid`),
  CONSTRAINT `FKo9y2jnhrlpu9cp1dd63yp81p7` FOREIGN KEY (`discountID`) REFERENCES `discountdetails` (`discountid`),
  CONSTRAINT `FKqxynkbajot543k3s8yd9hbxvd` FOREIGN KEY (`taxPlanId`) REFERENCES `taxplan` (`taxplanid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `itemdetails` */

/*Table structure for table `items` */

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `itemID` int(11) NOT NULL,
  `isSold` int(11) DEFAULT '0',
  `timeStamp` varchar(255) DEFAULT NULL,
  `itemDetailsID` int(11) DEFAULT NULL,
  `item_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  KEY `FKsw08114gk223on0mibkw6wlkq` (`itemDetailsID`),
  KEY `FKdmcjclfqff9bla1segl478jvy` (`item_ID`),
  CONSTRAINT `FKdmcjclfqff9bla1segl478jvy` FOREIGN KEY (`item_ID`) REFERENCES `rfiddetails` (`item_id`),
  CONSTRAINT `FKsw08114gk223on0mibkw6wlkq` FOREIGN KEY (`itemDetailsID`) REFERENCES `itemdetails` (`itemdetailsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `items` */

/*Table structure for table `login_logs` */

DROP TABLE IF EXISTS `login_logs`;

CREATE TABLE `login_logs` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(5) NOT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `login_date_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `login_logs` */

insert  into `login_logs`(`id`,`uid`,`uname`,`login_date_time`) values 
(1,1,'admin','2018-11-14 15:17:26'),
(2,1,'admin','2018-11-14 15:38:40'),
(3,1,'admin','2018-11-14 15:43:40'),
(4,1,'admin','2019-07-16 15:04:21'),
(5,1,'admin','2019-07-16 15:11:54'),
(6,1,'admin','2019-07-16 15:12:17'),
(7,1,'admin','2019-07-16 15:15:09'),
(8,1,'admin','2019-07-16 15:15:37'),
(9,1,'admin','2019-07-17 11:14:16'),
(10,1,'admin','2019-07-24 11:40:09'),
(11,1,'admin','2019-07-25 21:53:46'),
(12,1,'admin','2019-07-25 22:29:35'),
(13,1,'admin','2019-07-26 16:56:12'),
(14,1,'admin','2019-07-26 16:59:43'),
(15,1,'admin','2019-07-26 17:46:38'),
(16,1,'admin','2019-07-30 12:29:52'),
(17,1,'admin','2019-08-12 23:10:05'),
(18,1,'admin','2019-08-13 02:25:24'),
(19,1,'admin','2019-08-13 14:33:12'),
(20,1,'admin','2019-08-13 15:26:44'),
(21,1,'admin','2019-08-17 05:54:52'),
(22,1,'admin','2019-08-17 10:12:59'),
(23,1,'admin','2019-08-19 08:07:54'),
(24,1,'admin','2019-08-19 09:17:01'),
(25,1,'admin','2019-08-19 12:20:04'),
(26,1,'admin','2019-08-19 13:52:39'),
(27,1,'admin','2019-08-19 17:39:12'),
(28,1,'admin','2019-08-20 01:57:02'),
(29,1,'admin','2019-08-20 05:33:53'),
(30,1,'admin','2019-08-20 06:06:02'),
(31,1,'admin','2019-08-21 05:41:04'),
(32,1,'admin','2019-08-21 10:34:59'),
(33,1,'admin','2019-08-21 13:06:11');

/*Table structure for table `notes` */

DROP TABLE IF EXISTS `notes`;

CREATE TABLE `notes` (
  `noteID` varchar(50) DEFAULT NULL,
  `bodylocation` varchar(50) DEFAULT NULL,
  `sublocation` varchar(50) DEFAULT NULL,
  `disease` varchar(200) DEFAULT NULL,
  `diagnosis` text,
  `drug` text,
  `patientID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `notes` */

insert  into `notes`(`noteID`,`bodylocation`,`sublocation`,`disease`,`diagnosis`,`drug`,`patientID`) values 
('S106426667458500','Abdomen, pelvis & buttocks','Abdomen','Abdominal pain',',Constipation,45.0,K59.0,Constipation,Obstipation,2.0 # ',',50419-171,50419-171-04,METASTATIC COLORECTAL CANCER,REGORAFENIB,ORAL,STIVARGA,Bayer HealthCare Pharmaceuticals Inc.,HUMAN PRESCRIPTION DRUG # ',4),
('I107966175688400','Chest & back','Chest','Chest pain',',Coronary heart disease,72.0,I20;I21;I22;I23;I24;I25,Angina pectoris;Acute myocardial infarction;Subsequent myocardial infarction;Certain current complications following acute myocardial infarction;Other acute ischaemic heart diseases;Chronic ischaemic heart disease,Coronary artery disease,2.0 # ',',25682-001,25682-001-01,PAROXYSMAL NOCTURNAL HAEMOGLOBINURIA,ECULIZUMAB,INTRAVENOUS,SOLIRIS,Alexion Pharmaceuticals Inc.,HUMAN PRESCRIPTION DRUG # ,0006-3919,0006-3919-68,PARKINSON^S DISEASE,CARBIDOPA AND LEVODOPA,ORAL,SINEMET CR,Merck Sharp & Dohme Corp.,HUMAN PRESCRIPTION DRUG # ,0597-0360,0597-0108-60,CEREBROVASCULAR ACCIDENT PROPHYLAXIS,DABIGATRAN ETEXILATE MESYLATE,ORAL,PRADAXA,Boehringer Ingelheim Pharmaceuticals Inc.,HUMAN PRESCRIPTION DRUG # ',5),
('S1070721160399','Chest & back','Chest','Chest pain',',Reflux disease,90.0,K21,Gastro-oesophageal reflux disease,Gastroesophageal reflux disease,1.0 # ',',25682-001,25682-001-01,PAROXYSMAL NOCTURNAL HAEMOGLOBINURIA,ECULIZUMAB,INTRAVENOUS,SOLIRIS,Alexion Pharmaceuticals Inc.,HUMAN PRESCRIPTION DRUG # ,0006-3919,0006-3919-68,PARKINSON^S DISEASE,CARBIDOPA AND LEVODOPA,ORAL,SINEMET CR,Merck Sharp & Dohme Corp.,HUMAN PRESCRIPTION DRUG # ,0173-0863,0173-0861-18,TYPE 2 DIABETES MELLITUS,ROSIGLITAZONE MALEATE,ORAL,AVANDIA 4MG,GlaxoSmithKline LLC,HUMAN PRESCRIPTION DRUG # ,0597-0075,0597-0075-47,CHRONIC OBSTRUCTIVE PULMONARY DISEASE,TIOTROPIUM BROMIDE,RESPIRATORY (INHALATION),SPIRIVA,Boehringer Ingelheim Pharmaceuticals Inc.,HUMAN PRESCRIPTION DRUG # ',7);

/*Table structure for table `patientdata` */

DROP TABLE IF EXISTS `patientdata`;

CREATE TABLE `patientdata` (
  `id` int(11) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `patientdata` */

insert  into `patientdata`(`id`,`age`,`phone`,`dob`,`email`,`fname`,`gender`,`lname`,`weight`) values 
(1,25,'123','14/07/1994','praitaliya@gmail.com','Prashant','M','Italiya',84),
(2,0,'123456','1980-05-20','test@gmail.com','Test','M','Test',60),
(3,39,'12345','1980-09-10','test@gmail.com','test','M','test',45),
(4,24,'12343553','1995-08-12','sarvaiyk@uwindsor.ca','Karishmaba','F','Sarvaiya',45),
(5,25,'1234','1994-07-14','praitaliya@gmail.com','Prashant','M','Italiya',80),
(6,25,'1234556','1994-07-14','praitaliya@gmail.com','Prashant','M','Italiya',56),
(7,21,'1234567890','1998-08-21','stark@gmail.com','Tony','M','Stark',56);

/*Table structure for table `rfiddetails` */

DROP TABLE IF EXISTS `rfiddetails`;

CREATE TABLE `rfiddetails` (
  `item_ID` int(11) NOT NULL,
  `RFID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `rfiddetails` */

/*Table structure for table `taxplan` */

DROP TABLE IF EXISTS `taxplan`;

CREATE TABLE `taxplan` (
  `taxPlanId` int(11) NOT NULL,
  `taxPercentage` double NOT NULL,
  `taxPlanName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`taxPlanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `taxplan` */

/*Table structure for table `transaction_details` */

DROP TABLE IF EXISTS `transaction_details`;

CREATE TABLE `transaction_details` (
  `id` int(11) NOT NULL,
  `itemID` int(11) DEFAULT NULL,
  `timeStamp` varchar(255) DEFAULT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transaction_details` */

/*Table structure for table `transaction_master` */

DROP TABLE IF EXISTS `transaction_master`;

CREATE TABLE `transaction_master` (
  `id` int(11) NOT NULL,
  `RFID` varchar(255) DEFAULT NULL,
  `VAT` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `itemName` varchar(255) DEFAULT NULL,
  `itemPrice` double DEFAULT NULL,
  `timeStamp` varchar(255) DEFAULT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  `trolleyID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transaction_master` */

/*Table structure for table `transcation_customer_details` */

DROP TABLE IF EXISTS `transcation_customer_details`;

CREATE TABLE `transcation_customer_details` (
  `TransactionID` bigint(20) NOT NULL,
  `isBilled` int(11) DEFAULT '0',
  `fname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `timeStamp` varchar(255) DEFAULT NULL,
  `TrolleyID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transcation_customer_details` */

/*Table structure for table `trolleydetails` */

DROP TABLE IF EXISTS `trolleydetails`;

CREATE TABLE `trolleydetails` (
  `TrolleyID` varchar(255) NOT NULL,
  `isTransactionCompelted` int(11) DEFAULT '1',
  `isUsed` int(11) DEFAULT '0',
  PRIMARY KEY (`TrolleyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `trolleydetails` */

insert  into `trolleydetails`(`TrolleyID`,`isTransactionCompelted`,`isUsed`) values 
('A',1,0),
('B',1,0),
('C',1,0),
('D',1,0);

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `RID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`RID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `user_role` */

insert  into `user_role`(`RID`,`Type`) values 
(1,'ADMIN'),
(2,'USER'),
(3,'MASTER');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `UID` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `UNAME` varchar(50) NOT NULL,
  `PASS` varchar(50) NOT NULL,
  `UFNAME` varchar(20) DEFAULT NULL,
  `ULNAME` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `ROLE_ID` tinyint(2) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `DATE_CREATED` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `DATE_MODIFIED` timestamp NULL DEFAULT '2001-11-11 00:00:00',
  `isPassReset` tinyint(2) unsigned DEFAULT '0',
  `createdBy` varchar(20) DEFAULT NULL,
  `lastModifiedBy` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `users` */

insert  into `users`(`UID`,`UNAME`,`PASS`,`UFNAME`,`ULNAME`,`EMAIL`,`ROLE_ID`,`isDeleted`,`DATE_CREATED`,`DATE_MODIFIED`,`isPassReset`,`createdBy`,`lastModifiedBy`) values 
(1,'admin','254670f140de0a3cec241e6b284855b1','Prashant','Italiya','praitaliya@gmail.com',3,0,'2017-11-27 17:08:23','2001-11-11 00:00:00',0,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
