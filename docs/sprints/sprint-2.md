# Sprint 2: Luồng chính hoàn chỉnh (27/11 – 03/12/2026)

**Mục tiêu:** người dùng thêm/sửa/xoá được giao dịch, quét hoá đơn rồi lưu thành giao dịch, xem thống kê tháng.

**Demo cuối sprint (03/12):** quét hoá đơn → form điền sẵn → lưu → thấy trong danh sách và trong biểu đồ.

| ID | Task | Người | Tiêu chí nghiệm thu |
|---|---|---|---|
| S2-A1 | Đăng nhập bằng Google (`google_sign_in`, đăng ký SHA-1) | A | Đăng nhập Google trên máy ảo; hồ sơ `users/{uid}` được tạo |
| S2-A2 | Cài đặt: chế độ sáng/tối/theo hệ thống, lưu bằng `shared_preferences` | A | Khởi động lại app vẫn giữ lựa chọn; có test |
| S2-A3 | Inject repository của B, C vào `app.dart`; bản Fake khi chưa cấu hình Firebase | A | App chạy cả khi có và không có Firebase |
| S2-B1 | Form thêm/sửa giao dịch: số tiền, loại, danh mục, ngày, ghi chú; nhận `AppTransaction?` ban đầu | B | Validate số tiền > 0; widget test thêm và sửa |
| S2-B2 | Xoá giao dịch (vuốt hoặc nút) có xác nhận / hoàn tác | B | Xoá → biến mất khỏi danh sách và Firestore |
| S2-B3 | Chuyển tháng, lọc theo danh mục, tìm theo ghi chú/cửa hàng | B | Có test controller cho lọc/tìm |
| S2-C1 | Nối Quét → form giao dịch của B (điền sẵn, `source: scan`) | C | Lưu xong, giao dịch có `source == "scan"` |
| S2-C2 | Màn Thống kê: tổng thu/chi/chênh lệch tháng, biểu đồ tròn theo danh mục (`fl_chart`) | C | Số liệu khớp danh sách; test hàm tổng hợp |

## Ghi chú kết thúc sprint
_(Điền vào 03/12.)_
