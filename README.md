# Chi Tiêu AI: Quản lý chi tiêu cá nhân và quét hóa đơn bằng AI

Đồ án cuối kỳ môn **CMP177, Lập trình trên thiết bị di động**. Ứng dụng được viết bằng Flutter và dùng Firebase làm backend.

## Thành viên và phân công

| Thành viên | Vai trò | Phụ trách |
|---|---|---|
| _(tên A)_ | A: Nền tảng và tài khoản | Khung dự án, điều hướng, theme, Firebase Auth, hồ sơ, cài đặt, khóa sinh trắc học |
| _(tên B)_ | B: Giao dịch và ngân sách | Thêm/sửa/xóa thu chi (Firestore), danh mục, ví, ngân sách và cảnh báo, tìm kiếm, lọc |
| _(tên C)_ | C: AI và thống kê | Quét hóa đơn (image_picker + Gemini qua firebase_ai), biểu đồ (fl_chart) |

## Yêu cầu

- Flutter 3.x (Dart từ 3.7 trở lên). Kiểm tra bằng `flutter doctor`.
- Máy ảo Android, iOS Simulator hoặc thiết bị thật.

## Chạy dự án

```bash
git clone https://github.com/Khanh-4/LAP-TRINH-UNG-DUNG-DI-DONG.git
cd LAP-TRINH-UNG-DUNG-DI-DONG
flutter pub get
flutter run
```

Nếu máy **chưa cấu hình Firebase**, app vẫn chạy nhưng tự chuyển sang **đăng nhập giả lập**. Khi đó có thể nhập email bất kỳ chứa `@` và mật khẩu từ 6 ký tự trở lên.

Chạy kiểm thử và phân tích mã:

```bash
flutter analyze
flutter test
```

## Cấu hình Firebase

Project Firebase của nhóm có ID `chitieuai-99447`. Phần đăng nhập dùng Authentication với phương thức Email/Password.

Các file cấu hình **không được commit** vì đã nằm trong `.gitignore`: `google-services.json`, `GoogleService-Info.plist`, `firebase_options.dart`, `firebase.json`. Mỗi thành viên tự sinh ra trên máy mình. Trước đó, chủ project cần thêm email của bạn vào Firebase Console → Project settings → Users and permissions.

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
export PATH="$PATH:$HOME/.pub-cache/bin"
firebase login            # trên WSL dùng: firebase login --no-localhost
flutterfire configure --project=chitieuai-99447 --platforms=android,ios \
  --android-package-name=com.cmp177.expense_ai --ios-bundle-id=com.cmp177.expenseAi --yes
```

> ⚠️ Sau khi chạy `flutterfire configure`, mở `android/app/build.gradle.kts` và **xóa** dòng `id("com.google.gms.google-services")` mà công cụ vừa thêm vào khối `plugins { }`. Plugin này đã được bật có điều kiện ở cuối file. Nếu để nguyên, máy chưa cấu hình sẽ không build được.

App chọn backend lúc khởi động trong `lib/main.dart`: có file cấu hình thì dùng Firebase, không có thì dùng bản giả lập.

## Cấu trúc thư mục

```
lib/
├── main.dart                 # điểm vào, chọn AuthRepository
├── app.dart                  # MaterialApp.router + Provider
├── core/
│   ├── constants/            # hằng số dùng chung
│   ├── router/               # go_router: route, redirect theo trạng thái đăng nhập
│   ├── theme/                # theme Material 3 sáng/tối
│   └── utils/                # định dạng tiền VND, ngày
├── features/                 # tổ chức theo tính năng
│   ├── auth/                 # (A) domain / data (repository) / presentation
│   ├── home/                 # (A) khung điều hướng 4 tab
│   ├── settings/             # (A) cài đặt, đăng xuất
│   ├── transactions/         # (B) giao dịch, ngân sách
│   ├── scan/                 # (C) quét hóa đơn AI
│   └── stats/                # (C) thống kê
└── shared/widgets/           # widget dùng chung
test/                         # cùng cấu trúc với lib/
```

Mỗi tính năng chia làm 3 lớp:
- `domain/`: model bất biến.
- `data/`: interface repository và các bản cài đặt (giả lập, Firebase).
- `presentation/`: màn hình và controller `ChangeNotifier` (Provider).

## Công nghệ

| Thành phần | Thư viện | Mục đích |
|---|---|---|
| Quản lý state | provider | ChangeNotifier cho controller |
| Điều hướng | go_router | Route khai báo, bottom navigation, chặn khi chưa đăng nhập |
| Định dạng | intl | Tiền VND, ngày tháng |
| Backend | firebase_core | Khởi tạo Firebase |
| Xác thực | firebase_auth | Đăng nhập, đăng ký, quên mật khẩu bằng email |

## Quy ước làm việc nhóm

- Không commit thẳng vào `main`. Tạo nhánh `feature/<tên-tính-năng>` rồi mở Pull Request để thành viên khác xem.
- Commit nhỏ, thường xuyên, theo mẫu: `feat: thêm form tạo giao dịch`, `fix: ...`, `test: ...`, `docs: ...`.
- Chạy `flutter analyze` và `flutter test` trước khi mở PR.
- Không squash hay force-push lên `main`, vì lịch sử commit của từng người được chấm điểm.
- Tuyệt đối không commit API key, mật khẩu hay file cấu hình Firebase.
