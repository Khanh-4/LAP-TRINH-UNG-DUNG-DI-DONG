# 03. Quy tắc viết code

Xem code mẫu có sẵn trong `lib/features/auth/`: làm theo đúng khuôn đó.

## Cấu trúc thư mục

```
lib/features/<tính-năng>/
├── domain/          # Model bất biến (không import Flutter, không import Firebase)
├── data/            # Interface repository + bản cài đặt Fake và Firebase
└── presentation/    # Màn hình, widget, controller (ChangeNotifier)
    └── widgets/     # Widget con chỉ dùng trong tính năng này
```

- Dùng chung giữa nhiều tính năng: `lib/shared/widgets/`, `lib/core/`.
- Test đặt cùng cấu trúc: `test/features/<tính-năng>/...`.

## Các lớp và luồng dữ liệu

```
Màn hình (Widget) ──gọi──▶ Controller (ChangeNotifier) ──gọi──▶ Repository (interface)
       ▲                          │                                    │
       └──── notifyListeners ─────┘                    FakeXxxRepository / FirestoreXxxRepository
```

- **Widget không gọi Firebase trực tiếp.** Chỉ gọi controller.
- **Controller không biết Firebase.** Chỉ dùng interface repository, nhờ vậy test được bằng bản Fake.
- Mỗi repository có **2 bản**: `FakeXxxRepository` (lưu trong bộ nhớ, dùng cho test và khi chưa cấu hình Firebase) và `FirestoreXxxRepository`.
- Chọn bản nào và inject ở `lib/main.dart` / `lib/app.dart` (A hỗ trợ phần này).

## Model

- Bất biến: tất cả field `final`, constructor `const` nếu được.
- Có `copyWith`, `==`/`hashCode`, và `toMap()` / `fromMap()` để chuyển sang Firestore.
- Không bao giờ sửa object có sẵn: tạo object mới bằng `copyWith`.

```dart
final updated = transaction.copyWith(amount: 50000);  // ✅
transaction.amount = 50000;                          // ❌ (không compile được vì final)
```

## State (provider)

- Controller kế thừa `ChangeNotifier`, có `isLoading`, `errorMessage`.
- Bắt lỗi trong controller, đổi thành thông báo tiếng Việt cho người dùng; không để app crash.
- Trong widget: `context.watch<X>()` khi cần vẽ lại, `context.read<X>()` khi chỉ gọi hàm (trong `onPressed`).

## Điều hướng

- Đường dẫn khai báo trong `lib/core/router/app_routes.dart`, route trong `app_router.dart`.
- Chuyển màn: `context.go(AppRoutes.xxx)` hoặc `context.push(...)` cho màn chi tiết.
- Thêm route mới → báo A hoặc ghi rõ trong PR (file dùng chung).

## UI

- Toàn bộ chữ trên giao diện bằng **tiếng Việt**.
- Dùng màu/kiểu chữ từ `Theme.of(context)`, **không** hardcode màu (để chế độ tối hoạt động).
- Tiền: `Formatters.currency(amount)` → `150.000 ₫`. Ngày: `Formatters.date(d)` → `20/11/2026`.
- Mỗi màn có đủ 3 trạng thái: **đang tải**, **lỗi** (có nút thử lại), **trống** (có hướng dẫn).
- Widget quan trọng cho test gắn `Key`, ví dụ `Key('transaction_amount')`.

## Đặt tên

| Loại | Kiểu | Ví dụ |
|---|---|---|
| File | `snake_case.dart` | `transaction_list_screen.dart` |
| Class | `PascalCase` | `TransactionController` |
| Biến, hàm | `camelCase` | `totalExpense`, `loadMonth()` |
| Bool | tiền tố `is/has/can` | `isLoading`, `hasError` |
| Hằng số | `camelCase` trong class | `AppConstants.minPasswordLength` |

## Giới hạn

- Hàm < 50 dòng, file < 400 dòng. Dài hơn thì tách widget/hàm con.
- Lồng nhau tối đa 4 cấp: dùng `return` sớm.
- Không để `print`; cần log thì `debugPrint` và xoá trước khi merge.
- Không có số "ma thuật": đặt tên hằng số.

## Test

- Tối thiểu: test model (`toMap`/`fromMap`, `copyWith`), test controller với repository Fake.
- Màn hình chính của bạn: ít nhất 1 widget test cho luồng chính.
- Mẫu: `test/features/auth/auth_controller_test.dart`, `test/widget/app_flow_test.dart`.

## Thư viện mới

Thêm package vào `pubspec.yaml` → ghi rõ trong PR **tên package + lý do**. Ưu tiên package có nhiều like trên pub.dev và hỗ trợ Android + iOS.
