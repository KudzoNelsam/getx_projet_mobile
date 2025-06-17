abstract class IAuthService {
  Future<void> login(String username, String password);
  void logout();
  bool get isLoggedIn;
  String? get token;
}
