USE classicmodels;

-- ============================================
-- BÀI THỰC HÀNH: CHỈ MỤC TRONG MYSQL
-- ============================================

-- Câu 1: Kiểm tra truy vấn trước khi tạo INDEX
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';


-- Câu 2: Tạo INDEX cho customerName
ALTER TABLE customers
ADD INDEX idx_customerName(customerName);


-- Câu 3: Kiểm tra lại truy vấn sau khi tạo INDEX
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';


-- Câu 4: Tạo INDEX cho contactFirstName và contactLastName
ALTER TABLE customers
ADD INDEX idx_full_name(contactFirstName, contactLastName);


-- Câu 5: Kiểm tra truy vấn sử dụng INDEX
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactFirstName = 'King';


-- Câu 6: Xóa INDEX idx_full_name
ALTER TABLE customers
DROP INDEX idx_full_name;


-- Câu 7: Kiểm tra lại danh sách INDEX của bảng customers
SHOW INDEX FROM customers;