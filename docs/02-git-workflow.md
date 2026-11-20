# 02. Quy trình Git & GitHub

> Lịch sử Git **được chấm điểm** (1/7 điểm): cần commit thật của **từng thành viên**, kéo dài ít nhất 3 tuần. Commit đều đặn mỗi tuần, đừng dồn vào cuối.

## Quy tắc vàng

1. **Không commit thẳng vào `main`.** Mọi thay đổi đi qua Pull Request.
2. **Không squash, không rebase, không force-push** nhánh đã push. Merge PR bằng **"Create a merge commit"**.
3. **Không commit bí mật:** API key, mật khẩu, `google-services.json`, `firebase_options.dart`, `.env`.
4. **Commit bằng tài khoản GitHub của chính mình.** Kiểm tra trước commit đầu tiên:
   ```bash
   git config user.name    # tên GitHub của bạn
   git config user.email   # email đã gắn với tài khoản GitHub
   ```
   Sai email thì commit không hiện avatar/không tính đóng góp cho bạn.

## Quy trình cho mỗi task

```bash
# 1. Cập nhật main
git checkout main
git pull

# 2. Tạo nhánh từ main
git checkout -b feature/transaction-list

# 3. Code, commit nhỏ và thường xuyên
git add lib/features/transactions/...
git commit -m "feat: hiển thị danh sách giao dịch theo ngày"

# 4. Trước khi push: chạy kiểm tra
flutter analyze
flutter test

# 5. Push và mở PR
git push -u origin feature/transaction-list
# Lên GitHub → "Compare & pull request" → điền template → ghi "Closes #<số issue>"
```

## Đặt tên nhánh

| Loại | Mẫu | Ví dụ |
|---|---|---|
| Tính năng | `feature/<tên>` | `feature/receipt-scan` |
| Sửa lỗi | `fix/<tên>` | `fix/amount-format` |
| Tài liệu | `docs/<tên>` | `docs/setup-guide` |
| Dọn dẹp, cấu hình | `chore/<tên>` | `chore/update-deps` |

Tên nhánh viết thường, tiếng Anh không dấu, nối bằng `-`.

## Commit message

Mẫu: `<loại>: <mô tả ngắn, tiếng Việt>`

| Loại | Khi nào |
|---|---|
| `feat` | Thêm tính năng |
| `fix` | Sửa lỗi |
| `test` | Thêm/sửa test |
| `refactor` | Sửa code, không đổi hành vi |
| `docs` | Tài liệu |
| `chore` | Cấu hình, thư viện, việc lặt vặt |
| `style` | Format, không đổi logic |

✅ `feat: thêm form tạo giao dịch có kiểm tra số tiền`
✅ `fix: số tiền âm vẫn lưu được`
❌ `update`, `sửa code`, `final`, `asdf`

Mỗi commit làm **một việc**. Một ngày làm việc nên có vài commit, không phải một commit khổng lồ.

## Pull Request & review

- PR nhỏ (lý tưởng < 400 dòng), làm xong một task là mở.
- Điền đủ template (tự hiện khi tạo PR).
- **Ít nhất 1 thành viên khác review** và Approve rồi mới merge. Review = đọc code, kéo nhánh về chạy thử nếu có UI.
- Người mở PR là người bấm merge, sau khi được approve.
- Merge xong: xoá nhánh trên GitHub (nút "Delete branch").

Review trên GitHub (comment, approve) cũng là bằng chứng làm việc nhóm.

## Khi bị conflict

```bash
git checkout main && git pull
git checkout feature/cua-ban
git merge main                 # KHÔNG dùng rebase
# Sửa các file conflict (Android Studio: Git → Resolve Conflicts)
flutter analyze && flutter test
git add . && git commit        # commit merge
git push
```

Conflict ở code của người khác → gọi người đó cùng sửa, đừng tự xoá code của họ.

## Issue

- Mỗi task trong sprint là một Issue, có label `sprint-N` + `role:X`, gán cho người làm.
- Phát hiện lỗi → tạo Issue dùng template **Bug**.
- Đang làm task nào thì comment vào Issue đó khi bị kẹt, để cả nhóm biết.
