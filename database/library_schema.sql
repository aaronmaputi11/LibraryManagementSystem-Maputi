-- Library Management System Database Schema

CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- Members Table
CREATE TABLE IF NOT EXISTS members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  address VARCHAR(255),
  membership_date DATE NOT NULL,
  status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Books Table
CREATE TABLE IF NOT EXISTS books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  isbn VARCHAR(20) UNIQUE NOT NULL,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(150) NOT NULL,
  publisher VARCHAR(150),
  publication_year INT,
  category VARCHAR(100),
  description TEXT,
  total_copies INT NOT NULL DEFAULT 1,
  available_copies INT NOT NULL DEFAULT 1,
  location_shelf VARCHAR(50),
  status ENUM('available', 'unavailable', 'damaged') DEFAULT 'available',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Borrow Logs Table
CREATE TABLE IF NOT EXISTS borrow_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  borrow_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE,
  status ENUM('borrowed', 'returned', 'overdue') DEFAULT 'borrowed',
  fine_amount DECIMAL(10, 2) DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
  INDEX idx_member (member_id),
  INDEX idx_book (book_id),
  INDEX idx_status (status)
);

-- Create indexes for better query performance
CREATE INDEX idx_book_title ON books(title);
CREATE INDEX idx_book_author ON books(author);
CREATE INDEX idx_book_category ON books(category);
CREATE INDEX idx_member_email ON members(email);
CREATE INDEX idx_borrow_member ON borrow_logs(member_id);
