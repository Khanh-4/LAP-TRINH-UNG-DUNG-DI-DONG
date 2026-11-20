# 05. Xử lý lỗi thường gặp

Các lỗi nhóm đã gặp thật. Gặp lỗi mới và sửa được → thêm vào file này.

## Android Studio / Flutter

### `flutter : The term 'flutter' is not recognized`
Chưa thêm `C:\src\flutter\bin` vào **Path**, hoặc chưa mở lại PowerShell/Android Studio sau khi thêm. Đóng hẳn rồi mở lại.

### Thanh vàng "Dart SDK is not configured"
Settings → Languages & Frameworks → **Flutter** → Flutter SDK path: `C:\src\flutter` → OK. Sau đó chạy `flutter pub get`.

### "No Windows desktop project configured" / app chạy trên Chrome
Đang chọn sai thiết bị. Ô chọn thiết bị → chọn **máy ảo Android**. Không thấy máy ảo → Device Manager → bấm ▶ để bật trước.

### Gradle: `Included build '...' has build path ':gradle'` hoặc lỗi đường dẫn Flutter SDK
`android/local.properties` đang trỏ sai Flutter SDK (thường do chạy `pub get` từ máy/môi trường khác). Sửa: mở Terminal trong Android Studio, chạy `flutter pub get`, rồi build lại.

### `Could not close incremental caches` (Kotlin)
Xảy ra khi project và pub cache nằm khác ổ đĩa (ví dụ project ở `D:`, cache ở `C:`). Đã sửa sẵn bằng `kotlin.incremental=false` trong `android/gradle.properties`. Nếu vẫn bị: `flutter clean` → `flutter pub get` → build lại.

### Lần build đầu rất lâu / treo ở "Running Gradle task"
Bình thường lần đầu mất 3–10 phút (tải Gradle, thư viện). Đừng bấm Stop. Kiểm tra mạng.

### Android Studio tự sinh `android/gradle/gradle-daemon-jvm.properties`
Không commit file này. Để nguyên hoặc xoá đều được.

## Firebase

### App hiện "đăng nhập giả lập" dù đã cấu hình
Log có dòng `Firebase chưa được cấu hình...`. Kiểm tra có file `android/app/google-services.json` chưa. Không có → chạy lại `flutterfire configure` (xem [01-setup.md](01-setup.md) mục 4).

### `flutterfire configure` báo không có quyền / không thấy project
Tài khoản Google của bạn chưa được thêm vào project. Nhắn A thêm vào Project settings → Users and permissions.

### Build lỗi `File google-services.json is missing` sau khi chạy flutterfire
`flutterfire configure` đã chèn lại plugin vào `plugins { }` trong `android/app/build.gradle.kts`. Xoá dòng `id("com.google.gms.google-services")` ở khối đó (giữ đoạn `if (file("google-services.json").exists())` ở cuối file).

### `PERMISSION_DENIED` khi đọc/ghi Firestore
- Chưa đăng nhập, hoặc đang đọc/ghi ngoài `users/{uid của mình}/...`.
- Rules chưa được publish: xem [04-data-contract.md](04-data-contract.md).

### Đăng ký báo "Email đã được sử dụng"
Email đã tồn tại trong Authentication. Dùng email khác, hoặc xoá user cũ trong Firebase Console → Authentication → Users.

## Máy ảo

### Máy ảo không bật / báo lỗi HAXM, Hypervisor
Bật ảo hoá: Windows Features → tích **Windows Hypervisor Platform** → khởi động lại. Kiểm tra BIOS đã bật Virtualization (VT-x/AMD-V).

### Máy ảo chạy rất chậm
Device Manager → Edit máy ảo → Graphics: **Hardware**. Đóng bớt Chrome. Cần ít nhất 8 GB RAM.

### Không có camera để test quét hoá đơn
Máy ảo có camera giả lập (cảnh 3D). Dễ hơn: kéo thả ảnh hoá đơn vào cửa sổ máy ảo → ảnh vào thư viện → chọn "Chọn từ thư viện" trong app. Hoặc cắm điện thoại thật: bật **Developer options → USB debugging**.

## Riêng cho người dùng WSL (Linux trong Windows)

Chỉ áp dụng nếu bạn chạy `flutter` trong WSL **và** Android Studio trên Windows cùng một thư mục project:

- Chạy `flutter pub get` bên nào thì `.dart_tool/` và `local.properties` ghi đường dẫn bên đó. Chuyển bên → chạy lại `flutter pub get` ở bên đang dùng. Dấu hiệu: `flutter analyze` trong WSL báo hàng trăm lỗi, hoặc Gradle báo lỗi đường dẫn.
- Gọi `emulator`/`adb` của Windows từ WSL bị lỗi do biến `HOME` của WSL: chạy qua PowerShell và `Remove-Item Env:HOME` trước.
