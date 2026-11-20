# 04. Data contract: model và Firestore dùng chung

> **Trạng thái: BẢN NHÁP**: B và C xem, góp ý trong PR/Issue, **chốt trước 22/11**. Sau khi chốt, muốn đổi field phải báo cả nhóm.

File này là "hợp đồng" giữa các phần: B sở hữu dữ liệu giao dịch; C **ghi** giao dịch từ kết quả quét và **đọc** giao dịch để thống kê. Cả hai phải dùng đúng model và repository dưới đây.

## Cấu trúc Firestore

```
users/{uid}                                  # hồ sơ người dùng (A)
users/{uid}/transactions/{transactionId}     # giao dịch (B sở hữu, C đọc/ghi qua repository)
users/{uid}/budgets/{yyyy-MM}_{categoryId}   # ngân sách theo tháng (B, sprint 3)
```

Mọi dữ liệu nằm dưới `users/{uid}` nên security rules chỉ cần một điều kiện: **người dùng chỉ đọc/ghi được dữ liệu của chính mình**.

### `users/{uid}`

| Field | Kiểu | Ghi chú |
|---|---|---|
| `displayName` | string | |
| `email` | string | |
| `createdAt` | timestamp | |

### `users/{uid}/transactions/{id}`

| Field | Kiểu Firestore | Bắt buộc | Ghi chú |
|---|---|---|---|
| `type` | string | ✓ | `"expense"` hoặc `"income"` |
| `amount` | int | ✓ | Số tiền **VND, số nguyên dương** (không lưu số âm; chi/thu phân biệt bằng `type`) |
| `categoryId` | string | ✓ | Một id trong danh sách danh mục bên dưới |
| `date` | timestamp | ✓ | Ngày phát sinh giao dịch (người dùng chọn) |
| `note` | string | ✓ | Có thể rỗng `""` |
| `merchant` | string \| null | | Tên cửa hàng (thường có khi quét hoá đơn) |
| `source` | string | ✓ | `"manual"` (nhập tay) hoặc `"scan"` (từ quét hoá đơn) |
| `createdAt` | timestamp | ✓ | Dùng `FieldValue.serverTimestamp()` |
| `updatedAt` | timestamp | ✓ | Cập nhật mỗi lần sửa |

> **Không lưu ảnh hoá đơn lên cloud.** Firebase Storage yêu cầu gói trả phí (Blaze). Ảnh chỉ dùng tạm để gửi cho Gemini rồi bỏ.

## Danh mục (cố định trong code, không lưu Firestore)

File: `lib/features/transactions/domain/category.dart` (B tạo).

| id | Tên hiển thị | Loại |
|---|---|---|
| `food` | Ăn uống | expense |
| `transport` | Di chuyển | expense |
| `shopping` | Mua sắm | expense |
| `bills` | Hoá đơn & tiện ích | expense |
| `entertainment` | Giải trí | expense |
| `health` | Sức khoẻ | expense |
| `education` | Học tập | expense |
| `other_expense` | Khác | expense |
| `salary` | Lương | income |
| `bonus` | Thưởng | income |
| `other_income` | Thu nhập khác | income |

C dùng danh sách id này trong prompt Gemini để AI chọn danh mục gợi ý.

## Model Dart

File: `lib/features/transactions/domain/app_transaction.dart` (B tạo). Đặt tên `AppTransaction` để không trùng với class `Transaction` của Firestore.

```dart
enum TransactionType { expense, income }
enum TransactionSource { manual, scan }

class AppTransaction {
  const AppTransaction({
    required this.id,          // '' khi chưa lưu
    required this.type,
    required this.amount,      // int, VND, > 0
    required this.categoryId,
    required this.date,
    this.note = '',
    this.merchant,
    this.source = TransactionSource.manual,
  });
  // final fields..., copyWith, ==, hashCode
  // Map<String, Object?> toMap();
  // factory AppTransaction.fromMap(String id, Map<String, Object?> map);
}
```

## Repository giao dịch

File: `lib/features/transactions/data/transaction_repository.dart` (B tạo, có bản Fake + Firestore).

```dart
abstract interface class TransactionRepository {
  /// Giao dịch trong một tháng, mới nhất trước. Tự cập nhật khi dữ liệu đổi.
  Stream<List<AppTransaction>> watchMonth(DateTime month);

  Future<String> add(AppTransaction transaction);   // trả về id mới
  Future<void> update(AppTransaction transaction);
  Future<void> delete(String id);
}
```

- **C (thống kê)** dùng `watchMonth` rồi tự cộng dồn theo danh mục/ngày.
- **C (quét)** không gọi `add` trực tiếp: mở form thêm giao dịch của B với dữ liệu điền sẵn (xem dưới), người dùng kiểm tra rồi mới lưu.
- Repository tự lấy `uid` từ `FirebaseAuth.instance.currentUser`, controller không cần truyền.

## Kết quả quét hoá đơn → form giao dịch

File: `lib/features/scan/domain/receipt_scan_result.dart` (C tạo).

```dart
class ReceiptScanResult {
  final int? total;               // VND; null nếu AI không đọc được
  final DateTime? date;
  final String? merchant;
  final String? suggestedCategoryId;  // một id trong bảng danh mục
}
```

Màn form của B nhận giá trị ban đầu, ví dụ:

```dart
context.push(AppRoutes.transactionNew, extra: AppTransaction(
  id: '', type: TransactionType.expense,
  amount: result.total ?? 0, categoryId: result.suggestedCategoryId ?? 'other_expense',
  date: result.date ?? DateTime.now(), merchant: result.merchant,
  source: TransactionSource.scan,
));
```

→ **B cần làm form nhận `AppTransaction?` ban đầu** (null = tạo mới trống).

## Ngân sách (sprint 3)

`users/{uid}/budgets/{yyyy-MM}_{categoryId}`: `{ month: "2026-12", categoryId: "food", limit: 2000000 }`. Chi tiết chốt ở sprint 3.

## Security rules

File [`firestore.rules`](../firestore.rules) ở thư mục gốc repo (A quản lý). Nội dung:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
  }
}
```

Áp dụng: Firebase Console → Firestore Database → Rules → dán nội dung → Publish.
