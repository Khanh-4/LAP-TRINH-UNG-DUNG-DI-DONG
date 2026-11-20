# 07. Yêu cầu nộp bài

Tóm tắt từ 2 file của giảng viên: *"Hướng dẫn quay video báo cáo đồ án"* và *"Yêu cầu nộp báo cáo đồ án cuối kỳ"*. Gặp chỗ nào không rõ thì đọc bản gốc.

## Cơ cấu điểm (10 điểm)

| Hạng mục | Điểm | Yêu cầu chính |
|---|---|---|
| Video demo | **5** | ≤ 10 phút; giới thiệu nhóm, đề tài, công nghệ, demo chức năng |
| Link Git | **1** | Có lịch sử làm việc và đóng góp của **mọi thành viên**; link mở được |
| File báo cáo | **1** | PDF/Word đúng mẫu, có link Git |
| Vấn đáp offline | **3** | Riêng, không thuộc video. Mỗi người phải hiểu phần mình làm |

Cả 3 tệp (video, báo cáo, link Git) nộp vào **folder chung của nhóm**.

## Git (1 điểm)
- Làm việc trên Git **ít nhất 3 tuần tính từ buổi học cuối cùng** (không tính lùi từ ngày nộp).
- Mỗi thành viên có commit thật, đúng phần được phân công.
- Repo **public** (hoặc cấp quyền cho giảng viên). Link private = 0 điểm.
- README đủ để người chấm chạy và nhận ra dự án.

## Video (5 điểm)

**Bắt buộc:** tất cả thành viên **bật camera suốt video** (quay qua Google Meet/Zoom/Teams có chia sẻ màn hình), trang phục lịch sự, đủ sáng, âm thanh rõ.

| Thời gian | Nội dung |
|---|---|
| 00:00 – 01:00 | Chào, số nhóm, đề tài, **họ tên + MSSV** từng người |
| 01:00 – 02:00 | Vấn đề ứng dụng giải quyết, đối tượng, công nghệ (Flutter, Firebase, Gemini…) |
| 02:00 – 09:30 | **Demo**: ưu tiên chức năng đặc trưng (quét hoá đơn AI, thống kê, ngân sách). Đăng nhập và CRUD đi **nhanh** |
| 09:30 – 10:00 | Tổng kết, cảm ơn |

Chuẩn bị trước:
- Tài khoản demo + **dữ liệu mẫu** (vài chục giao dịch trải đều các tháng để biểu đồ đẹp).
- Ảnh hoá đơn thật để quét.
- Không để lộ mật khẩu, API key, thông báo cá nhân trên màn hình.
- Quay thử, đo thời gian. Được cắt ghép hợp lý.

Tránh: quá 10 phút, ai đó tắt camera, chỉ lướt giao diện mà không thao tác, trình bày tính năng chưa xong như thể đã chạy.

## Báo cáo (1 điểm)

Cấu trúc:
1. **Trang bìa**: trường/khoa, học phần CMP177, tên đề tài, họ tên + MSSV, lớp/nhóm, giảng viên, học kỳ – năm học.
2. **Kết quả thực nghiệm** (phần chính):
   - **Bảng công nghệ**: Thành phần | Công nghệ/Thư viện | Mục đích. Chỉ ghi thư viện chính thực sự dùng.
   - **Link Git** (repo public).
   - **Bảng chức năng**: STT | Module | Chức năng | Trạng thái (`Hoàn thành` / `Chưa hoàn thiện`). **Không** ghi tính năng chưa làm là hoàn thành.
   - **Minh hoạ từng chức năng**: Tên chức năng → Ảnh chụp → **Mô tả** cách thao tác và kết quả. Không được chỉ chèn ảnh.
3. **Kết luận**: đã làm được gì, còn hạn chế gì, hướng phát triển.

**Không cần:** lời cảm ơn, lời cam kết, cơ sở lý thuyết, giới thiệu dài về công nghệ, thiết kế CSDL, giải thích source code.

> Mẹo: ảnh chụp màn hình gắn trong mỗi PR chính là nguyên liệu cho mục "Minh hoạ chức năng". Ghi lại từ bây giờ.

## Checklist trước khi nộp
- [ ] Video ≤ 10 phút, mọi người xuất hiện trên camera suốt video
- [ ] Video có giới thiệu nhóm, đề tài, công nghệ, demo chức năng chính
- [ ] Báo cáo đúng mẫu, có link Git, bảng chức năng trung thực
- [ ] Link Git mở được ở chế độ ẩn danh (repo public)
- [ ] Lịch sử Git ≥ 3 tuần từ buổi học cuối, có commit của cả 3 người
- [ ] README cập nhật: tên thành viên, cách chạy, cấu hình
- [ ] Folder chung có đủ 1 video + 1 báo cáo, tên file rõ ràng, không đặt mật khẩu
