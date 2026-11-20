# 06. Definition of Done: thế nào là "xong"

Một task chỉ được coi là **xong** khi đạt **tất cả** các mục dưới đây. Checklist này cũng nằm trong template PR.

## Code
- [ ] Làm đúng yêu cầu ghi trong Issue (tiêu chí nghiệm thu).
- [ ] `flutter analyze` → `No issues found!`
- [ ] `flutter test` → tất cả pass.
- [ ] Có test cho logic mới (model, controller); màn hình chính có widget test.
- [ ] Theo [03-coding-rules.md](03-coding-rules.md): không gọi Firebase trong widget, model bất biến, chữ tiếng Việt.
- [ ] Không còn `print`, code comment bỏ đi, TODO không có issue đi kèm.
- [ ] Không có bí mật (API key, mật khẩu, file cấu hình Firebase) trong diff.

## Chạy thử
- [ ] Đã chạy trên **máy ảo Android hoặc điện thoại thật** với Firebase thật.
- [ ] Đã thử trường hợp lỗi: bỏ trống, nhập sai, mất mạng (tắt Wi-Fi máy ảo).
- [ ] Giao diện ổn ở chế độ sáng **và** tối.
- [ ] PR có ảnh chụp màn hình (nếu thay đổi giao diện): dùng lại được cho báo cáo.

## Quy trình
- [ ] PR ghi `Closes #<số issue>`.
- [ ] Ít nhất 1 thành viên khác đã **Approve**.
- [ ] Merge bằng **merge commit** (không squash), xoá nhánh sau khi merge.

## Chưa đạt thì sao?
Hết sprint mà task chưa đạt → **không merge vội**. Chuyển Issue sang sprint sau (đổi label), ghi chú lý do. Ghi trung thực trạng thái "Chưa hoàn thiện" trong báo cáo tốt hơn là demo một tính năng lỗi.
