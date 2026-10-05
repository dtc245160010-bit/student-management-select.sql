-- =========================================================
-- BÀI TẬP: THAO TÁC VỚI CSDL QUẢN LÝ BÁN HÀNG
-- SQL Server / SSMS
-- Database: QuanLyBanHang
-- =========================================================

USE QuanLyBanHang;
GO


-- =========================================================
-- 1. THÊM DỮ LIỆU VÀO BẢNG CUSTOMER
-- =========================================================

INSERT INTO Customer (cID, Name, cAge)
VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);
GO


-- =========================================================
-- 2. THÊM DỮ LIỆU VÀO BẢNG ORDER
-- =========================================================

INSERT INTO [Order] (oID, cID, oDate, oTotalPrice)
VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);
GO


-- =========================================================
-- 3. THÊM DỮ LIỆU VÀO BẢNG PRODUCT
-- =========================================================

INSERT INTO Product (pID, pName, pPrice)
VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);
GO


-- =========================================================
-- 4. THÊM DỮ LIỆU VÀO BẢNG ORDERDETAIL
-- =========================================================

INSERT INTO OrderDetail (oID, pID, odQTY)
VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);
GO


-- =========================================================
-- 5. KIỂM TRA DỮ LIỆU ĐÃ THÊM
-- =========================================================

SELECT * FROM Customer;
SELECT * FROM [Order];
SELECT * FROM Product;
SELECT * FROM OrderDetail;
GO


-- =========================================================
-- CÂU 1
-- Hiển thị oID, oDate, oPrice của tất cả hóa đơn
-- Trong CSDL cột tổng tiền có tên oTotalPrice
-- =========================================================

SELECT
    oID,
    oDate,
    oTotalPrice AS oPrice
FROM [Order];
GO


-- =========================================================
-- CÂU 2
-- Hiển thị danh sách khách hàng đã mua hàng
-- và sản phẩm được mua bởi các khách
-- =========================================================

SELECT
    C.cID,
    C.Name AS CustomerName,
    P.pID,
    P.pName AS ProductName
FROM Customer AS C
JOIN [Order] AS O
    ON C.cID = O.cID
JOIN OrderDetail AS OD
    ON O.oID = OD.oID
JOIN Product AS P
    ON OD.pID = P.pID;
GO


-- =========================================================
-- CÂU 3
-- Hiển thị tên khách hàng không mua bất kỳ sản phẩm nào
-- =========================================================

SELECT
    C.Name AS CustomerName
FROM Customer AS C
LEFT JOIN [Order] AS O
    ON C.cID = O.cID
WHERE O.oID IS NULL;
GO


-- =========================================================
-- CÂU 4
-- Hiển thị mã hóa đơn, ngày bán và giá tiền từng hóa đơn
--
-- Giá từng sản phẩm = odQTY * pPrice
-- Giá hóa đơn = SUM(odQTY * pPrice)
-- =========================================================

SELECT
    O.oID,
    O.oDate,
    SUM(OD.odQTY * P.pPrice) AS TotalPrice
FROM [Order] AS O
JOIN OrderDetail AS OD
    ON O.oID = OD.oID
JOIN Product AS P
    ON OD.pID = P.pID
GROUP BY
    O.oID,
    O.oDate
ORDER BY
    O.oID;
GO