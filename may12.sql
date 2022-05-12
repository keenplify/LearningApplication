-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.7-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for learning_application_db
CREATE DATABASE IF NOT EXISTS `learning_application_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `learning_application_db`;

-- Dumping structure for table learning_application_db.quiz_choices_tbl
CREATE TABLE IF NOT EXISTS `quiz_choices_tbl` (
  `quiz_choices_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `text` longtext DEFAULT NULL,
  `quiz_question_uuid` varchar(36) DEFAULT NULL,
  `is_right` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`quiz_choices_uuid`) USING BTREE,
  KEY `QUIZ_QUESTIONFK` (`quiz_question_uuid`),
  CONSTRAINT `QUIZ_QUESTIONFK` FOREIGN KEY (`quiz_question_uuid`) REFERENCES `quiz_questions_tbl` (`quiz_question_uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.quiz_choices_tbl: ~21 rows (approximately)
/*!40000 ALTER TABLE `quiz_choices_tbl` DISABLE KEYS */;
INSERT INTO `quiz_choices_tbl` (`quiz_choices_uuid`, `text`, `quiz_question_uuid`, `is_right`) VALUES
	('3a9cec2f-cdba-11ec-ab05-00d861bb616d', 'Does not exist', '28acf3f7-797f-48e3-9018-0f116977d8db', 0),
	('3a9e69e6-cdba-11ec-ab05-00d861bb616d', '1', '28acf3f7-797f-48e3-9018-0f116977d8db', 0),
	('3aa00406-cdba-11ec-ab05-00d861bb616d', '0', '28acf3f7-797f-48e3-9018-0f116977d8db', 1),
	('3aab3ba2-cdba-11ec-ab05-00d861bb616d', '-1', '28acf3f7-797f-48e3-9018-0f116977d8db', 0),
	('5a9ee430-cdd5-11ec-ab05-00d861bb616d', '8', '19136da8-19d2-4644-a285-b31137cefbce', 0),
	('5aa3cf23-cdd5-11ec-ab05-00d861bb616d', '1', '19136da8-19d2-4644-a285-b31137cefbce', 0),
	('5aaf1027-cdd5-11ec-ab05-00d861bb616d', '12', '19136da8-19d2-4644-a285-b31137cefbce', 0),
	('5ab0aaf4-cdd5-11ec-ab05-00d861bb616d', '13', '19136da8-19d2-4644-a285-b31137cefbce', 1),
	('5ab24a50-cdd5-11ec-ab05-00d861bb616d', '0', '19136da8-19d2-4644-a285-b31137cefbce', 0),
	('775b3851-cdd5-11ec-ab05-00d861bb616d', 'pi', '79667c0d-debd-4610-bda3-fd5417dc08d2', 0),
	('7766794c-cdd5-11ec-ab05-00d861bb616d', 'pi^2', '79667c0d-debd-4610-bda3-fd5417dc08d2', 1),
	('7768147d-cdd5-11ec-ab05-00d861bb616d', '0', '79667c0d-debd-4610-bda3-fd5417dc08d2', 0),
	('7769aeb0-cdd5-11ec-ab05-00d861bb616d', '1', '79667c0d-debd-4610-bda3-fd5417dc08d2', 0),
	('868b9f5a-d06e-11ec-a98b-00d861bb616d', 'Mapait', '38be43f0-a7e9-494a-ae85-aa59c7cb1b5b', 0),
	('868d3350-d06e-11ec-a98b-00d861bb616d', 'Matamis', '38be43f0-a7e9-494a-ae85-aa59c7cb1b5b', 0),
	('868ecec5-d06e-11ec-a98b-00d861bb616d', 'Maasim', '38be43f0-a7e9-494a-ae85-aa59c7cb1b5b', 1),
	('86906b3f-d06e-11ec-a98b-00d861bb616d', 'Maalat', '38be43f0-a7e9-494a-ae85-aa59c7cb1b5b', 0),
	('fdeec6ed-cdc7-11ec-ab05-00d861bb616d', 'Aczell', '98def2fb-edc3-4f2b-8c37-a2e55e80104c', 1),
	('fdf9ff5f-cdc7-11ec-ab05-00d861bb616d', 'You', '98def2fb-edc3-4f2b-8c37-a2e55e80104c', 0),
	('fdfb9a5f-cdc7-11ec-ab05-00d861bb616d', 'Not Aczell', '98def2fb-edc3-4f2b-8c37-a2e55e80104c', 0),
	('fdfd3381-cdc7-11ec-ab05-00d861bb616d', 'Me', '98def2fb-edc3-4f2b-8c37-a2e55e80104c', 0);
/*!40000 ALTER TABLE `quiz_choices_tbl` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
