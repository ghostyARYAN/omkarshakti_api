
-- Database schema for Omkar Shakti Kendra Astrology Website

CREATE DATABASE IF NOT EXISTS astrology_db;
USE astrology_db;

-- Admin users table
CREATE TABLE admin_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    token VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Services table
CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    detailed_description TEXT,
    icon VARCHAR(255),
    image VARCHAR(255),
    price DECIMAL(10,2),
    duration VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Benefits table (linked to services)
CREATE TABLE benefits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    icon VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE
);

-- Blogs table
CREATE TABLE blogs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    featured_image VARCHAR(255),
    author VARCHAR(255) DEFAULT 'Pandit Kirtan Prasad Suparkar',
    excerpt TEXT,
    content TEXT,
    is_featured BOOLEAN DEFAULT FALSE,
    is_published BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Comments table
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    blog_id INT NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255),
    comment TEXT NOT NULL,
    is_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (blog_id) REFERENCES blogs(id) ON DELETE CASCADE
);

-- Appointment slots table
CREATE TABLE appointment_slots (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    time_slot VARCHAR(50) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_slot (date, time_slot)
);

-- Appointments table
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    time_slot VARCHAR(50) NOT NULL,
    concerns TEXT,
    status ENUM('pending', 'confirmed', 'completed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (service_id) REFERENCES services(id)
);

-- Contacts table
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    subject VARCHAR(255),
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user (password: admin123)
INSERT INTO admin_users (email, password) VALUES 
('admin@omkarshaktikendra.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insert sample services
INSERT INTO services (title, slug, description, detailed_description, icon, price, duration) VALUES
('Jyotish Darshan', 'jyotish-darshan', 'Complete astrological consultation and birth chart analysis', 'Detailed analysis of your birth chart, planetary positions, and their effects on your life. Get insights into your personality, career, relationships, and future predictions.', '/services/jyotish-darshan-service.svg', 1500.00, '60 minutes'),
('Vastu Paramarsh', 'vastu-paramarsh', 'Vastu consultation for home and office', 'Professional Vastu consultation to harmonize your living and working spaces according to ancient Indian architectural principles.', '/services/vastu-paramarsh-service.svg', 2500.00, '90 minutes'),
('Karmakand Sampadan', 'karmakand-sampadan', 'Religious rituals and ceremonies', 'Traditional Hindu rituals and ceremonies performed with proper vedic procedures for various occasions and purposes.', '/services/karmakand-sampadan-service.svg', 3000.00, '120 minutes'),
('Tantra Mantra Yantra', 'tantra-mantra-yantra', 'Spiritual practices and remedies', 'Ancient tantric practices, powerful mantras, and sacred yantras for spiritual growth and problem resolution.', '/services/tantra-mantra-yantra-service.svg', 2000.00, '75 minutes'),
('Spiritual Healing', 'spiritual-healing', 'Energy healing and spiritual cleansing', 'Holistic healing approach using spiritual energy to restore balance and harmony in your life.', '/services/spiritual-healing-service.svg', 1800.00, '60 minutes'),
('Gemstone Therapy', 'gemstone-therapy', 'Precious stone recommendations and therapy', 'Personalized gemstone recommendations based on your birth chart for enhancing positive planetary influences.', '/services/gemstone-therapy-service.svg', 1200.00, '45 minutes'),
('Deeksha Dharma', 'deeksha-dharma', 'Spiritual initiation and guidance', 'Sacred initiation into spiritual practices and ongoing guidance for your spiritual journey.', '/services/deeksha-dharma-service.svg', 5000.00, '180 minutes'),
('Satsang', 'satsang', 'Spiritual discourse and group meditation', 'Regular spiritual gatherings with discourse, meditation, and community prayers.', '/services/satsang-service.svg', 500.00, '90 minutes'),
('Kathavachan', 'kathavachan', 'Religious storytelling and teachings', 'Traditional storytelling sessions with religious and moral teachings from ancient scriptures.', '/services/kathavachan-service.svg', 800.00, '120 minutes'),
('Ayurveda & Life Advice', 'ayurveda-and-life-advice', 'Holistic health and lifestyle guidance', 'Ayurvedic consultation combined with practical life advice for overall well-being and success.', '/services/ayurveda-and-life-advice-service.svg', 1500.00, '75 minutes');

-- Insert sample benefits
INSERT INTO benefits (service_id, title, description, icon) VALUES
(1, 'Career Guidance', 'Get clear direction for your professional life', '🎯'),
(1, 'Relationship Insights', 'Understand compatibility and relationship dynamics', '💕'),
(1, 'Health Predictions', 'Foresee health issues and preventive measures', '🏥'),
(2, 'Positive Energy Flow', 'Enhance positive energy in your spaces', '⚡'),
(2, 'Prosperity Enhancement', 'Attract wealth and abundance', '💰'),
(2, 'Health & Harmony', 'Create healthy living environment', '🌿'),
(3, 'Spiritual Purification', 'Cleanse negative energies', '✨'),
(3, 'Divine Blessings', 'Invoke divine grace and protection', '🙏'),
(3, 'Mental Peace', 'Achieve inner calm and tranquility', '🕊️');

-- Insert sample blogs
INSERT INTO blogs (title, slug, featured_image, excerpt, content, is_featured) VALUES
('Understanding Your Birth Chart', 'understanding-your-birth-chart', '/uploads/birth-chart-blog.jpg', 'Learn how to read and interpret your astrological birth chart for personal insights.', 'A birth chart, also known as a natal chart, is a map of the sky at the exact moment you were born. It shows the positions of the planets, sun, and moon in relation to the twelve zodiac signs and houses...', TRUE),
('The Power of Vastu in Modern Homes', 'power-of-vastu-modern-homes', '/uploads/vastu-home-blog.jpg', 'Discover how ancient Vastu principles can transform your modern living space.', 'Vastu Shastra is an ancient Indian science of architecture and design that aims to create harmony between human dwellings and nature...', TRUE),
('Gemstones and Their Astrological Significance', 'gemstones-astrological-significance', '/uploads/gemstones-blog.jpg', 'Explore the mystical world of gemstones and their connection to planetary influences.', 'For thousands of years, gemstones have been revered not just for their beauty, but for their metaphysical properties and astrological significance...', FALSE);

-- Insert sample appointment slots (next 30 days)
INSERT INTO appointment_slots (date, time_slot) VALUES
(CURDATE() + INTERVAL 1 DAY, '09:00 AM'),
(CURDATE() + INTERVAL 1 DAY, '10:30 AM'),
(CURDATE() + INTERVAL 1 DAY, '02:00 PM'),
(CURDATE() + INTERVAL 1 DAY, '03:30 PM'),
(CURDATE() + INTERVAL 1 DAY, '05:00 PM'),
(CURDATE() + INTERVAL 2 DAY, '09:00 AM'),
(CURDATE() + INTERVAL 2 DAY, '10:30 AM'),
(CURDATE() + INTERVAL 2 DAY, '02:00 PM'),
(CURDATE() + INTERVAL 2 DAY, '03:30 PM'),
(CURDATE() + INTERVAL 2 DAY, '05:00 PM');
