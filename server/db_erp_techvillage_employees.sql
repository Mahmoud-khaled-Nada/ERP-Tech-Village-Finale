-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 30, 2023 at 09:24 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_erp_techvillage_employees`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fingerprints`
--

CREATE TABLE `fingerprints` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `time_attendance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_departure` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `all_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fingerprints`
--

INSERT INTO `fingerprints` (`id`, `user_id`, `time_attendance`, `time_departure`, `created_at`, `updated_at`) VALUES
(1, 1, '09:00:00 am', '10:38:49 pm', NULL, '2023-10-30 15:53:16', '2023-10-30 18:38:50'),
(2, 1, '10:27:39 pm', '10:50:52 pm', NULL, '2023-10-30 18:27:39', '2023-10-30 18:50:53'),
(3, 1, '10:51:05 pm', '10:51:25 pm', NULL, '2023-10-30 18:51:05', '2023-10-30 18:51:26'),
(4, 1, '10:51:45 pm', '10:51:52 pm', NULL, '2023-10-30 18:51:46', '2023-10-30 18:51:53'),
(5, 1, '11:01:02 pm', '11:51:52 pm', NULL, '2023-10-30 19:01:03', '2023-10-30 19:01:03'),
(6, 2, '11:02:45 pm', '11:02:50 pm', NULL, '2023-10-30 19:02:45', '2023-10-30 19:02:51');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(21, '2023_10_23_181630_create_employees_table', 1),
(26, '2014_10_12_000000_create_users_table', 2),
(27, '2014_10_12_100000_create_password_reset_tokens_table', 2),
(28, '2019_08_19_000000_create_failed_jobs_table', 2),
(29, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(30, '2023_10_30_171539_create_fingerprints_table', 3),
(31, '2023_10_30_171617_create_reports_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `date` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `degree` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `date_contract` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_job` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `type`, `date_contract`, `section`, `title_job`, `email_verified_at`, `image`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', 'supperAdmin', '20/10/2023', 'Engineering', 'software Engineer', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/User_icon-cp.svg/1200px-User_icon-cp.svg.png', '$2y$10$19Az3uUE17fCnSddfmLJAeEm9EYv9F0aGN7LXTQHSuYtcG33ICftO', NULL, '2023-10-25 15:27:37', '2023-10-25 15:27:37'),
(2, 'Mahmoud Nada', 'm.khaled.nada@gmail.com', 'admin', NULL, 'engineering', 'developer', NULL, NULL, '$2y$10$th3uhFiB1FuMxYMX02TiGeJ1ORp6wvE6HekY1tUo/.Fo3jIPpHHfy', NULL, '2023-10-25 15:56:52', '2023-10-25 15:56:52'),
(3, 'Cecilia Rhodes', 'testx@mailinator.com', 'admin', NULL, 'Non modi aperiam ad', 'Id iusto nisi volup', NULL, 'https://cdn2.iconfinder.com/data/icons/avatars-60/5985/40-School_boy-256.png', '$2y$10$0vBlG1zYhvXi.8vZEIt7UuuSXiHzfNp1GC4mZLaXVnQ9blUdcGlsm', NULL, '2023-10-25 16:41:18', '2023-10-28 15:19:40'),
(5, 'Aileen Boyer', 'vagu@mailinator.com', 'normal', NULL, 'Magna nisi et elit', 'Architecto eu in ad', NULL, NULL, '$2y$10$TD66Bm4NX7UvG.bBCQqnEeMrZnZm4q7vgqkC5aBjKMupFz02K9CQu', NULL, '2023-10-25 16:41:41', '2023-10-25 16:41:41'),
(9, 'Steel Farmer', 'patikucahi@mailinator.com', 'admin', NULL, 'Ullamco excepteur la', 'Labore incidunt ani', NULL, NULL, '$2y$10$o1O3txLB02W7XcjhQmYZluveyrTY3RNFpolK1K7TBkeh5flepcKvi', NULL, '2023-10-28 15:31:17', '2023-10-28 15:31:17'),
(10, 'Chadwick Mclean', 'tibosemu@mailinator.com', 'admin', NULL, 'Adipisci praesentium', 'Incididunt in laboru', NULL, NULL, '$2y$10$8lSEk.Lh15zeihh29b0dMOQHDtCoBrVc3cP.NXHACL4cJMRFeX4tC', NULL, '2023-10-28 15:35:21', '2023-10-28 15:35:21'),
(11, 'Dolan Shields', 'wolyn@mailinator.com', 'supperAdmin', NULL, 'Doloremque eum lauda', 'Minim nostrum sed re', NULL, NULL, '$2y$10$KMdudbaXoTGdAE9AxDtv8uCIXxU1CA5yTEphTcrK666n1lIMoD0QS', NULL, '2023-10-28 15:35:49', '2023-10-28 15:35:49'),
(12, 'Frances Weiss', 'kyqem@mailinator.com', 'admin', NULL, 'Officiis illum sunt', 'Adipisci quia deseru', NULL, NULL, '$2y$10$l23wikwfJOcAigmrBcMXkuCT1/bivANv0IFnrF575l/qcg5fFtJva', NULL, '2023-10-28 15:36:03', '2023-10-28 15:36:03'),
(13, 'Linda Gilmore', 'byna@mailinator.com', 'normal', NULL, 'Soluta aut non ad po', 'Aut consequatur omn', NULL, NULL, '$2y$10$NAAioiutkY47jlysZXVxJ..J4se.VDaBPa2SKL8nJMGGBHhEoFJ2i', NULL, '2023-10-28 15:36:22', '2023-10-28 15:36:22'),
(14, 'Rebecca Castaneda', 'zarymawi@mailinator.com', 'admin', NULL, 'Vel magnam est in v', 'Ea nisi eos nihil qu', NULL, NULL, '$2y$10$Nnh61pHrk6EXWT0oAvc0ZeZhWKpnDfuhrJZvF7NMGUdZROruaiZ.y', NULL, '2023-10-28 15:36:53', '2023-10-28 15:36:53'),
(16, 'Cruz Cochran', 'wezoxizod@mailinator.com', 'admin', NULL, 'Et dignissimos esse', 'Aut aspernatur fugia', NULL, NULL, '$2y$10$.rRfPlwunyw5cTtA6pcJleVEIu8W/IWV2LQMyQ/HoUkRmJqFhCYHa', NULL, '2023-10-28 15:46:50', '2023-10-28 15:46:50'),
(17, 'Mohammad Duncan', 'bopakizuc@mailinator.com', 'normal', NULL, 'Ut ut laboriosam la', 'Et mollitia doloribu', NULL, NULL, '$2y$10$GE3ktsErQ8QR/S8bjXl0YOhG91T2vExlxIFYMlLioNuRYmpJFmv0.', NULL, '2023-10-28 15:49:09', '2023-10-28 15:49:09'),
(18, 'Herman Chandler', 'pegyxyd@mailinator.com', 'supperAdmin', NULL, 'Molestias architecto', 'Quidem voluptas volu', NULL, NULL, '$2y$10$alVMAF4zeYIu1bNZtihABeqw4iH7NKIue3.hVsylRhhe7sHfLWiGq', NULL, '2023-10-28 15:54:02', '2023-10-28 15:54:02'),
(19, 'Tyler Forbes', 'wifegewoqu@mailinator.com', 'supperAdmin', NULL, 'Magni fuga Autem au', 'Adipisicing non ut u', NULL, NULL, '$2y$10$LQ1tjTO5BBFLF4ztJRApT.CEOuOFUz9tOLRE7DIWWdc3b19y.X89q', NULL, '2023-10-29 18:08:15', '2023-10-29 18:08:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `fingerprints`
--
ALTER TABLE `fingerprints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fingerprints`
--
ALTER TABLE `fingerprints`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
