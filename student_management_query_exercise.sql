-- =========================================================
-- BÀI TẬP: TRUY VẤN DỮ LIỆU VỚI CSDL QUẢN LÝ SINH VIÊN
-- Database: QuanLySinhVien
-- SQL Server / SSMS
-- =========================================================

USE QuanLySinhVien;
GO

-- =========================================================
-- CÂU 1
-- Hiển thị tất cả sinh viên có tên bắt đầu bằng ký tự 'h'
-- =========================================================

SELECT *
FROM Student
WHERE StudentName LIKE 'H%';
GO


-- =========================================================
-- CÂU 2
-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12
-- =========================================================

SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;
GO


-- =========================================================
-- CÂU 3
-- Hiển thị tất cả thông tin môn học có Credit từ 3 đến 5
-- =========================================================

SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;
GO


-- =========================================================
-- CÂU 4
-- Thay đổi ClassID của sinh viên có tên 'Hung' thành 2
-- =========================================================

UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';
GO

-- Kiểm tra kết quả câu 4
SELECT *
FROM Student
WHERE StudentName = 'Hung';
GO


-- =========================================================
-- CÂU 5
-- Hiển thị StudentName, SubName, Mark
-- Sắp xếp theo Mark giảm dần.
-- Nếu Mark trùng nhau thì sắp xếp StudentName tăng dần.
-- =========================================================

SELECT
    S.StudentName,
    Sub.SubName,
    M.Mark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
JOIN Subject AS Sub
    ON M.SubID = Sub.SubID
ORDER BY
    M.Mark DESC,
    S.StudentName ASC;
GO


-- =========================================================
-- KIỂM TRA TOÀN BỘ DỮ LIỆU SAU KHI THỰC HIỆN
-- =========================================================

SELECT * FROM Student;
GO

SELECT * FROM Class;
GO

SELECT * FROM Subject;
GO

SELECT * FROM Mark;
GO
