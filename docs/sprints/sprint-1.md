# Sprint 1: Nền móng dữ liệu (20/11 – 26/11/2026)

**Mục tiêu:** chốt data contract, có Firestore chạy thật, xem được danh sách giao dịch, gửi được ảnh hoá đơn cho Gemini và nhận lại JSON.

**Demo cuối sprint (26/11):** đăng nhập → thấy danh sách giao dịch thật từ Firestore; chọn ảnh hoá đơn → hiện tổng tiền/cửa hàng/ngày AI đọc được.

| ID | Task | Người | Tiêu chí nghiệm thu |
|---|---|---|---|
| S1-A1 | Thư mục `docs/`, template PR/Issue, label, issue sprint 1 | A | PR được merge; B, C đã đọc |
| S1-A2 | Bật Firestore, publish `firestore.rules`, thêm B và C vào project Firebase | A | B, C chạy được `flutterfire configure`; user khác uid bị `PERMISSION_DENIED` |
| S1-A3 | Tạo hồ sơ `users/{uid}` khi đăng ký; Cài đặt cho đổi tên hiển thị | A | Đổi tên → hiện ngay ở Cài đặt và trên Firestore; có test |
| S1-B1 | **Chốt data contract** cùng C (trước 22/11): model `AppTransaction`, `Category`, `toMap/fromMap` + test | B | Contract trong `docs/04` đổi trạng thái "ĐÃ CHỐT"; test model pass |
| S1-B2 | `TransactionRepository` + `FakeTransactionRepository` + `FirestoreTransactionRepository` | B | Test repository Fake pass; thêm tay doc trên Console → app thấy |
| S1-B3 | Màn danh sách giao dịch: nhóm theo ngày, tổng thu/chi tháng, trạng thái tải/lỗi/trống | B | Widget test; chạy với Firestore thật |
| S1-C1 | Bật **Firebase AI Logic** (Gemini Developer API), thêm `firebase_ai`; service gửi ảnh → nhận JSON → `ReceiptScanResult` | C | Test parse JSON (đủ field, thiếu field, JSON hỏng); quét được 3 hoá đơn thật |
| S1-C2 | Màn Quét: chụp ảnh / chọn thư viện (`image_picker`), xem trước, đang xử lý, lỗi, hiện kết quả | C | Chạy trên máy ảo với ảnh kéo thả vào thư viện |

**Phụ thuộc:** S1-B1 phải xong sớm (22/11) vì S1-B2, S1-C1 dùng model này. S1-A2 chặn mọi việc dùng Firestore của B và C.

## Ghi chú kết thúc sprint
_(Điền vào 26/11: đã xong gì, chuyển gì sang sprint 2, vấn đề gặp phải.)_
