# AI Prompt Log

## Prompt 1

Trong MySQL, các giá trị ALL, index, range, ref và const trong cột type của EXPLAIN có ý nghĩa gì?

### Kết quả

ALL thường biểu thị Full Table Scan. range cho biết MySQL quét một phạm vi của Index. ref thường dùng Index để tìm các giá trị khớp. const là trường hợp MySQL có thể xác định một dòng hoặc giá trị cố định rất nhanh.

---

## Prompt 2

SARGable trong SQL là gì? Tại sao YEAR(created_at) làm truy vấn khó sử dụng Index?

### Kết quả

SARGable là điều kiện truy vấn được viết theo cách cho phép Database sử dụng Index hiệu quả. YEAR(created_at) yêu cầu tính hàm trên từng giá trị created_at, trong khi điều kiện khoảng thời gian bằng >= và < cho phép MySQL tìm trực tiếp trên B-Tree Index.

---

## Prompt 3

Composite Index (transaction_type, created_at) hoạt động như thế nào?

### Kết quả

Composite Index chứa nhiều cột theo thứ tự xác định. Với Index (transaction_type, created_at), MySQL có thể lọc transaction_type trước rồi tìm phạm vi created_at phù hợp. Thứ tự cột trong Composite Index rất quan trọng.

---

## Prompt 4

Tại sao không nên tạo quá nhiều Index trên bảng Transactions?

### Kết quả

Index giúp SELECT nhanh hơn nhưng làm tăng chi phí INSERT, UPDATE và DELETE vì Database phải cập nhật các Index liên quan. Quá nhiều Index cũng làm tăng dung lượng lưu trữ và chi phí bảo trì.