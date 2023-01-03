-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.2.0.6576
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for lms
CREATE DATABASE IF NOT EXISTS `lms` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `lms`;

-- Dumping structure for table lms.tbl_autism_predictions
CREATE TABLE IF NOT EXISTS `tbl_autism_predictions` (
  `ap_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `autism_sign_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ap_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table lms.tbl_autism_predictions: ~7 rows (approximately)
INSERT INTO `tbl_autism_predictions` (`ap_id`, `autism_sign_id`, `student_id`, `status`, `date_added`) VALUES
	(4, 31, 1, 'Pending', '2022-11-28 00:00:00'),
	(5, 33, 1, 'Pending', '2022-11-28 00:00:00'),
	(14, 40, 7, 'Pending', '2022-11-29 10:30:04'),
	(15, 41, 7, 'Pending', '2022-11-29 10:31:36'),
	(17, 33, 7, 'Pending', '2022-11-29 10:33:46'),
	(18, 41, 7, 'Pending', '2022-11-29 10:41:20'),
	(19, 40, 1, 'Pending', '2022-11-29 10:41:35'),
	(20, 33, 7, 'Confirmed', '2022-11-29 10:43:15');

-- Dumping structure for table lms.tbl_autism_signs
CREATE TABLE IF NOT EXISTS `tbl_autism_signs` (
  `autism_sign_id` int(11) NOT NULL AUTO_INCREMENT,
  `autism_sign` varchar(150) DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`autism_sign_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_autism_signs: ~5 rows (approximately)
INSERT INTO `tbl_autism_signs` (`autism_sign_id`, `autism_sign`, `date_added`) VALUES
	(31, 'Delayed language skills', '2022-11-28 14:17:35'),
	(33, 'Delayed movement skills', '2022-11-28 20:26:49'),
	(39, 'Delayed cognitive or learning skills', '2022-11-29 09:15:52'),
	(40, 'Hyperactive, impulsive, and/or inattentive behavior', '2022-11-29 09:16:02'),
	(41, 'Epilepsy or seizure disorder', '2022-11-29 09:16:21');

-- Dumping structure for table lms.tbl_students
CREATE TABLE IF NOT EXISTS `tbl_students` (
  `student_id` int(10) NOT NULL AUTO_INCREMENT,
  `student_fname` varchar(150) NOT NULL,
  `student_mname` varchar(150) DEFAULT NULL,
  `student_lname` varchar(150) NOT NULL,
  `student_year` varchar(50) DEFAULT NULL,
  `student_section` varchar(50) DEFAULT NULL,
  `student_address` text DEFAULT NULL,
  `student_contact_number` varchar(16) DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_students: ~2 rows (approximately)
INSERT INTO `tbl_students` (`student_id`, `student_fname`, `student_mname`, `student_lname`, `student_year`, `student_section`, `student_address`, `student_contact_number`, `date_added`) VALUES
	(1, 'Rino', 'Q', 'Carton', '4th year', '1', 'bcd', NULL, '2022-11-28 21:37:38'),
	(7, 'Judywen', 'Alolon', 'Guapin', '3rd', '1', 'B49 L32 EAST HOMES 5 SUBD., MANSILINGAN BACOLOD CITY 6100', '09214476089', '2022-11-29 10:14:00');

-- Dumping structure for table lms.tbl_user
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(150) NOT NULL,
  `mname` varchar(150) NOT NULL,
  `lname` varchar(150) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `date_added` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_user: ~4 rows (approximately)
INSERT INTO `tbl_user` (`id`, `fname`, `mname`, `lname`, `username`, `password`, `date_added`) VALUES
	(1, 'Eduard RIno', 'Questo', 'Carton', 'jag', 'sha256$srhW5avnCjLm7Tkj$0502c352f2f30fa5dfb8111d4c3e72b7c13d9f3da7f76bb3d72aabd5ba97977f', NULL),
	(3, 'Jagwarthegreat', 'Questo', 'Carton', 'rin', 'sha256$srhW5avnCjLm7Tkj$0502c352f2f30fa5dfb8111d4c3e72b7c13d9f3da7f76bb3d72aabd5ba97977f', '2022-11-25 16:29:56'),
	(4, 'Kaye', 'N', 'Jacildo', 'k', 'sha256$M3gleJORbojiiJZa$9fa9bf27c354e5e782e95065b1619c9a055e431f345e96c32871fc96407eac75', '2022-11-28 14:22:45'),
	(5, 'jep', 'jep', 'jep', 'jep', 'sha256$B9R8kNibhLTUMID7$01913bf18355117e4fe44cb46088414b749b920628da446028d430998943d565', '2022-11-28 21:12:53');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
