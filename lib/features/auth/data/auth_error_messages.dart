/// Đổi mã lỗi của Firebase Auth thành thông báo tiếng Việt.
String authErrorMessage(String code) => switch (code) {
  'invalid-email' => 'Email không hợp lệ',
  'user-disabled' => 'Tài khoản đã bị khóa',
  'user-not-found' ||
  'wrong-password' ||
  'invalid-credential' => 'Email hoặc mật khẩu không đúng',
  'email-already-in-use' => 'Email này đã được đăng ký',
  'weak-password' => 'Mật khẩu quá yếu (tối thiểu 6 ký tự)',
  'too-many-requests' => 'Bạn thử quá nhiều lần, vui lòng đợi rồi thử lại',
  'network-request-failed' => 'Không có kết nối mạng',
  'operation-not-allowed' =>
    'Phương thức đăng nhập này chưa được bật trên Firebase',
  _ => 'Đã có lỗi xảy ra, vui lòng thử lại',
};
