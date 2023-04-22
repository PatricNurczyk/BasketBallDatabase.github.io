CREATE DATABASE  IF NOT EXISTS `basketball_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `basketball_database`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: basketball_database
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `Player_ID` int NOT NULL AUTO_INCREMENT,
  `Player_Name` varchar(64) DEFAULT NULL,
  `Player_No` int DEFAULT NULL,
  `Team_ID` int DEFAULT NULL,
  `Height` decimal(4,1) DEFAULT NULL,
  `Weight` decimal(4,1) DEFAULT NULL,
  `Year_In_School` int DEFAULT NULL,
  PRIMARY KEY (`Player_ID`),
  KEY `Team_ID` (`Team_ID`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`Team_ID`) REFERENCES `team` (`Team_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Sola Adebisi',51,1,78.0,190.0,3),(2,'Jeremiah Bembry',10,1,78.0,185.0,1),(3,'Michael Brown',45,1,79.0,220.0,2),(4,'Matthew Cleveland',35,1,79.0,200.0,2),(5,'Cam Ron Corhen',3,1,82.0,225.0,1),(6,'Ron Fletcher',21,1,79.0,215.0,3),(7,'Jaylan Gainey',33,1,82.0,220.0,4),(8,'DeAnte Green',5,1,82.0,210.0,1),(9,'Darin Green Jr.',22,1,77.0,195.0,3),(10,'Tom House',12,1,79.0,200.0,1),(11,'Chandler Jackson',0,1,77.0,215.0,1),(12,'Naheem McLeod',24,1,88.0,255.0,2),(13,'Baba Miller',11,1,83.0,204.0,1),(14,'Caleb Mills',4,1,77.0,180.0,3),(15,'R.J. Morris',41,1,75.0,185.0,1),(16,'Tibor Palinkas',43,1,76.0,190.0,3),(17,'Isaac Spainhour',40,1,75.0,180.0,2),(21,'Denzel Aberdeen',10,2,77.0,189.0,1),(24,'Trey Bonham',2,2,72.0,170.0,3),(26,'Colin Castelon',12,2,83.0,240.0,4),(27,'CJ Felder',1,2,79.0,240.0,4),(28,'Alex Fudge',3,2,79.0,215.0,1),(29,'Jason Jitobah',33,2,79.0,300.0,4),(30,'Myreon Jones',0,2,75.0,260.0,4),(31,'Alex Klatsky',21,2,76.0,206.0,3),(32,'Riley Kugel',24,2,76.0,207.0,1),(33,'Niels Lane',4,2,76.0,215.0,3),(34,'Kyle Lofton',11,2,73.0,186.0,4),(35,'Jack May',20,2,76.0,195.0,4),(36,'Kowacie Reeves',14,2,78.0,195.0,2),(37,'Will Richard',5,2,76.0,206.0,2),(38,'Aleks Szymczyk',13,2,82.0,233.0,1),(39,'Jonathan Aybar',21,3,81.0,183.0,1),(40,'Oscar Berry',33,3,76.0,183.0,2),(41,'Trent Coleman',4,3,79.0,205.0,2),(42,'Mark Flakus',1,3,73.0,165.0,1),(43,'Carter Hendricksen',3,3,79.0,217.0,4),(44,'Jarius Hicklen',10,3,75.0,175.0,4),(45,'Max Hrdlicka',13,3,78.0,200.0,1),(46,'Chaz Lanier',2,3,79.0,202.0,4),(47,'Jah Nze',23,3,76.0,215.0,1),(48,'Jadyn Parker',24,3,82.0,180.0,2),(49,'Jose Placer',15,3,73.0,174.0,4),(50,'Brandon Rasmussen',11,3,76.0,183.0,2),(51,'Jake Boggs',5,4,79.0,200.0,3),(52,'Keyshawn Bryant',23,4,78.0,190.0,4),(53,'Mark Calleja',13,4,75.0,185.0,4),(54,'Jamir Chaplin',24,4,77.0,200.0,3),(55,'Ryan Conwell',0,4,76.0,195.0,1),(56,'Sam Hines Jr',20,4,78.0,215.0,2),(57,'Kenu Louissaint',22,4,75.0,205.0,4),(58,'Selton Miguel',1,4,76.0,210.0,2),(59,'Trey Moss',11,4,75.0,180.0,2),(60,'Dok Muordar',4,4,83.0,200.0,1),(61,'DJ Patrick',3,4,78.0,200.0,2),(62,'Serrel Smith Jr',10,4,76.0,175.0,4),(63,'Russel Tchewa',54,4,84.0,280.0,4),(64,'Corey Walker',15,4,80.0,214.0,2),(65,'Michael Durr',2,5,84.0,250.0,4),(66,'P.J Edwards',5,5,80.0,200.0,2),(67,'Tyem Freeman',11,5,78.0,210.0,3),(68,'Taylor Hendricks',25,5,81.0,210.0,1),(69,'Tyler Hendricks',15,5,77.0,175.0,1),(70,'Itheiel Horton',12,5,70.0,200.0,4),(71,'Darius Johnson',3,5,73.0,190.0,2),(72,'Michael Kalina',14,5,73.0,185.0,1),(73,'C.J. Kelly',13,5,77.0,200.0,4),(74,'Charlie May',24,5,77.0,190.0,1),(75,'Brandon Suggs',4,5,78.0,185.0,1),(76,'Thierno Sylla',31,5,83.0,225.0,1),(77,'Lahat Thioune',0,5,81.0,210.0,4),(78,'C.J Walker',21,5,80.0,180.0,4),(79,'John Doe',0,5,71.0,180.0,2),(80,'Jayhlon Young',1,5,74.0,175.0,2),(81,'Favour Aire',12,6,84.0,215.0,1),(83,'AJ Casey',0,6,83.0,213.0,1),(84,'Harlond Beverly',3,6,83.0,213.0,4),(85,'John Smith',10,6,76.0,200.0,3),(86,'Bensley Joseph',4,6,74.0,207.0,2),(87,'Danilo Jovanovich',23,6,80.0,207.0,1),(88,'Jordan Miller',11,6,79.0,195.0,4),(89,'Norchad Omier',15,6,79.0,248.0,2),(90,'Thomas Oosterbroek',32,6,81.0,215.0,2),(91,'Nijel Pack',24,6,72.0,184.0,2),(92,'Wooga Poplar',55,6,77.0,192.0,2),(93,'Jakai Robinson',13,6,77.0,208.0,1),(94,'Anthony Walker',1,6,79.0,215.0,3),(95,'Chris Watson',3,6,79.0,209.0,1),(96,'Isaiah Wong',2,6,76.0,184.0,3),(97,'Alex Andrews',55,7,79.0,200.0,2),(99,'Chase Barrs',10,7,81.0,210.0,4),(100,'Jaylen Bates',5,7,79.0,215.0,3),(101,'Saiyd Burnside',22,7,79.0,210.0,1),(102,'Jordan Chatman',22,7,77.0,208.0,2),(103,'Tarig Ezell',32,7,73.0,180.0,1),(104,'Austin Ezell',14,7,74.0,180.0,1),(105,'Miles Hall',13,7,75.0,170.0,1),(106,'Jaylan Hewitt',21,7,77.0,210.0,4),(107,'Wylie Howard',24,7,83.0,250.0,4),(108,'Hantz Louis-Jeune',4,7,76.0,180.0,3),(109,'Richard Matthews',34,7,72.0,180.0,2),(110,'Noah Meren',15,7,77.0,200.0,4),(111,'Chris Peterson',30,7,74.0,200.0,4),(112,'Byron Smith',1,7,74.0,185.0,3),(113,'Legend Stamps',40,7,81.0,220.0,4),(114,'Dimingus Stevens',0,7,78.0,180.0,3),(115,'Jordan Tilmon',23,7,74.0,180.0,3),(116,'Matthew Webster',20,7,80.0,205.0,1),(119,'Peyton Williams',3,7,79.0,205.0,2),(120,'Trayvon Barbary',21,8,76.0,175.0,1),(121,'Derrick Carter-Hollinger Jr.',23,8,78.0,200.0,3),(122,'Kevin Davis',12,8,78.0,195.0,4),(123,'Dhashon Dyson',10,8,73.0,170.0,3),(124,'Joe French',30,8,77.0,170.0,3),(125,'Marcus Garrett',3,8,74.0,185.0,4),(126,'Lukas Gudavicius',2,8,82.0,225.0,1),(127,'Zion Harmon',1,8,72.0,165.0,1),(128,'James Henderson Jr.',33,8,81.0,230.0,1),(129,'Elijah Hulsewe',32,8,84.0,260.0,1),(130,'Kuon Kuon',4,8,81.0,185.0,1),(131,'Jayson Mathews',0,8,70.0,150.0,1),(132,'Damani McEntire',5,8,76.0,205.0,3),(133,'Dylan Robertson',22,8,82.0,205.0,4),(134,'Donovann Toatley',11,8,73.0,175.0,3),(135,'Simeon Womack',15,8,74.0,170.0,1),(136,'Jayden Brewer',11,9,78.0,250.0,1),(137,'Arturo Dean',4,9,71.0,190.0,1),(138,'Dashon Gittens',1,9,75.0,160.0,1),(139,'Jaden Grant',24,9,71.0,115.0,2),(140,'Nick Guadarrama',0,9,77.0,250.0,4),(141,'Javaunte Hawkins',3,9,71.0,160.0,3),(142,'Denver Jones',2,9,76.0,195.0,2),(143,'Petar Krivokapic',23,9,76.0,200.0,2),(144,'Seth Pinkney',44,9,85.0,200.0,3),(145,'Darryon Prescott',15,9,84.0,300.0,1),(146,'Mohamed Sanogo',33,9,81.0,200.0,2),(147,'Dante Wilcox',12,9,78.0,220.0,4),(148,'Austin Williams',20,9,76.0,200.0,4),(149,'John Williams Jr.',21,9,76.0,190.0,4),(150,'Cameron Wilson',25,9,72.0,200.0,2),(151,'Zach Anderson',10,10,79.0,205.0,3),(152,'Dahmir Bishop',1,10,77.0,190.0,4),(153,'Caleb Catto',2,10,77.0,182.0,4),(154,'Brandon Dwyer',31,10,75.0,180.0,2),(155,'Chance Jackson',20,10,78.0,202.0,4),(156,'Chase Johnston',5,10,75.0,185.0,3),(157,'Cyrus Largie',4,10,75.0,204.0,4),(158,'Franco Miller Jr.',12,10,75.0,201.0,4),(159,'Sam Onu',23,10,83.0,270.0,1),(160,'Lenny Ricca',51,10,74.0,170.0,4),(161,'Austin Richie',32,10,78.0,226.0,4),(162,'Kyle Riemenschneider',44,10,77.0,205.0,3),(163,'Dakota Rivers',0,10,80.0,208.0,4),(164,'Josiah Shackleford',24,10,81.0,225.0,2),(165,'Isaiah Thompson',11,10,73.0,160.0,4),(166,'Leo Beath',30,11,80.0,210.0,1),(167,'Nicholas Boyd',2,11,75.0,175.0,1),(168,'Tre Carroll',25,11,79.0,227.0,1),(169,'Johnell Davis',1,11,76.0,203.0,2),(170,'Michael Forrest',11,11,73.0,174.0,4),(171,'Jalen Gaffney',12,11,75.0,185.0,3),(172,'Isaiah Gaines',5,11,80.0,225.0,2),(173,'Vladislav Goldin',50,11,85.0,240.0,2),(174,'Bryan Greenlee',4,11,72.0,191.0,3),(175,'Jack Johnson',13,11,76.0,185.0,1),(176,'Brenen Lorient',0,11,81.0,200.0,1),(177,'Alijah Martin',15,11,74.0,210.0,2),(178,'Alejandro Ralat',21,11,72.0,160.0,2),(179,'Giancarlo Rosado',3,11,80.0,247.0,2),(180,'Brandon Weatherspoon',23,11,76.0,186.0,3),(181,'Ryan Adams',24,12,76.0,185.0,3),(182,'Trevor Brown',11,12,77.0,195.0,4),(183,'Jason Carter',2,12,78.0,200.0,2),(184,'Derek Davis',5,12,75.0,185.0,1),(185,'Marcus Foster',0,12,80.0,210.0,4),(186,'Jeremiah Harris',15,12,77.0,190.0,2),(187,'Elijah Jackson',3,12,73.0,175.0,3),(188,'Isaiah Jones',20,12,74.0,180.0,4),(189,'Nathan Lawson',1,12,76.0,195.0,1),(190,'Dominic Miller',12,12,81.0,215.0,4),(191,'Xavier Perez',4,12,72.0,170.0,3),(192,'Aaron Reed',25,12,76.0,185.0,1),(193,'Brandon Rivers',10,12,74.0,180.0,2),(194,'Justin Thompson',23,12,80.0,210.0,3),(195,'Jalen Blackmon',5,13,75.0,180.0,2),(196,'Luke Brown',25,13,73.0,165.0,2),(197,'Alex Crawford',24,13,79.0,187.0,2),(198,'Mahamadou Diawara',15,13,82.0,249.0,4),(199,'Aubin Gateretse',21,13,83.0,210.0,2),(200,'Cyncier Harrison',10,13,71.0,160.0,1),(201,'Jackson Huxtable',14,13,78.0,186.0,1),(202,'Alec Oglesby',0,13,77.0,187.0,3),(203,'Wheza Panzo',1,13,79.0,210.0,4),(204,'Sam Peek',2,13,79.0,195.0,4),(205,'Josh Smith',11,13,80.0,215.0,3),(206,'Stephan Swenson',30,13,74.0,195.0,3),(207,'Alvin Tumblin',35,13,79.0,205.0,2),(208,'Giancarlo Valdez',3,13,75.0,170.0,3);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-22 13:49:22
