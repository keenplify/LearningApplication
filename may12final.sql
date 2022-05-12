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

-- Dumping structure for table learning_application_db.quizzes_tbl
CREATE TABLE IF NOT EXISTS `quizzes_tbl` (
  `quiz_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `title` varchar(50) NOT NULL,
  `topic_uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`quiz_uuid`),
  KEY `TOPICFK` (`topic_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.quizzes_tbl: ~3 rows (approximately)
/*!40000 ALTER TABLE `quizzes_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizzes_tbl` ENABLE KEYS */;

-- Dumping structure for table learning_application_db.quiz_choices_tbl
CREATE TABLE IF NOT EXISTS `quiz_choices_tbl` (
  `quiz_choices_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `text` longtext DEFAULT NULL,
  `quiz_question_uuid` varchar(36) DEFAULT NULL,
  `is_right` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`quiz_choices_uuid`) USING BTREE,
  KEY `QUIZ_QUESTIONFK` (`quiz_question_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.quiz_choices_tbl: ~21 rows (approximately)
/*!40000 ALTER TABLE `quiz_choices_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_choices_tbl` ENABLE KEYS */;

-- Dumping structure for table learning_application_db.quiz_questions_tbl
CREATE TABLE IF NOT EXISTS `quiz_questions_tbl` (
  `quiz_question_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `text` longtext NOT NULL,
  `quiz_uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`quiz_question_uuid`),
  KEY `QUIZFK` (`quiz_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.quiz_questions_tbl: ~5 rows (approximately)
/*!40000 ALTER TABLE `quiz_questions_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_questions_tbl` ENABLE KEYS */;

-- Dumping structure for table learning_application_db.quiz_results_tbl
CREATE TABLE IF NOT EXISTS `quiz_results_tbl` (
  `quiz_result_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `total_score` int(11) NOT NULL DEFAULT 0,
  `max_score` int(11) NOT NULL,
  `user_uuid` varchar(36) NOT NULL,
  `quiz_uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`quiz_result_uuid`),
  KEY `QUIZTAKENFK` (`quiz_uuid`),
  KEY `QUIZTAKERFK` (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.quiz_results_tbl: ~2 rows (approximately)
/*!40000 ALTER TABLE `quiz_results_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_results_tbl` ENABLE KEYS */;

-- Dumping structure for table learning_application_db.subjects_tbl
CREATE TABLE IF NOT EXISTS `subjects_tbl` (
  `subject_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `title` varchar(512) NOT NULL,
  `logo_src` varchar(512) DEFAULT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`subject_uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.subjects_tbl: ~6 rows (approximately)
/*!40000 ALTER TABLE `subjects_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects_tbl` ENABLE KEYS */;

-- Dumping structure for table learning_application_db.topics_tbl
CREATE TABLE IF NOT EXISTS `topics_tbl` (
  `topic_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `title` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `logo_src` varchar(1024) DEFAULT NULL,
  `subject_uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`topic_uuid`),
  KEY `SUBJECTFK` (`subject_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.topics_tbl: ~4 rows (approximately)
/*!40000 ALTER TABLE `topics_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics_tbl` ENABLE KEYS */;

-- Dumping structure for table learning_application_db.users_tbl
CREATE TABLE IF NOT EXISTS `users_tbl` (
  `user_uuid` varchar(36) NOT NULL DEFAULT uuid(),
  `full_name` varchar(128) NOT NULL,
  `username` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_uuid`) USING BTREE,
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table learning_application_db.users_tbl: ~2 rows (approximately)
/*!40000 ALTER TABLE `users_tbl` DISABLE KEYS */;
INSERT INTO `users_tbl` (`user_uuid`, `full_name`, `username`, `email`, `password`, `is_admin`) VALUES
	('4c624f0b-cbce-11ec-a798-00d861bb616d', 'Test Admin', 'testadmin', 'testadmin@gmail.com', '$2y$10$wV2xN/rti65mbf5CfBeJpOyAwU9P0VD5LUApcP5/Ytf/7EVAYlasm', 1),
	('6071bc0b-cc18-11ec-a798-00d861bb616d', 'Test Userz', 'testuser', 'testuser@gmail.com', '$2a$10$Cei89uLIkNPYctVcQV6LwuaguNXsbk9z21qoguy6J6G6uoAvm8aRW', 0);
/*!40000 ALTER TABLE `users_tbl` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
