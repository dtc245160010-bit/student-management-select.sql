-- ============================================================
-- QUICKFEED - INDEX OPTIMIZATION
-- ============================================================

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- ============================================================
-- 1. TẠO BẢNG
-- ============================================================

CREATE TABLE IF NOT EXISTS Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10),
    is_visible BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. TẠO LEGACY INDEX
-- Chỉ tạo nếu index chưa tồn tại
-- ============================================================

CREATE INDEX idx_user_id ON Posts(user_id);
CREATE INDEX idx_content ON Posts(content(255));
CREATE INDEX idx_post_type ON Posts(post_type);
CREATE INDEX idx_is_visible ON Posts(is_visible);
CREATE INDEX idx_created_at ON Posts(created_at);

-- ============================================================
-- 3. KIỂM TRA INDEX TRƯỚC KHI TỐI ƯU
-- ============================================================

SHOW INDEX FROM Posts;

SHOW TABLE STATUS LIKE 'Posts';

-- ============================================================
-- 4. KIỂM TRA STORAGE TRƯỚC KHI TỐI ƯU
-- Đơn vị: MB
-- ============================================================

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- ============================================================
-- 5. XÓA 3 INDEX KHÔNG CẦN THIẾT
-- ============================================================

ALTER TABLE Posts DROP INDEX idx_content;

ALTER TABLE Posts DROP INDEX idx_post_type;

ALTER TABLE Posts DROP INDEX idx_is_visible;

-- ============================================================
-- 6. KIỂM TRA INDEX SAU KHI TỐI ƯU
-- ============================================================

SHOW INDEX FROM Posts;

SHOW TABLE STATUS LIKE 'Posts';

-- ============================================================
-- 7. KIỂM TRA STORAGE SAU KHI TỐI ƯU
-- ============================================================

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- ============================================================
-- 8. INDEX CÒN LẠI
-- ============================================================
-- Giữ:
-- idx_user_id
-- idx_created_at
--
-- PRIMARY KEY cũng được giữ lại tự động.