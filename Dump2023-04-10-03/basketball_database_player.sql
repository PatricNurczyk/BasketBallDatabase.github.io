-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: basketball_database
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Sola Adebisi',51,1,78.0,190.0,3),(2,'Sola Adebisi',51,1,78.0,190.0,3),(3,'Sola Adebisi',51,1,78.0,190.0,3),(4,'Jeremiah Bembry',10,1,78.0,185.0,1),(5,'Michael Brown',45,1,79.0,220.0,2),(6,'Matthew Cleveland',35,1,79.0,200.0,2),(7,'Cam Ron Corhen',3,1,82.0,225.0,1),(8,'Ron Fletcher',21,1,79.0,215.0,3),(9,'Jaylan Gainey',33,1,82.0,220.0,4),(10,'DeAnte Green',5,1,82.0,210.0,1),(11,'Darin Green Jr.',22,1,77.0,195.0,3),(12,'Tom House',12,1,79.0,200.0,1),(13,'Chandler Jackson',0,1,77.0,215.0,1),(14,'Naheem McLeod',24,1,88.0,255.0,2),(15,'Baba Miller',11,1,83.0,204.0,1),(16,'Caleb Mills',4,1,77.0,180.0,3),(17,'R.J. Morris',41,1,75.0,185.0,1),(18,'Tibor Palinkas',43,1,76.0,190.0,3),(19,'Isaac Spainhour',40,1,75.0,180.0,2);
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

-- Dump completed on 2023-04-10 16:05:10
