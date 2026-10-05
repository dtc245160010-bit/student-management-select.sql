# Phân tích EXPLAIN trước và sau khi tối ưu

Truy vấn ban đầu sử dụng YEAR(created_at) và MONTH(created_at) trong điều kiện WHERE. Đây là cách viết Non-SARGable vì MySQL phải áp dụng hàm lên từng giá trị của cột created_at trước khi kiểm tra điều kiện. Do đó Index trên created_at khó được sử dụng hiệu quả và truy vấn có thể thực hiện Full Table Scan với type = ALL.

Sau khi tối ưu, tôi tạo Composite Index:

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);

Truy vấn được viết lại bằng khoảng thời gian:

created_at >= '2026-06-01 00:00:00'
AND created_at < '2026-07-01 00:00:00'

Cách viết này SARGable, cho phép MySQL sử dụng B-Tree Index để tìm phạm vi dữ liệu phù hợp. Trong EXPLAIN, type có thể chuyển từ ALL sang range/ref và cột key có thể hiển thị idx_type_date. Giá trị rows dự kiến cũng giảm đáng kể vì MySQL không cần quét toàn bộ bảng.

Như vậy, việc loại bỏ YEAR()/MONTH() và sử dụng Composite Index giúp giảm lượng dữ liệu phải quét và cải thiện hiệu năng truy vấn.