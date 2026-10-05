USE classicmodels;

-- ============================================
-- BÀI THỰC HÀNH: TRUYỀN THAM SỐ VÀO STORED PROCEDURE
-- ============================================


-- ============================================
-- 1. THAM SỐ IN
-- Tìm khách hàng theo customerNumber
-- ============================================

DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi procedure
CALL getCusById(175);


-- ============================================
-- 2. THAM SỐ OUT
-- Đếm số lượng khách hàng theo thành phố
-- ============================================

DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi procedure
CALL GetCustomersCountByCity('Lyon', @total);

-- Xem kết quả OUT
SELECT @total AS total_customers;


-- ============================================
-- 3. THAM SỐ INOUT
-- Tăng giá trị counter
-- ============================================

DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Khởi tạo giá trị ban đầu
SET @counter = 1;

-- 1 + 1 = 2
CALL SetCounter(@counter, 1);

-- 2 + 1 = 3
CALL SetCounter(@counter, 1);

-- 3 + 5 = 8
CALL SetCounter(@counter, 5);

-- Xem kết quả
SELECT @counter AS counter;