-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
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

-- Dumping structure for table lms.tbl_books
CREATE TABLE IF NOT EXISTS `tbl_books` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_title` varchar(200) NOT NULL,
  `book_author` varchar(150) NOT NULL,
  `book_publisher_name` varchar(150) NOT NULL,
  `book_category_id` int(11) NOT NULL,
  `book_isbn` varchar(50) NOT NULL,
  `book_year_published` varchar(6) NOT NULL,
  `book_qty` varchar(6) NOT NULL,
  `book_price` varchar(16) NOT NULL,
  `book_cover_img` text DEFAULT NULL,
  `book_location` text DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_books: ~3 rows (approximately)
INSERT INTO `tbl_books` (`book_id`, `book_title`, `book_author`, `book_publisher_name`, `book_category_id`, `book_isbn`, `book_year_published`, `book_qty`, `book_price`, `book_cover_img`, `book_location`, `date_added`) VALUES
	(10, 'adsas', 'dasd', 'asd', 1, '123123', '2023', '100', '1500', '/static/uploads/cover_images/HOME_DECOR_INDOOR_WALL_WATER_FALL_IDEAS___WATER_FEATURES_DESIGN_IDEAS___WALL_MOUNTED_IDEAS_water_a.jpg', 'test loc', '2023-01-05 16:16:08'),
	(11, '3', '3', '3', 2, '12123', '2021', '100', '1500', '/static/uploads/cover_images/320399216_527773672707625_652718725034596717_n.jpg', 'test', '2023-01-05 16:27:04'),
	(12, '3', '3', '3', 4, '123123', '2022', '50', '1500', '', 'test', '2023-01-05 16:27:41');

-- Dumping structure for table lms.tbl_book_category
CREATE TABLE IF NOT EXISTS `tbl_book_category` (
  `book_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_category` varchar(150) NOT NULL,
  `book_category_desc` text DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`book_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_book_category: ~5 rows (approximately)
INSERT INTO `tbl_book_category` (`book_category_id`, `book_category`, `book_category_desc`, `date_added`) VALUES
	(1, 'Mystery', NULL, '2023-01-04 15:29:47'),
	(2, 'Romance', NULL, '2023-01-04 15:29:47'),
	(3, 'Fantasy', NULL, '2023-01-04 15:29:47'),
	(4, 'Thriller', NULL, '2023-01-04 15:29:47'),
	(5, 'Sci-Fi', 'test', '2023-01-04 15:47:36');

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
	(1, 'Eduard RIno', 'Questo', 'Carton', 'jag', 'sha256$srhW5avnCjLm7Tkj$0502c352f2f30fa5dfb8111d4c3e72b7c13d9f3da7f76bb3d72aabd5ba97977f', '2023-01-03 15:56:07'),
	(3, 'Jagwarthegreat', 'Questo', 'Carton', 'rin', 'sha256$srhW5avnCjLm7Tkj$0502c352f2f30fa5dfb8111d4c3e72b7c13d9f3da7f76bb3d72aabd5ba97977f', '2022-11-25 16:29:56'),
	(4, 'Kaye', 'N', 'Jacildo', 'k', 'sha256$M3gleJORbojiiJZa$9fa9bf27c354e5e782e95065b1619c9a055e431f345e96c32871fc96407eac75', '2022-11-28 14:22:45'),
	(5, 'jep', 'jep', 'jep', 'jep', 'sha256$B9R8kNibhLTUMID7$01913bf18355117e4fe44cb46088414b749b920628da446028d430998943d565', '2022-11-28 21:12:53');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
