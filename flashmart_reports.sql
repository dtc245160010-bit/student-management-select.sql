-- =========================================
-- FLASHMART - JOIN PRACTICE
-- SQL Server / SSMS
-- =========================================

-- =========================================
-- 1. CREATE DATABASE
-- =========================================

IF DB_ID('flashmart_db') IS NULL
BEGIN
    CREATE DATABASE flashmart_db;
END
GO

USE flashmart_db;
GO


-- =========================================
-- 2. CREATE TABLES
-- =========================================

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);
GO

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);
GO

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT
);
GO


-- =========================================
-- 3. INSERT SAMPLE DATA
-- =========================================

INSERT INTO Customers (customer_id, name)
VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');
GO

INSERT INTO Products (product_id, product_name)
VALUES
(101, 'Laptop'),
(102, 'Mouse'),
(103, 'Keyboard');
GO

INSERT INTO Orders (order_id, customer_id, product_id)
VALUES
(1001, 1, 101),
(1002, 1, 102),
(1003, 2, 101);
GO


-- =========================================
-- 4. REPORT 1 - MARKETING
-- Danh sach tat ca khach hang va so luong don hang
-- LEFT JOIN de giu lai ca khach hang chua mua hang
-- COUNT(o.order_id) de khach hang chua co don = 0
-- =========================================

SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name;
GO


-- =========================================
-- 5. REPORT 2 - WAREHOUSE
-- Danh sach san pham chua tung duoc ban
-- LEFT JOIN + WHERE o.order_id IS NULL = Anti-Join
-- =========================================

SELECT
    p.product_id,
    p.product_name
FROM Products p
LEFT JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
GO


-- =========================================
-- 6. OPTIONAL: KIEM TRA DU LIEU
-- =========================================

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
GO
