# 01. Cài đặt môi trường

Hướng dẫn cho **Windows** (cách đơn giản nhất). Làm theo thứ tự, mỗi bước kiểm tra xong mới qua bước sau.

## 1. Cài Git và Flutter

1. Cài [Git for Windows](https://git-scm.com/download/win).
2. Tải Flutter SDK (Windows, stable) tại https://docs.flutter.dev/get-started/install/windows, giải nén vào `C:\src\flutter`.
   - **Không** đặt trong `C:\Program Files` hay thư mục có dấu cách/tiếng Việt.
3. Thêm `C:\src\flutter\bin` vào biến môi trường **Path** (Start → "Edit the system environment variables" → Environment Variables → Path → New).
4. Mở **PowerShell mới**, chạy:
   ```powershell
   flutter --version
   flutter doctor
   ```

## 2. Cài Android Studio và máy ảo

1. Cài [Android Studio](https://developer.android.com/studio). Lần mở đầu chọn **Standard** để nó tự tải Android SDK.
2. **Settings → Plugins** → cài **Flutter** (tự cài kèm Dart) → Restart.
3. **Settings → Languages & Frameworks → Android SDK → SDK Tools** → tích **Android SDK Command-line Tools** → Apply.
4. Chấp nhận license:
   ```powershell
   flutter doctor --android-licenses   # bấm y cho tất cả
   ```
5. **Device Manager** (biểu tượng điện thoại bên phải) → **Create Virtual Device** → chọn *Medium Phone* hoặc *Pixel* → chọn image có **Google Play** → Finish → bấm ▶ để bật.
6. `flutter doctor` phải có ✓ ở Flutter, Android toolchain, Android Studio. Dòng Visual Studio báo ✗ thì **bỏ qua** (chỉ cần khi build app Windows).

## 3. Lấy code về và chạy

```powershell
cd D:\
git clone https://github.com/Khanh-4/LAP-TRINH-UNG-DUNG-DI-DONG.git
cd LAP-TRINH-UNG-DUNG-DI-DONG
flutter pub get
```

Trong Android Studio: **File → Open** → chọn thư mục `LAP-TRINH-UNG-DUNG-DI-DONG` (thư mục gốc, **không** chọn thư mục `android`).

Chạy app:
1. Ô chọn thiết bị trên thanh công cụ → chọn máy ảo (`sdk gphone64...`), **không** chọn "Windows (desktop)" hay "Chrome".
2. Ô bên cạnh: `main.dart`.
3. Bấm **Run ▶**. Lần đầu build mất 2–5 phút.
4. Sửa code rồi **Ctrl+S** → Hot Reload, thấy thay đổi ngay.

Chưa cấu hình Firebase thì app chạy với **đăng nhập giả lập** (email bất kỳ có `@`, mật khẩu ≥ 6 ký tự). Đủ để làm UI, nhưng dữ liệu không lưu lên Firestore.

## 4. Kết nối Firebase (bắt buộc trước khi làm phần dùng Firestore/AI)

**Trước tiên:** nhắn A thêm email Google của bạn vào Firebase Console → Project settings → **Users and permissions** (project `chitieuai-99447`).

```powershell
# Cần Node.js: https://nodejs.org (bản LTS)
npm install -g firebase-tools
dart pub global activate flutterfire_cli
# Thêm %LOCALAPPDATA%\Pub\Cache\bin vào Path, mở lại PowerShell

firebase login
flutterfire configure --project=chitieuai-99447 --platforms=android,ios `
  --android-package-name=com.cmp177.expense_ai --ios-bundle-id=com.cmp177.expenseAi --yes
```

> ⚠️ **Sau khi chạy xong:** mở `android/app/build.gradle.kts`, **xoá** dòng `id("com.google.gms.google-services")` mà công cụ vừa chèn vào khối `plugins { }`. Plugin đã được bật có điều kiện ở cuối file. Kiểm tra bằng `git diff`: file này **không được** có thay đổi.

Các file sinh ra (`google-services.json`, `firebase_options.dart`, `firebase.json`) đã nằm trong `.gitignore`. **Không bao giờ** commit chúng.

Kiểm tra: chạy app → đăng ký tài khoản → Firebase Console → Authentication → Users có email vừa tạo.

## 5. Lệnh hay dùng

```powershell
flutter pub get          # sau khi pull code có đổi pubspec.yaml
flutter analyze          # phải "No issues found!" trước khi mở PR
flutter test             # chạy toàn bộ test
flutter clean            # khi build lỗi khó hiểu, rồi pub get lại
```

Gặp lỗi → xem [05-troubleshooting.md](05-troubleshooting.md).
