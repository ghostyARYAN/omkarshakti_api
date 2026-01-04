-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 04, 2026 at 06:24 AM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u298766445_omkarshaktidb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `email`, `password`, `token`, `created_at`, `updated_at`) VALUES
(1, 'aacharya@omkarshakti.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'a15ac8176ddcf5fb60c26c01865215f4c164b5e331aabf1386e504888398acd6', '2025-06-11 23:49:54', '2026-01-04 06:22:29');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `time_slot` varchar(50) NOT NULL,
  `concerns` text DEFAULT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `benefits`
--

CREATE TABLE `benefits` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `benefits`
--

INSERT INTO `benefits` (`id`, `service_id`, `title`, `description`, `icon`, `created_at`) VALUES
(1, 1, 'Career Guidance', 'Get clear direction for your professional life', '?', '2025-06-11 23:49:54'),
(2, 1, 'Relationship Insights', 'Understand compatibility and relationship dynamics', '?', '2025-06-11 23:49:54'),
(3, 1, 'Health Predictions', 'Foresee health issues and preventive measures', '?', '2025-06-11 23:49:54'),
(4, 2, 'Positive Energy Flow', 'Enhance positive energy in your spaces', '?', '2025-06-11 23:49:54'),
(5, 2, 'Prosperity Enhancement', 'Attract wealth and abundance', '?', '2025-06-11 23:49:54'),
(6, 2, 'Health & Harmony', 'Create healthy living environment', '?', '2025-06-11 23:49:54'),
(7, 3, 'Spiritual Purification', 'Cleanse negative energies', '?', '2025-06-11 23:49:54'),
(8, 3, 'Divine Blessings', 'Invoke divine grace and protection', '?', '2025-06-11 23:49:54'),
(9, 3, 'Mental Peace', 'Achieve inner calm and tranquility', '??', '2025-06-11 23:49:54');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT 'Pandit Kirtan Prasad Suparkar',
  `excerpt` mediumtext DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_published` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `slug`, `featured_image`, `author`, `excerpt`, `content`, `is_featured`, `is_published`, `created_at`, `updated_at`) VALUES
(27, 'Understanding Your Zodiac Sign: Meaning, Traits & Life Purpose', 'understanding-your-zodiac-sign-meaning-traits-life-purpose', 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee', 'Admin', 'Learn the meaning, traits, strengths, weaknesses, and life purpose of your zodiac sign.', 'Astrology has been practiced for thousands of years to understand human personality and destiny. Your zodiac sign is determined by the position of the Sun at the time of your birth and reveals deep insights into your nature, strengths, weaknesses, and life path.\n\nThere are twelve zodiac signs, each ruled by a planet and connected to an element—Fire, Earth, Air, or Water. Fire signs are passionate and energetic, Earth signs are practical and grounded, Air signs are intellectual and communicative, while Water signs are emotional and intuitive.\n\nYour zodiac sign influences your career choices, relationships, emotional reactions, and decision-making style. Understanding your sign helps you align your actions with your natural tendencies, leading to self-acceptance and personal growth.\n\nBy studying zodiac astrology, you gain clarity about your life purpose and learn how to use your strengths while working on your weaknesses.', 1, 1, '2025-12-20 14:37:13', '2025-12-21 14:39:44'),
(28, 'How Planets Influence Your Life According to Astrology', 'how-planets-influence-your-life-astrology', 'https://images.unsplash.com/photo-1519681393784-d120267933ba', 'Admin', 'Discover how planetary positions shape your emotions, career, relationships, and destiny.', 'In astrology, planets are powerful cosmic forces that govern different aspects of human life. Each planet represents a specific energy that influences thoughts, emotions, actions, and experiences.\n\nThe Sun represents identity and ego, the Moon governs emotions and intuition, Mercury controls communication, Venus rules love and beauty, Mars represents energy and ambition, Jupiter signifies growth and luck, and Saturn governs discipline and karma.\n\nThe placement of these planets in your birth chart determines your career growth, financial stability, relationships, and health patterns. Daily planetary transits continuously affect moods and opportunities, which is why horoscopes change every day.\n\nUnderstanding planetary influence helps you work with cosmic energies rather than against them, creating balance and clarity in life.', 0, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(29, 'Daily Horoscope: Why Reading Horoscope Matters', 'daily-horoscope-why-reading-horoscope-matters', 'https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d', 'Admin', 'Understand how daily horoscopes guide decisions, emotions, and opportunities.', 'Daily horoscopes provide guidance based on current planetary movements and lunar positions. They help individuals plan their day with awareness and emotional preparedness.\n\nAstrologers analyze planetary transits, zodiac sign alignments, and Moon phases to create daily horoscope predictions. These predictions help people make informed decisions related to work, relationships, and health.\n\nHoroscopes do not dictate fate; instead, they show probabilities and trends. Free will always plays the most important role in shaping outcomes.\n\nReading your daily horoscope helps reduce anxiety, increase awareness, and stay aligned with cosmic rhythms throughout the day.', 0, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(30, 'Birth Chart Astrology: Complete Guide for Beginners', 'birth-chart-astrology-complete-guide', 'https://images.unsplash.com/photo-1501785888041-af3ef285b470', 'Admin', 'A beginner-friendly guide explaining birth charts, planets, houses, and aspects.', 'A birth chart, also known as a natal chart, is a snapshot of the sky at the exact moment of your birth. It includes zodiac signs, planetary positions, twelve houses, and planetary aspects.\n\nBirth charts reveal life purpose, career potential, emotional patterns, relationship tendencies, and karmic lessons. Unlike general horoscopes, birth chart analysis provides highly personalized insights.\n\nAstrologers use birth charts for career planning, marriage matching, spiritual growth, and long-term predictions.\n\nUnderstanding your birth chart allows you to make conscious life choices aligned with your natural strengths and challenges.', 1, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(31, 'Astrology and Career: Choosing the Right Profession', 'astrology-and-career-choosing-the-right-profession', 'https://images.unsplash.com/photo-1494526585095-c41746248156', 'Admin', 'Learn how astrology helps in choosing a career aligned with your strengths.', 'Astrology offers valuable guidance in career selection by analyzing planets related to ambition, intelligence, discipline, and success.\n\nThe Sun indicates leadership roles, Mars favors technical and defense careers, Mercury supports business and IT, while Saturn suits government and administrative roles.\n\nEach zodiac sign has natural inclinations that align with specific professions. Career astrology helps reduce confusion, improve job satisfaction, and ensure long-term stability.\n\nChoosing a career aligned with astrology leads to success, confidence, and mental peace.', 0, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(32, 'Love Compatibility in Astrology: Signs That Match Best', 'love-compatibility-in-astrology', 'https://images.unsplash.com/photo-1517841905240-472988babdf9', 'Admin', 'Understand love compatibility using zodiac signs, planets, and moon signs.', 'Astrology plays a crucial role in understanding love and relationship compatibility. It goes beyond sun signs and examines Moon signs, Venus and Mars alignment, and the seventh house.\n\nFire and Air signs often share energetic compatibility, while Earth and Water signs create emotional stability.\n\nAstrological matching helps predict emotional bonding, communication quality, and relationship longevity.\n\nLove astrology provides clarity, helping couples understand differences and build stronger emotional connections.', 1, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(33, 'Retrograde Planets Explained: Meaning, Effects & Remedies', 'retrograde-planets-explained', 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa', 'Admin', 'Understand retrograde planets, their effects, and how to handle them.', 'Retrograde motion occurs when a planet appears to move backward in the sky. These periods bring reflection, delays, and internal transformation.\n\nMercury retrograde affects communication, Saturn retrograde brings karmic lessons, and Venus retrograde impacts relationships.\n\nRetrograde periods are ideal for reassessment rather than new beginnings. Patience and self-reflection are key.\n\nRetrogrades are not negative; they are opportunities for correction, growth, and realignment.', 0, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(34, 'Moon Phases and Their Impact on Human Emotions', 'moon-phases-impact-on-human-emotions', 'https://images.unsplash.com/photo-1501785888041-af3ef285b470', 'Admin', 'Discover how moon phases influence emotions, intuition, and mental clarity.', 'The Moon governs emotions, subconscious behavior, and intuition in astrology. Different moon phases influence mood and energy levels.\n\nThe New Moon supports new beginnings, while the Full Moon heightens emotions and awareness. Waxing and waning phases affect productivity and reflection.\n\nMoon phases impact sleep, mental clarity, and emotional responses.\n\nAligning daily activities with lunar cycles helps improve emotional balance and inner harmony.', 0, 1, '2025-12-20 14:37:13', '2025-12-20 14:39:08'),
(35, 'Astrology Remedies: Simple Solutions for Daily Problems', 'astrology-remedies-for-daily-problems', 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429', 'Admin', 'Learn simple astrology remedies to balance planetary energies.', 'Astrological remedies are practices designed to balance planetary energies and reduce negative influences in life.\n\nCommon remedies include mantras, gemstones, fasting, charity, and meditation. Consistency and belief enhance their effectiveness.\n\nFrom a scientific perspective, remedies improve focus, discipline, and positive thinking.\n\nAstrology remedies offer practical tools for improving mental peace, confidence, and life quality.', 0, 1, '2025-12-20 14:37:13', '2025-12-20 14:37:13'),
(36, 'Can Astrology Predict the Future? Truth Explained', 'can-astrology-predict-the-future', 'https://plus.unsplash.com/premium_photo-1700877616950-fb49b499bea2', 'Admin', 'Explore whether astrology can truly predict future events.', 'Astrology predicts trends and possibilities rather than fixed events. It uses planetary transits, dashas, and progressions for forecasting.\n\nPrediction accuracy depends on birth time precision and astrologer expertise.\n\nAstrology provides guidance, but free will determines final outcomes.\n\nBy understanding future trends, astrology helps individuals prepare, plan, and make informed decisions.', 1, 1, '2025-12-20 14:37:13', '2025-12-20 14:41:40'),
(37, 'Good word of Day 21-12-2025', 'good-word-of-day-21-12-2025', NULL, 'Pandit Kirtan Prasad Supkar', 'Om', '✍🏼 ओंकार वाणी 🌹 🌹 \n👉आत्मा तो..\nहमेशा से जानती ही है,\nकि सही क्या है\nऔर गलत क्या है...!!!\n\nचुनौती तो..\nमन को समझाने\nकी होती है.......!!!!!!!\n🚩🚩ओंकार शक्ति 🚩🚩', 0, 1, '2025-12-21 14:44:59', '2025-12-21 14:56:07'),
(38, 'Omkarshakti Daily Post', 'daily-post-03-01-26', 'https://api.omkarshakti.com/uploads/blogmedia/IMG-20260103-WA0004_1767499231_befb9203.jpg', 'Aacharya Kirtan Prasad Supkar', 'Dainik Hindu Calendar', 'Tithi wise calendar daily post by omkarshakti', 0, 0, '2026-01-04 04:02:05', '2026-01-04 04:05:24');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `comment` mediumtext NOT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `full_name`, `email`, `phone`, `subject`, `message`, `is_read`, `created_at`) VALUES
(1, 'aryan', 'pentadstyles.in@gmail.com', '9009459302', 'ss', 'Zx', 1, '2025-06-12 00:38:37'),
(2, 'aryank', 'pentadstyles.in@gmail.com', '9009459302', 'ss', 'Zx', 1, '2025-06-12 00:38:37'),
(3, 'prakash', 'admin@omguru.com', '90945587878', 'ssadad', 'adadhadkja', 1, '2025-06-13 02:07:21'),
(4, 'prakash', 'admin@omkarshaktikendra.com', '90945587878', 'ssadad', 'hhj', 1, '2025-06-14 01:14:16'),
(5, 'Arjun Reddy', 'arjunreddy@gmail.com', '9000005789', 'Kundali Matching', 'Maharaj Ji Pranaam', 1, '2026-01-04 04:30:04');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text DEFAULT NULL,
  `url` varchar(511) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `title`, `body`, `url`, `is_read`, `created_at`) VALUES
(1, 'Welcome', 'Welcome to the admin dashboard', NULL, 1, '2025-11-11 06:13:22'),
(2, 'Welcome', 'Welcome to the admin dashboard', 'www.pentadstyles.in', 1, '2025-11-11 06:13:22'),
(3, 'New message from Arjun Reddy', 'Maharaj Ji Pranaam', '/admin/contacts.php?id=5', 0, '2026-01-04 04:30:04');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `detailed_description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `title`, `slug`, `description`, `detailed_description`, `icon`, `image`, `price`, `duration`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Jyotish Darshan', 'jyotish-darshan', 'Complete Vedic Astrological Consultation for Life Guidance Understand your destiny through precise planetary analysis and gain clarity about your life’s purpose, challenges, and opportunities.', 'Jyotish Darshan is a comprehensive Vedic astrology consultation that offers deep insight into your life through Kundali Vishleshan (?????? ????????) and planetary interpretation. Rooted in the ancient science of Jyotish Vidya, this service helps you understand how celestial energies influence your personality, relationships, career, health, and spiritual journey.\nIn Vedic astrology, an individual is not judged merely by their sun sign. Instead, the Janam Kundli (???? ??????)—your birth chart—acts as a cosmic blueprint created using your exact date, time, and place of birth. This chart reflects the precise positions of planets and constellations at the moment you were born.\nKundali Vishleshan (?????? ????????)\nYour birth chart is considered the roadmap of your life. Through detailed Kundali Vishleshan, the astrologer studies:\nThe Ascendant (????) – the rising sign that shapes your personality\n\n\nPlanetary placements and their mutual relationships\n\n\nThe twelve houses representing different life aspects\n\n\nPlanetary periods known as Dasha (???) and Antardasha (????????)\n\n\nAccording to Vedic astrology, planets do not merely indicate what will happen, but the Dasha system reveals when events are likely to unfold. The alignment of planets, stars, and houses determines your karmic patterns, strengths, challenges, and turning points in life.', '/services/jyotish-darshan-service.svg', NULL, 1500.00, '60 minutes', 1, '2025-06-11 23:49:54', '2025-12-20 15:09:40'),
(2, 'Vastu Paramarsh', 'vastu-paramarsh', 'Vastu consultation for home and office', 'Professional Vastu consultation to harmonize your living and working spaces according to ancient Indian architectural principles.', '/services/vastu-paramarsh-service.svg', NULL, 2500.00, '90 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(3, 'Karmakand Sampadan', 'karmakand-sampadan', 'Religious rituals and ceremonies', 'Traditional Hindu rituals and ceremonies performed with proper vedic procedures for various occasions and purposes.', '/services/karmakand-sampadan-service.svg', NULL, 3000.00, '120 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(4, 'Tantra Mantra Yantra', 'tantra-mantra-yantra', 'Spiritual practices and remedies', 'Ancient tantric practices, powerful mantras, and sacred yantras for spiritual growth and problem resolution.', '/services/tantra-mantra-yantra-service.svg', NULL, 2000.00, '75 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(5, 'Spiritual Healing', 'spiritual-healing', 'Energy healing and spiritual cleansing', 'Holistic healing approach using spiritual energy to restore balance and harmony in your life.', '/services/spiritual-healing-service.svg', NULL, 1800.00, '60 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(6, 'Gemstone Therapy', 'gemstone-therapy', 'Precious stone recommendations and therapy', 'Personalized gemstone recommendations based on your birth chart for enhancing positive planetary influences.', '/services/gemstone-therapy-service.svg', NULL, 1200.00, '45 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(7, 'Deeksha Dharma', 'deeksha-dharma', 'Spiritual initiation and guidance', 'Sacred initiation into spiritual practices and ongoing guidance for your spiritual journey.', '/services/deeksha-dharma-service.svg', NULL, 5000.00, '180 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(8, 'Satsang', 'satsang', 'Spiritual discourse and group meditation', 'Regular spiritual gatherings with discourse, meditation, and community prayers.', '/services/satsang-service.svg', NULL, 500.00, '90 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(9, 'Kathavachan', 'kathavachan', 'Religious storytelling and teachings', 'Traditional storytelling sessions with religious and moral teachings from ancient scriptures.', '/services/kathavachan-service.svg', NULL, 800.00, '120 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54'),
(10, 'Ayurveda & Life Advice', 'ayurveda-and-life-advice', 'Holistic health and lifestyle guidance', 'Ayurvedic consultation combined with practical life advice for overall well-being and success.', '/services/ayurveda-and-life-advice-service.svg', NULL, 1500.00, '75 minutes', 1, '2025-06-11 23:49:54', '2025-06-11 23:49:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `benefits`
--
ALTER TABLE `benefits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `benefits`
--
ALTER TABLE `benefits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Constraints for table `benefits`
--
ALTER TABLE `benefits`
  ADD CONSTRAINT `benefits_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
