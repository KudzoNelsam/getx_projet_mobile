import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'i_auth_service.dart';

class AuthService extends GetxService implements IAuthService {
  final _box = Hive.box('authBox');

  final RxBool _isLoggedIn = false.obs;

  @override
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  String? get token => _box.get('token');

  Future<AuthService> init() async {
    final existingToken = _box.get('token');
    _isLoggedIn.value = existingToken != null;
    return this;
  }

  @override
  Future<void> login(String username, String password) async {
    // Ici tu fais ton appel API (ex : via Dio ou autre)
    // Pour l’exemple on suppose que tu reçois un token
    final token = await fakeApiLogin(username, password);
    
    _box.put('token', token);
    _isLoggedIn.value = true;
  }

  @override
  void logout() {
    _box.delete('token');
    _isLoggedIn.value = false;
  }

  // Exemple de simulation d'appel API
  Future<String> fakeApiLogin(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return "FAKE_TOKEN";
  }
}
