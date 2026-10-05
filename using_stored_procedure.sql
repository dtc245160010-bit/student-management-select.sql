USE classicmodels;

-- ============================================
-- BÀI THỰC HÀNH: STORED PROCEDURE
-- ============================================

-- Xóa procedure cũ nếu đã tồn tại
DROP PROCEDURE IF EXISTS findAllCustomers;

-- Đổi delimiter để tạo procedure
DELIMITER //

-- Tạo procedure lấy tất cả khách hàng
CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END //

-- Đưa delimiter về mặc định
DELIMITER ;


-- ============================================
-- Gọi procedure
-- ============================================

CALL findAllCustomers();


-- ============================================
-- Tạo lại procedure với điều kiện
-- Tìm khách hàng có customerNumber = 175
-- ============================================

DROP PROCEDURE IF EXISTS findAllCustomers;

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END //

DELIMITER ;


-- Gọi procedure sau khi thay đổi
CALL findAllCustomers();