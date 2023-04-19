-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: baskeball_database
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
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Sola Adebisi',51,1,78.0,190.0,3),(2,'Jeremiah Bembry',10,1,78.0,185.0,1),(3,'Denzel Aberdeen',10,2,77.0,189.0,1),(4,'Denzel Aberdeen',10,2,77.0,189.0,1),(5,'Trey Bonham',2,2,72.0,170.0,3),(6,'Denzel Aberdeen',10,2,77.0,189.0,1),(7,'Trey Bonham',2,2,72.0,170.0,3),(8,'Denzel Aberdeen',10,2,77.0,189.0,1),(9,'Trey Bonham',2,2,72.0,170.0,3),(10,'Colin Castelon',12,3,83.0,240.0,4),(11,'Colin Castelon',12,2,83.0,240.0,4),(12,'CJ Felder',1,2,79.0,240.0,4),(13,'Alex Fudge',3,2,79.0,215.0,1),(14,'Jason Jitobah',33,2,79.0,300.0,4),(15,'Myreon Jones',0,2,75.0,260.0,4),(16,'Alex Klatsky',21,2,76.0,206.0,3),(17,'Riley Kugel',24,2,76.0,207.0,1),(18,'Niels Lane',4,2,76.0,215.0,3),(19,'Kyle Lofton',11,2,73.0,186.0,4),(20,'Jack May',20,2,76.0,195.0,4),(21,'Kowacie Reeves',14,2,78.0,195.0,2),(22,'Will Richard',5,2,76.0,206.0,2),(23,'Aleks Szymczyk',13,2,82.0,233.0,1),(24,'Jonathan Aybar',21,3,81.0,183.0,1),(25,'Oscar Berry',33,3,76.0,183.0,2),(26,'Trent Coleman',4,3,79.0,205.0,2),(27,'Mark Flakus',1,3,73.0,165.0,1),(28,'Carter Hendricksen',3,3,79.0,217.0,4),(29,'Jarius Hicklen',10,3,75.0,175.0,4),(30,'Max Hrdlicka',13,3,78.0,200.0,1),(31,'Chaz Lanier',2,3,79.0,202.0,4),(32,'Jah Nze',23,3,76.0,215.0,1),(33,'Jadyn Parker',24,3,82.0,180.0,2),(34,'Jose Placer',15,3,73.0,174.0,4),(35,'Brandon Rasmussen',11,3,76.0,183.0,2),(36,'Jake Boggs',5,4,79.0,200.0,3),(37,'Keyshawn Bryant',23,4,78.0,190.0,4),(38,'Mark Calleja',13,4,75.0,185.0,4),(39,'Jamir Chaplin',24,4,77.0,200.0,3),(40,'Ryan Conwell',0,4,76.0,195.0,1),(41,'Sam Hines Jr',20,4,78.0,215.0,2),(42,'Kenu Louissaint',22,4,75.0,205.0,4),(43,'Selton Miguel',1,4,76.0,210.0,2),(44,'Trey Moss',11,4,75.0,180.0,2),(45,'Dok Muordar',4,4,83.0,200.0,1),(46,'DJ Patrick',3,4,78.0,200.0,2),(47,'Serrel Smith Jr',10,4,76.0,175.0,4),(48,'Russel Tchewa',54,4,84.0,280.0,4),(49,'Corey Walker',15,4,80.0,214.0,2),(50,'Michael Durr',2,5,84.0,250.0,4),(51,'P.J Edwards',5,5,80.0,200.0,2),(52,'Tyem Freeman',11,5,78.0,210.0,3),(53,'Taylor Hendricks',25,5,81.0,210.0,1),(54,'Tyler Hendricks',15,5,77.0,175.0,1),(55,'Itheiel Horton',12,5,70.0,200.0,4),(56,'Darius Johnson',3,5,73.0,190.0,2),(57,'Michael Kalina',14,5,73.0,185.0,1),(58,'C.J. Kelly',13,5,77.0,200.0,4),(59,'Charlie May',24,5,77.0,190.0,1),(60,'Brandon Suggs',4,5,78.0,185.0,1),(61,'Thierno Sylla',31,5,83.0,225.0,1),(62,'Lahat Thioune',0,5,81.0,210.0,4),(63,'C.J Walker',21,5,80.0,180.0,4),(64,'John Doe',0,5,71.0,180.0,2),(65,'Jayhlon Young',1,5,74.0,175.0,2),(66,'Favour Aire',12,6,84.0,215.0,1),(67,'AJ Casey',0,6,83.0,213.0,1),(68,'AJ Casey',0,6,83.0,213.0,1),(69,'Harlond Beverly',3,6,83.0,213.0,4),(70,'John Smith',10,6,76.0,200.0,3),(71,'Bensley Joseph',4,6,74.0,207.0,2),(72,'Danilo Jovanovich',23,6,80.0,207.0,1),(73,'Jordan Miller',11,6,79.0,195.0,4),(74,'Norchad Omier',15,6,79.0,248.0,2),(75,'Thomas Oosterbroek',32,6,81.0,215.0,2),(76,'Nijel Pack',24,6,72.0,184.0,2),(77,'Wooga Poplar',55,6,77.0,192.0,2),(78,'Jakai Robinson',13,6,77.0,208.0,1),(79,'Anthony Walker',1,6,79.0,215.0,3),(80,'Chris Watson',3,6,79.0,209.0,1),(81,'Isaiah Wong',2,6,76.0,184.0,3),(82,'Alex Andrews',55,7,79.0,200.0,2),(83,'Chase Barrs',10,7,81.0,210.0,4),(84,'Chase Barrs',10,7,81.0,210.0,4),(85,'Jaylen Bates',5,7,79.0,215.0,3),(86,'Saiyd Burnside',22,7,79.0,210.0,1),(87,'Jordan Chatman',22,7,77.0,208.0,2),(88,'Tarig Ezell',32,7,73.0,180.0,1),(89,'Austin Ezell',14,7,74.0,180.0,1),(90,'Miles Hall',13,7,75.0,170.0,1),(91,'Jaylan Hewitt',21,7,77.0,210.0,4),(92,'Wylie Howard',24,7,83.0,250.0,4),(93,'Hantz Louis-Jeune',4,7,76.0,180.0,3),(94,'Richard Matthews',34,7,72.0,180.0,2),(95,'Noah Meren',15,7,77.0,200.0,4),(96,'Chris Peterson',30,7,74.0,200.0,4),(97,'Byron Smith',1,7,74.0,185.0,3),(98,'Legend Stamps',40,7,81.0,220.0,4),(99,'Dimingus Stevens',0,7,78.0,180.0,3),(100,'Jordan Tilmon',23,7,74.0,180.0,3),(101,'Matthew Webster',20,7,80.0,205.0,1),(102,'Peyton Williams',3,7,79.0,205.0,2),(103,'Peyton Williams',3,7,79.0,205.0,2),(104,'Peyton Williams',3,7,79.0,205.0,2),(105,'Trayvon Barbary',21,8,76.0,175.0,1),(106,'Derrick Carter-Hollinger Jr.',23,8,78.0,200.0,3),(107,'Kevin Davis',12,8,78.0,195.0,4),(108,'Dhashon Dyson',10,8,73.0,170.0,3),(109,'Joe French',30,8,77.0,170.0,3),(110,'Marcus Garrett',3,8,74.0,185.0,4),(111,'Lukas Gudavicius',2,8,82.0,225.0,1),(112,'Zion Harmon',1,8,72.0,165.0,1),(113,'James Henderson Jr.',33,8,81.0,230.0,1),(114,'Elijah Hulsewe',32,8,84.0,260.0,1),(115,'Kuon Kuon',4,8,81.0,185.0,1),(116,'Jayson Mathews',0,8,70.0,150.0,1),(117,'Damani McEntire',5,8,76.0,205.0,3),(118,'Dylan Robertson',22,8,82.0,205.0,4),(119,'Donovann Toatley',11,8,73.0,175.0,3),(120,'Simeon Womack',15,8,74.0,170.0,1),(121,'Jayden Brewer',11,9,78.0,250.0,1),(122,'Arturo Dean',4,9,71.0,190.0,1),(123,'Dashon Gittens',1,9,75.0,160.0,1),(124,'Jaden Grant',24,9,71.0,115.0,2),(125,'Nick Guadarrama',0,9,77.0,250.0,4),(126,'Javaunte Hawkins',3,9,71.0,160.0,3),(127,'Denver Jones',2,9,76.0,195.0,2),(128,'Petar Krivokapic',23,9,76.0,200.0,2),(129,'Seth Pinkney',44,9,85.0,200.0,3),(130,'Darryon Prescott',15,9,84.0,300.0,1),(131,'Mohamed Sanogo',33,9,81.0,200.0,2),(132,'Dante Wilcox',12,9,78.0,220.0,4),(133,'Austin Williams',20,9,76.0,200.0,4),(134,'John Williams Jr.',21,9,76.0,190.0,4),(135,'Cameron Wilson',25,9,72.0,200.0,2),(136,'Zach Anderson',10,10,79.0,205.0,3),(137,'Dahmir Bishop',1,10,77.0,190.0,4),(138,'Caleb Catto',2,10,77.0,182.0,4),(139,'Brandon Dwyer',31,10,75.0,180.0,2),(140,'Chance Jackson',20,10,78.0,202.0,4),(141,'Chase Johnston',5,10,75.0,185.0,3),(142,'Cyrus Largie',4,10,75.0,204.0,4),(143,'Franco Miller Jr.',12,10,75.0,201.0,4),(144,'Sam Onu',23,10,83.0,270.0,1),(145,'Lenny Ricca',51,10,74.0,170.0,4),(146,'Austin Richie',32,10,78.0,226.0,4),(147,'Kyle Riemenschneider',44,10,77.0,205.0,3),(148,'Dakota Rivers',0,10,80.0,208.0,4),(149,'Josiah Shackleford',24,10,81.0,225.0,2),(150,'Isaiah Thompson',11,10,73.0,160.0,4),(151,'Leo Beath',30,11,80.0,210.0,1),(152,'Nicholas Boyd',2,11,75.0,175.0,1),(153,'Tre Carroll',25,11,79.0,227.0,1),(154,'Johnell Davis',1,11,76.0,203.0,2),(155,'Michael Forrest',11,11,73.0,174.0,4),(156,'Jalen Gaffney',12,11,75.0,185.0,3),(157,'Isaiah Gaines',5,11,80.0,225.0,2),(158,'Vladislav Goldin',50,11,85.0,240.0,2),(159,'Bryan Greenlee',4,11,72.0,191.0,3),(160,'Jack Johnson',13,11,76.0,185.0,1),(161,'Brenen Lorient',0,11,81.0,200.0,1),(162,'Alijah Martin',15,11,74.0,210.0,2),(163,'Alejandro Ralat',21,11,72.0,160.0,2),(164,'Giancarlo Rosado',3,11,80.0,247.0,2),(165,'Brandon Weatherspoon',23,11,76.0,186.0,3),(166,'Ryan Adams',24,12,76.0,185.0,3),(167,'Trevor Brown',11,12,77.0,195.0,4),(168,'Jason Carter',2,12,78.0,200.0,2),(169,'Derek Davis',5,12,75.0,185.0,1),(170,'Marcus Foster',0,12,80.0,210.0,4),(171,'Jeremiah Harris',15,12,77.0,190.0,2),(172,'Elijah Jackson',3,12,73.0,175.0,3),(173,'Isaiah Jones',20,12,74.0,180.0,4),(174,'Nathan Lawson',1,12,76.0,195.0,1),(175,'Dominic Miller',12,12,81.0,215.0,4),(176,'Xavier Perez',4,12,72.0,170.0,3),(177,'Aaron Reed',25,12,76.0,185.0,1),(178,'Brandon Rivers',10,12,74.0,180.0,2),(179,'Justin Thompson',23,12,80.0,210.0,3),(180,'Jalen Blackmon',5,13,75.0,180.0,2),(181,'Luke Brown',25,13,73.0,165.0,2),(182,'Alex Crawford',24,13,79.0,187.0,2),(183,'Mahamadou Diawara',15,13,82.0,249.0,4),(184,'Aubin Gateretse',21,13,83.0,210.0,2),(185,'Cyncier Harrison',10,13,71.0,160.0,1),(186,'Jackson Huxtable',14,13,78.0,186.0,1),(187,'Alec Oglesby',0,13,77.0,187.0,3),(188,'Wheza Panzo',1,13,79.0,210.0,4),(189,'Sam Peek',2,13,79.0,195.0,4),(190,'Josh Smith',11,13,80.0,215.0,3),(191,'Stephan Swenson',30,13,74.0,195.0,3),(192,'Alvin Tumblin',35,13,79.0,205.0,2),(193,'Giancarlo Valdez',3,13,75.0,170.0,3);
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

-- Dump completed on 2023-04-19 14:56:13
