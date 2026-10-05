-- ============================================================
-- SMARTFACTORY - INDEX OPTIMIZATION
-- Fat Covering Index -> Lean Index
-- ============================================================

-- ============================================================
-- 1. TẠO DATABASE
-- ============================================================
CREATE DATABASE IF NOT EXISTS smartfactory_db;

USE smartfactory_db;



-- ============================================================
-- 2. TẠO BẢNG SensorLogs
-- ============================================================

CREATE TABLE IF NOT EXISTS SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
);


-- ============================================================
-- 3. TẠO FAT COVERING INDEX
-- ============================================================

-- Index cũ bao phủ cả các cột được SELECT
CREATE INDEX idx_fat_covering
ON SensorLogs(
    sensor_id,
    recorded_at,
    temperature,
    humidity,
    status
);


-- ============================================================
-- 4. KIỂM TRA STORAGE TRƯỚC KHI TỐI ƯU
-- ============================================================

SHOW TABLE STATUS LIKE 'SensorLogs';


SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db'
  AND TABLE_NAME = 'SensorLogs';


-- ============================================================
-- 5. KIỂM TRA INDEX HIỆN TẠI
-- ============================================================

SHOW INDEX FROM SensorLogs;


-- ============================================================
-- 6. EXPLAIN TRƯỚC KHI TỐI ƯU
-- ============================================================

EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20';


-- ============================================================
-- 7. XÓA FAT COVERING INDEX
-- ============================================================

ALTER TABLE SensorLogs
DROP INDEX idx_fat_covering;


-- ============================================================
-- 8. TẠO LEAN INDEX
-- ============================================================

CREATE INDEX idx_lean_search
ON SensorLogs(sensor_id, recorded_at);


-- ============================================================
-- 9. KIỂM TRA INDEX SAU KHI TỐI ƯU
-- ============================================================

SHOW INDEX FROM SensorLogs;


-- ============================================================
-- 10. KIỂM TRA STORAGE SAU KHI TỐI ƯU
-- ============================================================

SHOW TABLE STATUS LIKE 'SensorLogs';


SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db'
  AND TABLE_NAME = 'SensorLogs';


-- ============================================================
-- 11. EXPLAIN SAU KHI TỐI ƯU
-- ============================================================

EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20';


-- ============================================================
-- KẾT QUẢ MONG MUỐN
-- ============================================================
--
-- Index cũ:
-- idx_fat_covering
-- (sensor_id, recorded_at, temperature, humidity, status)
--
-- Index mới:
-- idx_lean_search
-- (sensor_id, recorded_at)
--
-- Lean Index vẫn hỗ trợ điều kiện WHERE,
-- nhưng không còn bao phủ temperature, humidity, status.
--
-- Vì vậy EXPLAIN sau tối ưu thường không còn:
-- Using index
--
-- và MySQL phải lookup dữ liệu từ bảng chính.
-- ============================================================