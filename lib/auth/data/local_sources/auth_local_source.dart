import 'dart:convert';

import 'package:tanat/models/user_app.dart';
import 'package:tanat/service_locator.dart';
import 'package:tanat/utils/log_utils.dart';
import 'package:tanat/utils/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalSource {
  final SharedPreferences sharedPreferences =
      serviceLocator<SharedPreferences>();

  Future<(UserApp? user, String? token)> getUserData() async {
    final String? userData = sharedPreferences.getString('user_data');
    final String? token = sharedPreferences.getString('token');
    if (userData == null || token == null) {
      return (null, null);
    }
    return (UserApp.fromJson(jsonDecode(userData)), token);
  }

  Future<UserApp?> getUser() async {
    final String? userData = sharedPreferences.getString('user_data');
    if (userData == null) {
      return null;
    }
    return UserApp.fromJson(jsonDecode(userData));
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  Future<String?> getToken() async {
    return sharedPreferences.getString('token');
  }

  Future<void> saveUserData(UserApp user) async {
    await sharedPreferences.setString('user_data', jsonEncode(user.toJson()));
  }

  Future<bool> isNeedToUpdateNotificationToken(String notificationToken) async {
    final String? localNotificationToken = sharedPreferences.getString(
      'notification_token',
    );

    if (localNotificationToken == null ||
        localNotificationToken != notificationToken) {
      return true;
    }

    return false;
  }

  Future<void> updateUserNotificationToken(String notificationToken) async {
    await sharedPreferences.setString('notification_token', notificationToken);
  }

  Future<void> clearUserDataKeepingBioState() async {
    final bool bioAuth = await userHasEnableBioAuth();
    await sharedPreferences.clear();
    await changeBioAuthState(bioAuth);
  }

  Future<void> clearAllUserData() async {
    LogUtils.logDebug('-----Clearing all user data-----');
    serviceLocator<SecureStorageService>().deleteAllSecureData();
    await sharedPreferences.clear();
  }

  Future<bool> userHasEnableBioAuth() async {
    return sharedPreferences.getBool('bio_auth') ?? false;
  }

  Future<void> changeBioAuthState(bool state) async {
    await sharedPreferences.setBool('bio_auth', state);
  }

  Future<void> clearBiometricAuthData() async {
    await sharedPreferences.remove('bio_auth');
  }
}
