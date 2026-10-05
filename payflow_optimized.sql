-- =========================================================
-- PAYFLOW - OPTIMIZATION WITH EXPLAIN AND INDEX
-- MySQL
-- =========================================================

-- =========================================================
-- 1. CREATE DATABASE
-- =========================================================

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;


-- =========================================================
-- 2. CREATE TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);


-- =========================================================
-- 3. TRUY VẤN CŨ - NON-SARGABLE
-- YEAR() VÀ MONTH() BỌC LÊN CỘT created_at
-- =========================================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;


-- =========================================================
-- 4. TẠO COMPOSITE INDEX
-- =========================================================

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);


-- =========================================================
-- 5. TRUY VẤN MỚI - SARGABLE
-- Không sử dụng YEAR() / MONTH()
-- =========================================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';


-- =========================================================
-- 6. CHẠY TRUY VẤN THỰC TẾ SAU KHI TỐI ƯU
-- =========================================================

SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';


-- =========================================================
-- 7. KIỂM TRA INDEX
-- =========================================================

SHOW INDEX FROM Transactions;