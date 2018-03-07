CREATE DATABASE  IF NOT EXISTS `testa_lapas_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `testa_lapas_db`;
-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: testa_lapas_db
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_answer`
--

DROP TABLE IF EXISTS `tbl_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_answer` (
  `answerID` int(11) NOT NULL AUTO_INCREMENT,
  `answer` varchar(100) DEFAULT NULL,
  `questionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`answerID`),
  KEY `fk_tbl_answer_1_idx` (`questionID`),
  CONSTRAINT `fk_tbl_answer_1` FOREIGN KEY (`questionID`) REFERENCES `tbl_question` (`questionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_answer`
--

LOCK TABLES `tbl_answer` WRITE;
/*!40000 ALTER TABLE `tbl_answer` DISABLE KEYS */;
INSERT INTO `tbl_answer` VALUES (1,'Incorrect answer #1',1),(2,'Incorrect answer #2',1),(3,'Incorrect answer #3',1),(4,'Correct answer',1),(5,'Incorrect answer #4',2),(6,'Correct answer for question 2',2),(7,'Correct answer for question 3',3),(8,'incorrect answer #5',3),(9,'incorrect answer #6',3),(10,'incorrect answer #7',4),(11,'correct answer question 4',4),(12,'correct ',5),(13,'incorrect',5),(14,'incorrect',5);
/*!40000 ALTER TABLE `tbl_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_correct_answer`
--

DROP TABLE IF EXISTS `tbl_correct_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_correct_answer` (
  `correct_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `answerID` int(11) DEFAULT NULL,
  `questionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`correct_answer_id`),
  KEY `fk_tbl_correct_answer_1_idx` (`answerID`),
  KEY `fk_tbl_correct_answer_2_idx` (`questionID`),
  CONSTRAINT `fk_tbl_correct_answer_1` FOREIGN KEY (`answerID`) REFERENCES `tbl_answer` (`answerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_correct_answer_2` FOREIGN KEY (`questionID`) REFERENCES `tbl_question` (`questionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_correct_answer`
--

LOCK TABLES `tbl_correct_answer` WRITE;
/*!40000 ALTER TABLE `tbl_correct_answer` DISABLE KEYS */;
INSERT INTO `tbl_correct_answer` VALUES (1,4,1),(2,6,2),(3,7,3),(4,11,4),(5,12,5);
/*!40000 ALTER TABLE `tbl_correct_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_question`
--

DROP TABLE IF EXISTS `tbl_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_question` (
  `questionID` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(500) DEFAULT NULL,
  `testID` int(11) DEFAULT NULL,
  PRIMARY KEY (`questionID`),
  KEY `fk_tbl_question_1_idx` (`testID`),
  CONSTRAINT `fk_tbl_question_1` FOREIGN KEY (`testID`) REFERENCES `tbl_test` (`testID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_question`
--

LOCK TABLES `tbl_question` WRITE;
/*!40000 ALTER TABLE `tbl_question` DISABLE KEYS */;
INSERT INTO `tbl_question` VALUES (1,'Question 1',1),(2,'Question 2',1),(3,'Question 3',1),(4,'Question 4 ',1),(5,'Question for test 2',2);
/*!40000 ALTER TABLE `tbl_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_test`
--

DROP TABLE IF EXISTS `tbl_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_test` (
  `testID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`testID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_test`
--

LOCK TABLES `tbl_test` WRITE;
/*!40000 ALTER TABLE `tbl_test` DISABLE KEYS */;
INSERT INTO `tbl_test` VALUES (1,'Tests 1'),(2,'Tests 2');
/*!40000 ALTER TABLE `tbl_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_test_attempt`
--

DROP TABLE IF EXISTS `tbl_test_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_test_attempt` (
  `attemptID` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) DEFAULT '0',
  `finished` tinyint(4) DEFAULT '0',
  `userID` int(11) DEFAULT NULL,
  `testID` int(11) DEFAULT NULL,
  PRIMARY KEY (`attemptID`),
  KEY `fk_tbl_test_attempt_2_idx` (`userID`),
  KEY `fk_tbl_test_attempt_2_idx1` (`testID`),
  CONSTRAINT `fk_tbl_test_attempt_1` FOREIGN KEY (`userID`) REFERENCES `tbl_user` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_test_attempt_2` FOREIGN KEY (`testID`) REFERENCES `tbl_test` (`testID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_test_attempt`
--

LOCK TABLES `tbl_test_attempt` WRITE;
/*!40000 ALTER TABLE `tbl_test_attempt` DISABLE KEYS */;
INSERT INTO `tbl_test_attempt` VALUES (1,2,1,1,1),(2,1,1,1,2),(3,4,1,1,1),(4,1,1,1,2),(5,0,1,1,1),(6,0,1,1,2),(7,0,1,2,1),(8,0,1,2,2),(9,0,1,3,1),(10,4,1,4,1),(11,1,1,4,2),(12,1,1,5,1);
/*!40000 ALTER TABLE `tbl_test_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userID_UNIQUE` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (1,'Test run'),(2,'Test run 2'),(3,'Test run 3'),(4,'Test run 4'),(5,'Test run 5');
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user_answer`
--

DROP TABLE IF EXISTS `tbl_user_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user_answer` (
  `user_answerID` int(11) NOT NULL AUTO_INCREMENT,
  `attemptID` int(11) DEFAULT NULL,
  `questionID` int(11) DEFAULT NULL,
  `answerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_answerID`),
  KEY `fk_tbl_user_answer_1_idx` (`attemptID`),
  KEY `fk_tbl_user_answer_2_idx` (`questionID`),
  KEY `fk_tbl_user_answer_3_idx` (`answerID`),
  CONSTRAINT `fk_tbl_user_answer_1` FOREIGN KEY (`attemptID`) REFERENCES `tbl_test_attempt` (`attemptID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_user_answer_2` FOREIGN KEY (`questionID`) REFERENCES `tbl_question` (`questionID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_user_answer_3` FOREIGN KEY (`answerID`) REFERENCES `tbl_answer` (`answerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user_answer`
--

LOCK TABLES `tbl_user_answer` WRITE;
/*!40000 ALTER TABLE `tbl_user_answer` DISABLE KEYS */;
INSERT INTO `tbl_user_answer` VALUES (1,1,1,4),(2,1,2,7),(3,1,3,9),(4,1,4,11),(5,2,1,4),(6,3,1,4),(7,3,2,6),(8,3,3,7),(9,3,4,11),(10,4,5,12),(11,5,1,6),(12,5,2,7),(13,5,3,11),(14,7,2,6),(15,7,3,9),(16,7,4,10),(17,8,5,12),(18,9,1,4),(19,9,2,6),(20,9,3,7),(21,9,4,11),(22,10,1,4),(23,10,2,6),(24,10,3,7),(25,10,4,11),(26,11,5,12),(27,12,1,1),(28,12,2,6),(29,12,3,9),(30,12,4,10);
/*!40000 ALTER TABLE `tbl_user_answer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-07 18:35:28
