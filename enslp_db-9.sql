-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 08, 2026 at 11:01 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `enslp_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounting_transactions`
--

CREATE TABLE `accounting_transactions` (
  `id` int(11) NOT NULL,
  `txn_date` date NOT NULL,
  `type` enum('Income','Expense') NOT NULL,
  `category` varchar(80) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `wo_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `payment_method` varchar(40) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounting_transactions`
--

INSERT INTO `accounting_transactions` (`id`, `txn_date`, `type`, `category`, `reference_no`, `wo_id`, `description`, `payment_method`, `amount`, `created_at`) VALUES
(49, '2026-04-07', 'Expense', 'Production', 'WO-2026-0001', 20, 'Cutting - WO-2026-0001 - Copper Foil Roll', 'Manufacturing', 40000.00, '2026-04-07 20:07:14'),
(50, '2026-04-07', 'Expense', 'Production', 'WO-2026-0001', 20, 'Etching - WO-2026-0001 - Adhesive Film', 'Manufacturing', 10000.00, '2026-04-07 20:44:41'),
(51, '2026-04-07', 'Expense', 'Production', 'WO-2026-0001', 20, 'Lamination - WO-2026-0001 - Polymide Film Sheet', 'Manufacturing', 6000.00, '2026-04-07 21:02:36'),
(52, '2026-04-07', 'Income', 'Delivery', 'DR-19', 20, 'Delivery WO-2026-0001 - FFC Cable 40 Pin (100 pcs)', 'Delivery', 24000.00, '2026-04-07 21:07:34'),
(53, '2026-03-31', 'Expense', 'Payroll', NULL, NULL, 'Salary - Employee ID: 4 (2026-03-16 to 2026-03-31)', NULL, 1825.00, '2026-04-07 21:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `att_date` date NOT NULL,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `status` enum('Present','Absent','On Leave','Half Day') NOT NULL DEFAULT 'Present',
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `employee_id`, `att_date`, `time_in`, `time_out`, `status`, `remarks`, `created_at`, `updated_at`) VALUES
(4, 4, '2026-04-07', '08:00:00', '17:30:00', 'Present', 'N/A', '2026-04-07 13:11:15', '2026-04-07 13:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `cutting_jobs`
--

CREATE TABLE `cutting_jobs` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity_cut` int(11) DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `date_cut` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cutting_jobs`
--

INSERT INTO `cutting_jobs` (`id`, `work_order_id`, `item_id`, `quantity_cut`, `operator`, `date_cut`) VALUES
(27, 20, 10, 50, 'Airish', '2026-04-07');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL,
  `dr_no` varchar(30) NOT NULL,
  `wo_id` int(11) NOT NULL,
  `delivered_to` varchar(150) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `delivered_date` date NOT NULL,
  `status` enum('Pending','Out for Delivery','Delivered','Cancelled') DEFAULT 'Pending',
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `delivery_qty` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `dr_no`, `wo_id`, `delivered_to`, `address`, `delivered_date`, `status`, `remarks`, `created_at`, `updated_at`, `delivery_qty`) VALUES
(19, 'DR-2026-0001', 20, 'Brother Industries Philippines', 'Ulango, Tanauan Batangas', '2026-04-07', 'Delivered', '', '2026-04-07 21:07:30', NULL, 100);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `position` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `employment_status` varchar(50) DEFAULT NULL,
  `date_hired` date DEFAULT NULL,
  `salary_type` enum('Daily','Monthly') NOT NULL DEFAULT 'Daily',
  `salary_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `contact_no` varchar(20) DEFAULT NULL,
  `daily_rate` decimal(10,2) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `monthly_salary` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `full_name`, `position`, `department`, `employment_status`, `date_hired`, `salary_type`, `salary_amount`, `contact_no`, `daily_rate`, `status`, `monthly_salary`) VALUES
(4, 'Liliene Altamirano', 'Engineer', 'Engineering', 'Regular', '2026-01-01', 'Monthly', 750.00, '09234567891', NULL, 'Active', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `etching_jobs`
--

CREATE TABLE `etching_jobs` (
  `id` int(11) NOT NULL,
  `work_order_id` varchar(50) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `design` varchar(100) DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `date_etched` timestamp NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `etching_jobs`
--

INSERT INTO `etching_jobs` (`id`, `work_order_id`, `item_id`, `design`, `operator`, `date_etched`, `quantity`) VALUES
(31, '20', 12, 'Single Layer Flex', 'Lovely', '2026-04-06 16:00:00', 40);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `expense_date` date DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inspection_qc`
--

CREATE TABLE `inspection_qc` (
  `id` int(11) NOT NULL,
  `work_order_id` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `inspector` varchar(100) DEFAULT NULL,
  `status` enum('Passed','Failed') NOT NULL,
  `remarks` text DEFAULT NULL,
  `date_inspected` timestamp NOT NULL DEFAULT current_timestamp(),
  `passed_qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inspection_qc`
--

INSERT INTO `inspection_qc` (`id`, `work_order_id`, `item_id`, `inspector`, `status`, `remarks`, `date_inspected`, `passed_qty`) VALUES
(29, '20', 26, 'Jana', 'Passed', 'Good', '2026-04-07 13:03:12', 50),
(30, '20', 26, 'Klea', 'Failed', 'NG', '2026-04-07 13:04:43', 50),
(31, '20', 26, 'Meai', 'Passed', 'Re-Inspection', '2026-04-07 13:06:52', 50);

-- --------------------------------------------------------

--
-- Table structure for table `inventory_items`
--

CREATE TABLE `inventory_items` (
  `id` int(11) NOT NULL,
  `item_code` varchar(50) DEFAULT NULL,
  `item_name` varchar(150) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `unit` varchar(30) DEFAULT 'pcs',
  `quantity` int(11) NOT NULL DEFAULT 0,
  `reorder_level` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `cost` decimal(10,2) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT 0.00,
  `status` varchar(20) DEFAULT 'active',
  `value` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory_items`
--

INSERT INTO `inventory_items` (`id`, `item_code`, `item_name`, `category`, `unit`, `quantity`, `reorder_level`, `created_at`, `cost`, `selling_price`, `status`, `value`) VALUES
(10, NULL, 'Copper Foil Roll', 'Raw Material', 'roll', 677, 10, '2026-03-16 10:32:34', 800.00, 0.00, 'active', 541600.00),
(11, NULL, 'Polymide Film Sheet', 'Raw Material', 'sheet', 377, 50, '2026-03-16 10:33:13', 120.00, 0.00, 'active', 45240.00),
(12, NULL, 'Adhesive Film', 'Raw Material', 'roll', 949, 5, '2026-03-16 10:35:38', 250.00, 0.00, 'active', 237250.00),
(13, NULL, 'FFC Connector 20 Pin', 'Component', 'pcs', 500, 100, '2026-03-16 10:36:11', 5.00, 0.00, 'active', 2500.00),
(14, NULL, 'Contact Terminal', 'Component', 'pcs', 1000, 200, '2026-03-16 10:36:42', 0.80, 0.00, 'active', 800.00),
(15, NULL, 'Ferric Chloride Etching Solution ', 'Supply', 'liter', 1020, 5, '2026-03-16 10:37:28', 200.00, 0.00, 'active', 204000.00),
(16, NULL, 'Lamination Glue ', 'Supply', 'bottle', 540, 10, '2026-03-16 10:39:29', 100.00, 0.00, 'active', 54000.00),
(17, NULL, 'Protective Tape Roll', 'Supply', 'roll', 440, 15, '2026-03-16 10:40:05', 30.00, 0.00, 'active', 13200.00),
(20, NULL, 'FFC 80 Pin', 'Finished Good', 'pcs', 1100, 0, '2026-03-19 10:30:10', 0.00, 0.00, 'inactive', 0.00),
(21, NULL, 'FFC 90', 'Finished Good', 'pcs', 1012, 0, '2026-03-19 10:58:50', 0.00, 0.00, 'inactive', 0.00),
(22, NULL, '100 PIN', 'Finished Good', 'pcs', 1005, 0, '2026-03-19 11:21:10', 0.00, 0.00, 'inactive', 0.00),
(23, NULL, '111', 'Finished Good', 'pcs', 996, 0, '2026-03-19 12:07:03', 0.00, 2.00, 'inactive', 0.00),
(24, NULL, 'FFC Cable 20 Pin', 'Finished Good', 'pcs', 80, 20, '2026-04-06 22:18:01', 35.00, 120.00, 'active', 2800.00),
(25, NULL, 'FFC Cable 30 Pin', 'Finished Good', 'pcs', 20, 20, '2026-04-06 22:18:01', 50.00, 180.00, 'active', 1000.00),
(26, NULL, 'FFC Cable 40 Pin', 'Finished Good', 'pcs', 0, 20, '2026-04-06 22:18:01', 70.00, 240.00, 'active', 0.00),
(27, NULL, 'FFC Cable 50 Pin', 'Finished Good', 'pcs', 50, 20, '2026-04-06 22:18:01', 90.00, 300.00, 'active', 4500.00),
(28, NULL, 'FFC Cable 60 Pin', 'Finished Good', 'pcs', 50, 20, '2026-04-06 22:18:01', 105.00, 360.00, 'active', 5250.00),
(29, NULL, 'FFC Cable 70 Pin', 'Finished Good', 'pcs', 200, 20, '2026-04-06 22:18:01', 120.00, 420.00, 'active', 24000.00),
(30, NULL, 'FFC Cable 80 Pin', 'Finished Good', 'pcs', 0, 20, '2026-04-06 22:18:01', 140.00, 480.00, 'active', 0.00),
(31, NULL, 'FFC Cable 90 Pin', 'Finished Good', 'pcs', 0, 20, '2026-04-06 22:18:01', 160.00, 540.00, 'active', 0.00),
(32, NULL, 'FFC Cable 100 Pin', 'Finished Good', 'pcs', 0, 20, '2026-04-06 22:18:01', 180.00, 600.00, 'active', 0.00),
(33, NULL, 'FFC Cable 120 Pin', 'Finished Good', 'pcs', 0, 20, '2026-04-06 22:18:01', 210.00, 720.00, 'active', 0.00),
(34, NULL, 'mm', 'Component', 'roll', 5, 10, '2026-04-07 18:56:06', 450.00, 0.00, 'active', 0.00),
(35, NULL, 'nn', 'Raw Material', 'pcs', 0, 10, '2026-04-07 18:57:25', 250.00, 0.00, 'active', 0.00);

--
-- Triggers `inventory_items`
--
DELIMITER $$
CREATE TRIGGER `update_value_before_update` BEFORE UPDATE ON `inventory_items` FOR EACH ROW SET NEW.value = NEW.cost * NEW.quantity
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lamination_jobs`
--

CREATE TABLE `lamination_jobs` (
  `id` int(11) NOT NULL,
  `work_order_id` varchar(50) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `adhesive_type` varchar(100) DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `date_laminated` timestamp NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lamination_jobs`
--

INSERT INTO `lamination_jobs` (`id`, `work_order_id`, `item_id`, `adhesive_type`, `operator`, `date_laminated`, `quantity`) VALUES
(26, '20', 11, 'Acrylic', 'Meai', '2026-04-06 16:00:00', 50);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `action`, `description`, `timestamp`) VALUES
(2, 3, 'Add User', 'Added user: jovan (Role: Production)', '2026-04-08 14:12:44');

-- --------------------------------------------------------

--
-- Table structure for table `packing_jobs`
--

CREATE TABLE `packing_jobs` (
  `id` int(11) NOT NULL,
  `work_order_id` varchar(50) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity_packed` int(11) NOT NULL,
  `packer` varchar(100) DEFAULT NULL,
  `date_packed` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `packing_jobs`
--

INSERT INTO `packing_jobs` (`id`, `work_order_id`, `item_id`, `quantity_packed`, `packer`, `date_packed`) VALUES
(16, '20', 26, 50, 'Meai', '2026-04-07 13:06:12'),
(17, '20', 26, 50, 'Klea', '2026-04-07 13:07:09');

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `days_worked` decimal(5,2) NOT NULL DEFAULT 0.00,
  `overtime_hours` decimal(5,2) NOT NULL DEFAULT 0.00,
  `overtime_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `deductions` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gross_pay` decimal(10,2) NOT NULL DEFAULT 0.00,
  `net_pay` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `pay_type` varchar(20) NOT NULL DEFAULT 'REGULAR',
  `basic_pay` decimal(10,2) NOT NULL DEFAULT 0.00,
  `overtime_pay` decimal(10,2) NOT NULL DEFAULT 0.00,
  `allowances` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sss` decimal(10,2) NOT NULL DEFAULT 0.00,
  `philhealth` decimal(10,2) NOT NULL DEFAULT 0.00,
  `pagibig` decimal(10,2) NOT NULL DEFAULT 0.00,
  `other_deductions` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payroll`
--

INSERT INTO `payroll` (`id`, `employee_id`, `period_start`, `period_end`, `days_worked`, `overtime_hours`, `overtime_rate`, `deductions`, `gross_pay`, `net_pay`, `created_at`, `pay_type`, `basic_pay`, `overtime_pay`, `allowances`, `sss`, `philhealth`, `pagibig`, `other_deductions`) VALUES
(3, 4, '2026-03-16', '2026-03-31', 12.00, 5.00, 90.00, 0.00, 1825.00, 1825.00, '2026-04-07 13:10:13', 'REGULAR', 375.00, 450.00, 1000.00, 0.00, 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `production_history`
--

CREATE TABLE `production_history` (
  `id` int(11) NOT NULL,
  `wo_id` int(11) DEFAULT NULL,
  `wo_no` varchar(50) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `client` varchar(100) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date_started` date DEFAULT NULL,
  `date_finished` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `production_history`
--

INSERT INTO `production_history` (`id`, `wo_id`, `wo_no`, `product_name`, `client`, `qty`, `selling_price`, `status`, `remarks`, `date_started`, `date_finished`, `created_at`) VALUES
(1, 5, 'WO-2026-0001', 'FFC 20 Pin', 'Samsung', 200, 250.00, 'Completed', NULL, '2026-03-16', '2026-03-18', '2026-03-18 13:03:36'),
(2, 6, 'WO-2026-0006', 'FFC 30 Pin', 'Brother Inc.', 20, 150.00, 'Completed', NULL, '2026-03-18', '2026-03-18', '2026-03-18 13:03:36'),
(3, 7, 'WO-2026-0007', 'FFC 40 Pin', 'Mitsubishi', 200, 500.00, 'Completed', NULL, '2026-03-18', '2026-03-18', '2026-03-18 13:03:36');

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `movement_type` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `movement_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_movements`
--

INSERT INTO `stock_movements` (`id`, `item_id`, `movement_type`, `quantity`, `reference`, `notes`, `created_at`, `movement_date`) VALUES
(86, 10, 'cutting', 50, '20', NULL, '2026-04-07 20:07:14', '2026-04-07 20:07:14'),
(87, 12, 'etching', 40, '20', NULL, '2026-04-07 20:44:41', '2026-04-07 20:44:41'),
(88, 11, 'lamination', 50, '20', NULL, '2026-04-07 21:02:36', '2026-04-07 21:02:36'),
(89, 26, 'Stock In', 50, '20', 'QC STOCK IN', '2026-04-07 21:03:12', '2026-04-07 21:03:12'),
(90, 26, 'Stock In', 50, '20', 'QC STOCK IN', '2026-04-07 21:06:52', '2026-04-07 21:06:52'),
(91, 26, 'OUT', 100, 'DR-19', 'Delivery WO-2026-0001', '2026-04-07 21:07:34', '2026-04-07 21:07:34');

-- --------------------------------------------------------

--
-- Table structure for table `thirteenth_month`
--

CREATE TABLE `thirteenth_month` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `total_basic_salary` decimal(12,2) DEFAULT 0.00,
  `thirteenth_amount` decimal(12,2) DEFAULT 0.00,
  `generated_by` int(11) DEFAULT NULL,
  `date_generated` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'Admin',
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `full_name`, `password`, `role`, `status`) VALUES
(3, 'admin', 'System Administrator', '$2y$10$fW7TiiAWFOYO.PSwVGeA2uwZN37uo4Kr7ovWfJKglkxn.i7Ecba5G', 'Admin', 'Active'),
(5, 'meai', NULL, '$2y$10$f1w56eaLbftFJ.8UmbvpxOpn3ab46oVycvM3CNpCNeRNQZx6VH3eO', 'Production', 'active'),
(6, 'lovely', NULL, '$2y$10$tVEt7/a5Pdc7VCS6yzr8kO1EWKV17K2KIkl62WTy9rhrQiFWL3mZW', 'Accounting', 'active'),
(7, 'airish', NULL, '$2y$10$nl3kdqGaJT4dy7OtLGIEI.NoFHTE3r9ApS5t.I3m.ByZ0N4BP0ad.', 'Engineer', 'active'),
(9, 'may', NULL, '$2y$10$byKoHpqLdRX7l5DO3oPND.OYkbAGdwU02dJKTsF714kf/XG05UZ9.', 'Staff', 'active'),
(10, 'meyay', NULL, '$2y$10$S8Cz4iF53P73b.lxAGGGhOozVYwFb/k9rgO/fodJRki5PzFYEINCe', 'Production', 'active'),
(11, 'jovan', NULL, '$2y$10$GWOr0yX3U0PXhKAMswnnVOYuHbtwaan9zHl9irUM.6a8dN0G59iTS', 'Production', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `work_orders`
--

CREATE TABLE `work_orders` (
  `id` int(11) NOT NULL,
  `wo_no` varchar(50) DEFAULT NULL,
  `product_name` varchar(150) NOT NULL,
  `client` varchar(150) DEFAULT NULL,
  `qty` int(11) DEFAULT 0,
  `status` varchar(50) DEFAULT NULL,
  `date_started` date NOT NULL,
  `date_completed` date DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `selling_price` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `work_orders`
--

INSERT INTO `work_orders` (`id`, `wo_no`, `product_name`, `client`, `qty`, `status`, `date_started`, `date_completed`, `remarks`, `created_at`, `selling_price`) VALUES
(20, 'WO-2026-0001', 'FFC Cable 40 Pin', 'Brother Industries Philippines', 100, 'Completed', '2026-04-07', '2026-04-07', NULL, '2026-04-07 12:06:47', 240.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounting_transactions`
--
ALTER TABLE `accounting_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_emp_date` (`employee_id`,`att_date`);

--
-- Indexes for table `cutting_jobs`
--
ALTER TABLE `cutting_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dr_no` (`dr_no`),
  ADD KEY `wo_id` (`wo_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `etching_jobs`
--
ALTER TABLE `etching_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inspection_qc`
--
ALTER TABLE `inspection_qc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_name` (`item_name`);

--
-- Indexes for table `lamination_jobs`
--
ALTER TABLE `lamination_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_jobs`
--
ALTER TABLE `packing_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_payroll_employee` (`employee_id`);

--
-- Indexes for table `production_history`
--
ALTER TABLE `production_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `thirteenth_month`
--
ALTER TABLE `thirteenth_month`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_emp_year` (`employee_id`,`year`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wo_no` (`wo_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounting_transactions`
--
ALTER TABLE `accounting_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cutting_jobs`
--
ALTER TABLE `cutting_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `etching_jobs`
--
ALTER TABLE `etching_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inspection_qc`
--
ALTER TABLE `inspection_qc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `inventory_items`
--
ALTER TABLE `inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `lamination_jobs`
--
ALTER TABLE `lamination_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `packing_jobs`
--
ALTER TABLE `packing_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `production_history`
--
ALTER TABLE `production_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `thirteenth_month`
--
ALTER TABLE `thirteenth_month`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `work_orders`
--
ALTER TABLE `work_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`wo_id`) REFERENCES `work_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payroll`
--
ALTER TABLE `payroll`
  ADD CONSTRAINT `fk_payroll_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
