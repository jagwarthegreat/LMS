-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.4.0.6659
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_books: ~7 rows (approximately)
INSERT INTO `tbl_books` (`book_id`, `book_title`, `book_author`, `book_publisher_name`, `book_category_id`, `book_isbn`, `book_year_published`, `book_qty`, `book_price`, `book_cover_img`, `book_location`, `date_added`) VALUES
	(13, 'A Tale Of Two Cities', 'Charles Dickens', 'Charles Dickens', 10, '000001', '2020', '200', '500', '/static/uploads/cover_images/ataleoftwocities.jpg', 'QA 100.74.B50', '2023-04-19 10:03:10'),
	(14, 'The Little Prince', 'Antoine de Saint-Exupéry', 'Antoine de Saint', 9, '000002', '2020', '150', '650', '/static/uploads/cover_images/the-little-prince-60.jpg', 'QA 100.74.B50', '2023-04-19 10:03:56'),
	(15, 'Harry Potter and the Philosopher\'s Stone', 'JK Rowling', 'JK Rowling', 3, '000003', '1995', '300', '1500', '/static/uploads/cover_images/81m1s4wIPML.jpg', 'QA 100.74.B50', '2023-04-19 10:04:40'),
	(16, 'And Then There Were None', 'Agatha Christie', 'Agatha Christie', 1, '000004', '2021', '100', '130', '/static/uploads/cover_images/and-then-there-were-none-1.jpg', 'QA 100.74.B50', '2023-04-19 10:05:24'),
	(17, 'The Hobbit', 'JRR Tolkien', 'JRR Tolkien', 3, '000004', '2022', '400', '450', '/static/uploads/cover_images/509977c969beddec46000011.jpg', 'QA 100.74.B50', '2023-04-19 10:06:27'),
	(18, 'The Lion, the Witch and the Wardrobe', 'CS Lewis', 'CS Lewis', 3, '00005', '2023', '150', '600', '/static/uploads/cover_images/narnia.jpg', 'QA 100.74.B50', '2023-04-19 10:07:08'),
	(19, 'The Eye of the World', 'Robert Jordan', 'Robert Jordan', 3, '0000007', '2021', '100', '1600', '/static/uploads/cover_images/1663778488-51vYL46dfL._SL500_.jpg', 'QA 100.74.B50', '2023-04-19 13:18:56');

-- Dumping structure for table lms.tbl_book_category
CREATE TABLE IF NOT EXISTS `tbl_book_category` (
  `book_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_category` varchar(150) NOT NULL,
  `book_category_desc` text DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`book_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_book_category: ~9 rows (approximately)
INSERT INTO `tbl_book_category` (`book_category_id`, `book_category`, `book_category_desc`, `date_added`) VALUES
	(1, 'Mystery', NULL, '2023-01-04 15:29:47'),
	(2, 'Romance', NULL, '2023-01-04 15:29:47'),
	(3, 'Fantasy', NULL, '2023-01-04 15:29:47'),
	(4, 'Thriller', NULL, '2023-01-04 15:29:47'),
	(5, 'Sci-Fi', 'test', '2023-01-04 15:47:36'),
	(9, 'Adventure', '', '2023-04-19 10:00:42'),
	(10, 'Historical fiction', '', '2023-04-19 10:00:55'),
	(11, 'Horror', '', '2023-04-19 10:01:03'),
	(12, 'Poetry', '', '2023-04-19 10:01:25');

-- Dumping structure for table lms.tbl_borrowed_books
CREATE TABLE IF NOT EXISTS `tbl_borrowed_books` (
  `borrow_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `trans_id` text NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'S' COMMENT 'B=borrowed, R=returned, S=saved',
  `date_borrowed` datetime DEFAULT NULL,
  `date_returned` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`borrow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_borrowed_books: ~3 rows (approximately)
INSERT INTO `tbl_borrowed_books` (`borrow_id`, `user_id`, `trans_id`, `status`, `date_borrowed`, `date_returned`, `date_added`) VALUES
	(3, 3, '0001', 'S', '2023-04-19 00:00:00', NULL, '2023-04-19 10:07:43'),
	(8, 4, '0002', 'S', '2023-04-19 00:00:00', NULL, '2023-04-19 14:03:40'),
	(9, 4, 'BRW-20230425144001', 'R', '2023-04-25 00:00:00', '2023-04-25 00:00:00', '2023-04-25 14:40:01');

-- Dumping structure for table lms.tbl_borrowed_books_details
CREATE TABLE IF NOT EXISTS `tbl_borrowed_books_details` (
  `borrow_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrow_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `qty` varchar(10) DEFAULT NULL,
  `qty_returned` varchar(10) DEFAULT NULL,
  `date_returned` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`borrow_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_borrowed_books_details: ~8 rows (approximately)
INSERT INTO `tbl_borrowed_books_details` (`borrow_detail_id`, `borrow_id`, `book_id`, `qty`, `qty_returned`, `date_returned`, `date_added`) VALUES
	(9, 3, 13, '1', NULL, NULL, '2023-04-19 10:07:48'),
	(10, 3, 17, '1', NULL, NULL, '2023-04-19 10:07:55'),
	(12, 3, 18, '2', NULL, NULL, '2023-04-19 11:47:05'),
	(13, 3, 19, '1', NULL, NULL, '2023-04-19 13:19:08'),
	(14, 3, 15, '1', NULL, NULL, '2023-04-19 13:39:24'),
	(17, 8, 16, '1', NULL, NULL, '2023-04-19 14:05:05'),
	(18, 9, 13, '1', '1', '2023-04-25 00:00:00', '2023-04-25 14:40:12'),
	(19, 9, 19, '1', '1', '2023-04-25 00:00:00', '2023-04-25 14:40:23');

-- Dumping structure for table lms.tbl_user
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(150) NOT NULL,
  `mname` varchar(150) NOT NULL,
  `lname` varchar(150) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `category` varchar(150) NOT NULL,
  `date_added` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table lms.tbl_user: ~4 rows (approximately)
INSERT INTO `tbl_user` (`id`, `fname`, `mname`, `lname`, `username`, `password`, `category`, `date_added`) VALUES
	(1, 'Eduard RIno', 'Questo', 'Carton', 'jag', 'sha256$srhW5avnCjLm7Tkj$0502c352f2f30fa5dfb8111d4c3e72b7c13d9f3da7f76bb3d72aabd5ba97977f', 'Admin', '2023-01-03 15:56:07'),
	(3, 'Jagwarthegreat', 'Questo', 'Carton', 'rin', 'sha256$srhW5avnCjLm7Tkj$0502c352f2f30fa5dfb8111d4c3e72b7c13d9f3da7f76bb3d72aabd5ba97977f', 'Student', '2022-11-25 16:29:56'),
	(4, 'Kaye', 'N', 'Jacildo', 'k', 'sha256$M3gleJORbojiiJZa$9fa9bf27c354e5e782e95065b1619c9a055e431f345e96c32871fc96407eac75', 'Student', '2022-11-28 14:22:45'),
	(5, 'jep', 'jep', 'jep', 'jep', 'sha256$B9R8kNibhLTUMID7$01913bf18355117e4fe44cb46088414b749b920628da446028d430998943d565', 'Teacher', '2022-11-28 21:12:53');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
