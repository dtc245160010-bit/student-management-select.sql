USE classicmodels;

-- ============================================
-- BÀI THỰC HÀNH: VIEW TRONG MYSQL
-- ============================================

-- Xóa view cũ nếu đã tồn tại
DROP VIEW IF EXISTS customer_views;


-- ============================================
-- 1. TẠO VIEW
-- ============================================

CREATE VIEW customer_views AS
SELECT 
    customerNumber,
    customerName,
    phone
FROM customers;


-- Kiểm tra dữ liệu trong View
SELECT *
FROM customer_views;


-- ============================================
-- 2. CẬP NHẬT VIEW
-- Chỉ hiển thị khách hàng ở thành phố Nantes
-- ============================================

CREATE OR REPLACE VIEW customer_views AS
SELECT 
    customerNumber,
    customerName,
    contactFirstName,
    contactLastName,
    phone
FROM customers
WHERE city = 'Nantes';


-- Kiểm tra View sau khi cập nhật
SELECT *
FROM customer_views;


-- ============================================
-- 3. XEM CẤU TRÚC VIEW
-- ============================================

SHOW CREATE VIEW customer_views;


-- ============================================
-- 4. XÓA VIEW
-- ============================================

DROP VIEW IF EXISTS customer_views;