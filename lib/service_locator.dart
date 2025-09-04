import 'dart:async';

import 'package:tanat/utils/local_auth_service.dart';
import 'package:tanat/utils/secure_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

  serviceLocator.registerSingleton<SecureStorageService>(
    SecureStorageService(),
  );
  serviceLocator.registerSingleton<LocalAuthService>(LocalAuthService());

  await serviceLocator<LocalAuthService>().init();
}
