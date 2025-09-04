import 'package:tanat/service_locator.dart';
import 'package:tanat/utils/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalSecuredSource {
  final FlutterSecureStorage _secureStorage =
      serviceLocator<SecureStorageService>().storage;

  Future<void> saveLastActiveUser(String id) async {
    await _secureStorage.write(key: 'last_active_user', value: id);
  }

  Future<String?> readLastActiveUser() async {
    return await _secureStorage.read(key: 'last_active_user');
  }

  Future<void> saveUserLM(String userLM) async {
    await _secureStorage.write(key: 'user_lm', value: userLM);
  }

  Future<void> saveUserP(String userP) async {
    await _secureStorage.write(key: 'user_p', value: userP);
  }

  Future<String?> getUserLM() async {
    return await _secureStorage.read(key: 'user_lm');
  }

  Future<String?> getUserP() async {
    return await _secureStorage.read(key: 'user_p');
  }
}
