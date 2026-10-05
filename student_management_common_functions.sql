USE QuanLySinhVien;
GO

-- =============================================
-- BÀI TẬP: LUYỆN TẬP CÁC HÀM THÔNG DỤNG TRONG SQL
-- =============================================

-- Câu 1:
-- Hiển thị tất cả thông tin môn học có Credit lớn nhất

SELECT *
FROM Subject
WHERE Credit = (
    SELECT MAX(Credit)
    FROM Subject
);
GO


-- Câu 2:
-- Hiển thị các thông tin môn học có điểm thi lớn nhất

SELECT 
    S.SubjectID,
    S.SubName,
    S.Credit,
    M.Mark
FROM Subject AS S
JOIN Mark AS M 
    ON S.SubjectID = M.SubID
WHERE M.Mark = (
    SELECT MAX(Mark)
    FROM Mark
);
GO


-- Câu 3:
-- Hiển thị thông tin sinh viên và điểm trung bình
-- Xếp theo điểm trung bình giảm dần

SELECT 
    S.StudentID,
    S.StudentName,
    AVG(M.Mark) AS [Điểm trung bình]
FROM Student AS S
JOIN Mark AS M 
    ON S.StudentID = M.StudentID
GROUP BY S.StudentID, S.StudentName
ORDER BY AVG(M.Mark) DESC;
GO