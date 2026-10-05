-- ============================================
-- THỰC HÀNH TRIGGER TRONG MYSQL
-- ============================================

-- Bước 1: Tạo CSDL
CREATE DATABASE IF NOT EXISTS company;

USE company;

-- Xóa bảng cũ nếu đã tồn tại để có thể chạy lại
DROP TABLE IF EXISTS employees;

-- Tạo bảng employees
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- ============================================
-- Bước 2: Tạo Trigger
-- ============================================

DROP TRIGGER IF EXISTS update_department;

DELIMITER //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- ============================================
-- Bước 3: Demo Trigger
-- ============================================

INSERT INTO employees (name, department, salary)
VALUES
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);

-- Xem kết quả
SELECT * FROM employees;

-- ============================================
-- Kiểm tra thêm
-- ============================================

-- Nhân viên Management
SELECT *
FROM employees
WHERE department = 'Management';

-- Nhân viên Sales
SELECT *
FROM employees
WHERE department = 'Sales';

-- Nhân viên Support
SELECT *
FROM employees
WHERE department = 'Support';

-- Xem thông tin Trigger
SHOW TRIGGERS FROM company;