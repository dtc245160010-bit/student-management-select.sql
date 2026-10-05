-- ============================================================
-- BÀI TẬP: VIEW, INDEX, STORED PROCEDURE
-- ============================================================

-- ============================================================
-- BƯỚC 1: TẠO DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS product_management;

USE product_management;

-- ============================================================
-- BƯỚC 2: TẠO BẢNG PRODUCTS
-- ============================================================

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(12,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription VARCHAR(255),
    productStatus VARCHAR(20)
);

-- ============================================================
-- CHÈN DỮ LIỆU MẪU
-- ============================================================

INSERT INTO Products
(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
('P001', 'Laptop Dell', 15000000, 10, 'Laptop Dell Inspiron', 'Available'),
('P002', 'Laptop HP', 14000000, 15, 'Laptop HP Pavilion', 'Available'),
('P003', 'Mouse Logitech', 500000, 50, 'Chuột không dây Logitech', 'Available'),
('P004', 'Keyboard Logitech', 800000, 30, 'Bàn phím Logitech', 'Available'),
('P005', 'Monitor Samsung', 5000000, 20, 'Màn hình Samsung 24 inch', 'Available'),
('P006', 'Headphone Sony', 2000000, 25, 'Tai nghe Sony', 'Available'),
('P007', 'USB Kingston', 300000, 100, 'USB Kingston 64GB', 'Available'),
('P008', 'Webcam Logitech', 1200000, 18, 'Webcam Logitech Full HD', 'Available');

-- Kiểm tra dữ liệu
SELECT * FROM Products;


-- ============================================================
-- BƯỚC 3: INDEX
-- ============================================================

-- ------------------------------------------------------------
-- 3.1. UNIQUE INDEX trên productCode
-- ------------------------------------------------------------

CREATE UNIQUE INDEX idx_productCode
ON Products(productCode);

-- Kiểm tra
SHOW INDEX FROM Products;


-- ------------------------------------------------------------
-- 3.2. COMPOSITE INDEX trên productName + productPrice
-- ------------------------------------------------------------

CREATE INDEX idx_productName_price
ON Products(productName, productPrice);

-- Kiểm tra
SHOW INDEX FROM Products;


-- ------------------------------------------------------------
-- 3.3. EXPLAIN trước khi tạo index
-- ------------------------------------------------------------
-- Nếu muốn chứng minh rõ trước/sau, hãy chạy câu này
-- trước phần CREATE INDEX ở trên.

EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';


-- ------------------------------------------------------------
-- 3.4. EXPLAIN sau khi tạo index
-- ------------------------------------------------------------

EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';


-- Kiểm tra Composite Index
EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
AND productPrice = 15000000;


-- ============================================================
-- BƯỚC 4: VIEW
-- ============================================================

-- Xóa view cũ nếu có
DROP VIEW IF EXISTS product_view;

-- ------------------------------------------------------------
-- 4.1. Tạo VIEW
-- ------------------------------------------------------------

CREATE VIEW product_view AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products;

-- Xem dữ liệu View
SELECT * FROM product_view;


-- ------------------------------------------------------------
-- 4.2. Sửa VIEW
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW product_view AS
SELECT
    productCode,
    productName,
    productPrice,
    productAmount,
    productStatus
FROM Products
WHERE productStatus = 'Available';

-- Kiểm tra View sau khi sửa
SELECT * FROM product_view;


-- Xem cấu trúc View
SHOW CREATE VIEW product_view;


-- ------------------------------------------------------------
-- 4.3. Xóa VIEW
-- ------------------------------------------------------------

-- Thực hiện ở cuối bài
DROP VIEW IF EXISTS product_view;


-- ============================================================
-- BƯỚC 5: STORED PROCEDURE
-- ============================================================

-- ------------------------------------------------------------
-- 5.1. Procedure lấy tất cả sản phẩm
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT *
    FROM Products;
END //

DELIMITER ;

-- Gọi Procedure
CALL GetAllProducts();


-- ------------------------------------------------------------
-- 5.2. Procedure thêm sản phẩm
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS AddProduct;

DELIMITER //

CREATE PROCEDURE AddProduct(
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(12,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(20)
)
BEGIN
    INSERT INTO Products
    (
        productCode,
        productName,
        productPrice,
        productAmount,
        productDescription,
        productStatus
    )
    VALUES
    (
        p_productCode,
        p_productName,
        p_productPrice,
        p_productAmount,
        p_productDescription,
        p_productStatus
    );
END //

DELIMITER ;

-- Test thêm sản phẩm
CALL AddProduct(
    'P009',
    'Tablet Samsung',
    7000000,
    12,
    'Tablet Samsung Galaxy',
    'Available'
);

SELECT * FROM Products;


-- ------------------------------------------------------------
-- 5.3. Procedure sửa sản phẩm theo ID
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS UpdateProduct;

DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN p_id INT,
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(12,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(20)
)
BEGIN
    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_id;
END //

DELIMITER ;

-- Test sửa sản phẩm ID = 1
CALL UpdateProduct(
    1,
    'P001',
    'Laptop Dell Updated',
    16000000,
    20,
    'Laptop Dell Inspiron Updated',
    'Available'
);

SELECT * FROM Products
WHERE Id = 1;


-- ------------------------------------------------------------
-- 5.4. Procedure xóa sản phẩm theo ID
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS DeleteProduct;

DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN p_id INT
)
BEGIN
    DELETE FROM Products
    WHERE Id = p_id;
END //

DELIMITER ;

-- Test xóa sản phẩm ID = 9
CALL DeleteProduct(9);

SELECT * FROM Products;


-- ============================================================
-- KIỂM TRA CÁC STORED PROCEDURE
-- ============================================================

SHOW PROCEDURE STATUS
WHERE Db = 'product_management';

-- Kiểm tra bảng cuối cùng
SELECT * FROM Products;