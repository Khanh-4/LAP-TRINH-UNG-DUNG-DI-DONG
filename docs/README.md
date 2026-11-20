# Tài liệu làm việc nhóm: Chi Tiêu AI

Thư mục này dành cho **thành viên nhóm**. README ở thư mục gốc dành cho **người chấm**.

## Đọc theo thứ tự

| # | File | Đọc khi nào |
|---|---|---|
| 1 | [01-setup.md](01-setup.md) | Lần đầu: cài Flutter, Android Studio, máy ảo, Firebase |
| 2 | [02-git-workflow.md](02-git-workflow.md) | Trước commit đầu tiên |
| 3 | [03-coding-rules.md](03-coding-rules.md) | Trước khi viết code |
| 4 | [04-data-contract.md](04-data-contract.md) | **B và C bắt buộc đọc**: model và cấu trúc Firestore dùng chung |
| 5 | [05-troubleshooting.md](05-troubleshooting.md) | Khi gặp lỗi build/chạy |
| 6 | [06-definition-of-done.md](06-definition-of-done.md) | Trước khi mở PR |
| 7 | [07-deliverables.md](07-deliverables.md) | Yêu cầu nộp bài: video, báo cáo, Git |
| 8 | [sprints/](sprints/) | Kế hoạch từng sprint |

## Phân công

| Vai trò | Phụ trách | Thư mục code |
|---|---|---|
| **A**: Nền tảng & tài khoản | Khung app, điều hướng, theme, Firebase Auth, Cài đặt, Firestore rules, tài liệu | `lib/core`, `lib/features/{auth,home,settings}` |
| **B**: Giao dịch & ngân sách | Thêm/sửa/xoá thu chi, danh mục, lọc/tìm kiếm, ngân sách | `lib/features/transactions` |
| **C**: AI & thống kê | Quét hoá đơn bằng Gemini, biểu đồ thống kê | `lib/features/{scan,stats}` |

Mỗi người chủ yếu sửa trong thư mục của mình. Muốn sửa `lib/core` hoặc code của người khác thì nhắn người đó trước, tránh conflict.

## Lịch sprint (1 tuần/sprint, tạm tính từ 20/11/2026)

| Sprint | Thời gian | Mục tiêu |
|---|---|---|
| [1](sprints/sprint-1.md) | 20/11 – 26/11 | Chốt data contract, Firestore, CRUD cơ bản, PoC quét hoá đơn |
| [2](sprints/sprint-2.md) | 27/11 – 03/12 | Form giao dịch đầy đủ, nối quét → giao dịch, thống kê, Google sign-in |
| [3](sprints/sprint-3.md) | 04/12 – 10/12 | Ngân sách, hoàn thiện, test, sửa lỗi |
| [4](sprints/sprint-4.md) | 11/12 – 17/12 | Đóng băng tính năng, dữ liệu demo, quay video, viết báo cáo |

> Khi biết ngày học buổi cuối và hạn nộp, cập nhật lại bảng này. Lịch sử Git phải dài **ít nhất 3 tuần tính từ buổi học cuối**.

## Theo dõi task

- Mỗi task là một **GitHub Issue**, có label `sprint-N` và `role:A|B|C`, gán cho người làm.
- PR ghi `Closes #<số issue>` để issue tự đóng khi merge.
- Xem tổng quan: tab **Issues** → lọc theo label `sprint-1`.
