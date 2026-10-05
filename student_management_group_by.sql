USE QuanLySinhVien;
GO

-- =============================================
-- BÀI THỰC HÀNH: SỬ DỤNG CÁC HÀM THÔNG DỤNG
-- VÀ GROUP BY
-- =============================================

-- Câu 1: Hiển thị số lượng sinh viên ở từng nơi
SELECT 
    Address,
    COUNT(StudentID) AS [Số lượng học viên]
FROM Student
GROUP BY Address;
GO


-- Câu 2: Tính điểm trung bình các môn học của mỗi học viên
SELECT 
    S.StudentID,
    S.StudentName,
    AVG(M.Mark) AS [Điểm trung bình]
FROM Student AS S
JOIN Mark AS M 
    ON S.StudentID = M.StudentID
GROUP BY S.StudentID, S.StudentName;
GO


-- Câu 3: Hiển thị học viên có điểm trung bình lớn hơn 15
SELECT 
    S.StudentID,
    S.StudentName,
    AVG(M.Mark) AS [Điểm trung bình]
FROM Student AS S
JOIN Mark AS M 
    ON S.StudentID = M.StudentID
GROUP BY S.StudentID, S.StudentName
HAVING AVG(M.Mark) > 15;
GO


-- Câu 4: Hiển thị học viên có điểm trung bình lớn nhất
WITH DiemTrungBinh AS
(
    SELECT 
        S.StudentID,
        S.StudentName,
        AVG(M.Mark) AS DiemTB
    FROM Student AS S
    JOIN Mark AS M 
        ON S.StudentID = M.StudentID
    GROUP BY S.StudentID, S.StudentName
)
SELECT 
    StudentID,
    StudentName,
    DiemTB AS [Điểm trung bình]
FROM DiemTrungBinh
WHERE DiemTB = (SELECT MAX(DiemTB) FROM DiemTrungBinh);
GO