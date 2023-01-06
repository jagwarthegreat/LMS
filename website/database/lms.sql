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
	(10, 'Book 1', 'dasd', 'asd', 1, '123123', '2023', '100', '1500', '/static/uploads/cover_images/HOME_DECOR_INDOOR_WALL_WATER_FALL_IDEAS___WATER_FEATURES_DESIGN_IDEAS___WALL_MOUNTED_IDEAS_water_a.jpg', 'test loc', '2023-01-05 16:16:08'),
	(11, 'Book 2', '3', '3', 2, '12123', '2021', '100', '1500', '/static/uploads/cover_images/320399216_527773672707625_652718725034596717_n.jpg', 'test', '2023-01-05 16:27:04'),
	(12, 'Book 3', '3', '3', 4, '123123', '2022', '50', '1500', '', 'test', '2023-01-05 16:27:41');

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

-- Dumping structure for table lms.tbl_borrowed_books
CREATE TABLE IF NOT EXISTS `tbl_borrowed_books` (
  `borrow_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'S' COMMENT 'B=borrowed, R=returned, S=saved',
  `date_borrowed` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`borrow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_borrowed_books: ~56 rows (approximately)
INSERT INTO `tbl_borrowed_books` (`borrow_id`, `user_id`, `status`, `date_borrowed`, `date_added`) VALUES
	(1, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 09:59:53'),
	(2, 3, 'S', '2023-01-02 00:00:00', '2023-01-06 10:03:20'),
	(3, 5, 'S', '0000-00-00 00:00:00', '2023-01-06 10:16:03'),
	(5, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 10:33:54'),
	(6, 1, 'S', '2023-01-07 00:00:00', '2023-01-06 10:35:18'),
	(7, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 10:40:25'),
	(8, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 10:43:02'),
	(9, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 10:43:24'),
	(10, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 10:44:02'),
	(11, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 11:39:54'),
	(12, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 11:48:16'),
	(13, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 12:44:48'),
	(14, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 12:51:14'),
	(15, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 12:52:19'),
	(16, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 12:56:18'),
	(17, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 13:10:32'),
	(18, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 13:16:32'),
	(19, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 13:30:02'),
	(20, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 13:37:29'),
	(21, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 13:38:08'),
	(22, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 13:40:13'),
	(23, 4, 'S', '2023-01-06 00:00:00', '2023-01-06 13:40:55'),
	(24, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:01:58'),
	(25, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:05:14'),
	(26, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:15:39'),
	(27, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:19:02'),
	(28, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:20:19'),
	(29, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:21:16'),
	(30, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:22:24'),
	(31, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:28:06'),
	(32, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:32:20'),
	(33, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:39:52'),
	(34, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:42:44'),
	(35, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:46:15'),
	(36, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 14:52:06'),
	(37, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 14:54:58'),
	(38, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:56:07'),
	(39, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 14:59:54'),
	(40, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 15:00:52'),
	(41, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:06:09'),
	(42, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:08:48'),
	(43, 3, 'S', '2022-12-30 00:00:00', '2023-01-06 15:10:29'),
	(44, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:14:28'),
	(45, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:16:43'),
	(46, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 15:22:31'),
	(47, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 15:23:20'),
	(48, 4, 'S', '2023-01-06 00:00:00', '2023-01-06 15:23:49'),
	(49, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:26:13'),
	(50, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 15:27:02'),
	(51, 4, 'S', '2023-01-06 00:00:00', '2023-01-06 15:28:10'),
	(52, 4, 'S', '2023-01-06 00:00:00', '2023-01-06 15:30:34'),
	(53, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:33:38'),
	(54, 4, 'S', '2023-01-06 00:00:00', '2023-01-06 15:34:09'),
	(55, 3, 'S', '2023-01-06 00:00:00', '2023-01-06 15:34:51'),
	(56, 1, 'S', '2023-01-06 00:00:00', '2023-01-06 15:41:12'),
	(57, 4, 'S', '2023-01-06 00:00:00', '2023-01-06 15:44:01');

-- Dumping structure for table lms.tbl_borrowed_books_details
CREATE TABLE IF NOT EXISTS `tbl_borrowed_books_details` (
  `borrow_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrow_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `qty` varchar(10) DEFAULT NULL,
  `qty_returned` varchar(10) DEFAULT NULL,
  `date_returned` datetime NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`borrow_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_borrowed_books_details: ~1 rows (approximately)
INSERT INTO `tbl_borrowed_books_details` (`borrow_detail_id`, `borrow_id`, `book_id`, `qty`, `qty_returned`, `date_returned`, `date_added`) VALUES
	(1, 12, 12, '1', NULL, '0000-00-00 00:00:00', '2023-01-06 13:32:00');

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
