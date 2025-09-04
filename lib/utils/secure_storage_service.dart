import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._(this.storage);

  final FlutterSecureStorage storage;

  factory SecureStorageService() {
    AndroidOptions getAndroidOptions() =>
        const AndroidOptions(encryptedSharedPreferences: true);

    return SecureStorageService._(
      FlutterSecureStorage(aOptions: getAndroidOptions()),
    );
  }

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllSecureData() async {
    await storage.deleteAll();
  }
}
