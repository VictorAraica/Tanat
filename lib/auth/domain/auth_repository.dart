import 'package:tanat/auth/data/api_sources/auth_api_source.dart';
import 'package:tanat/auth/data/local_sources/auth_local_secured_source.dart';
import 'package:tanat/auth/data/local_sources/auth_local_source.dart';
import 'package:tanat/models/create_user_dto.dart';
import 'package:tanat/models/user_app.dart';
import 'package:tanat/utils/standar_exception_class.dart';

class AuthRepository {
  AuthRepository([AuthApiSource? authApiSource])
    : authApiSource = authApiSource ?? AuthApiSource();

  final AuthApiSource authApiSource;
  final AuthLocalSource authLocalSource = AuthLocalSource();
  final AuthLocalSecuredSource authLocalSecuredSource =
      AuthLocalSecuredSource();

  Future<(UserApp, String)> login(String user, String password) async {
    final (UserApp userApp, String token) = await authApiSource.login(
      user,
      password,
    );
    deleteDataIsUserLoggingIsDifferent(userApp.id!);
    await saveUserData(userApp, token);
    return (userApp, token);
  }

  Future<void> deleteDataIsUserLoggingIsDifferent(String user) async {
    final String? previousUser =
        await authLocalSecuredSource.readLastActiveUser();

    if (previousUser != null && previousUser != user) {
      clearUserData(deleteAllData: true);
    }
  }

  Future<(UserApp, String)> loginWithBiometrics() async {
    final String? userLM = await authLocalSecuredSource.getUserLM();
    final String? userP = await authLocalSecuredSource.getUserP();

    if (userLM == null || userP == null) {
      await authLocalSource.clearBiometricAuthData();
      throw const StandardException(
        'Error al obtener datos biométricos, no se puede iniciar sesión',
      );
    }

    final (UserApp userApp, String token) = await authApiSource.login(
      userLM,
      userP,
    );
    await saveUserData(userApp, token);
    return (userApp, token);
  }

  Future<Map<String, dynamic>> checkUserEmail(String email) async {
    final Map<String, dynamic> data = await authApiSource.checkUserEmail(email);
    return data;
  }

  Future<Map<String, dynamic>> validateFields(
    CreateUserDto createUserDto,
  ) async {
    final Map<String, dynamic> data = await authApiSource.validateFields(
      createUserDto,
    );
    return data;
  }

  Future<void> registerUser(CreateUserDto createUserDto) async {
    await authApiSource.registerUser(createUserDto);
    clearUserData(deleteAllData: true);
  }

  Future<(UserApp, String)> registerUserCompletingInfo(
    CreateUserDto createUserDto,
    String tempToken,
  ) async {
    final (UserApp userApp, String token) = await authApiSource
        .registerUserCompletingInfo(createUserDto, tempToken);
    clearUserData(deleteAllData: true);
    await saveUserData(userApp, token);
    return (userApp, token);
  }

  Future<String> changeUserPassword(
    String account,
    String password,
    String otp,
    bool deleteAllUserData,
  ) async {
    final String response = await authApiSource.changeUserPassword(
      account,
      password,
      otp,
    );
    if (deleteAllUserData) {
      clearUserData(deleteAllData: true);
    } else if (await userHasEnableBioAuth()) {
      enableBiometricLogin(account, password);
    }
    return response;
  }

  Future<(UserApp, String)> validateOtp(String otp, String account) async {
    final (UserApp userApp, String token) = await authApiSource.validateOtp(
      otp,
      account,
    );
    await saveUserData(userApp, token);
    return (userApp, token);
  }

  Future<void> resendOtp(String account) async {
    return await authApiSource.resendOtp(account);
  }

  Future<(UserApp? user, String? token)> getCurrentUser() async {
    return authLocalSource.getUserData();
  }

  Future<void> saveUserData(UserApp user, String token) async {
    await authLocalSource.saveUserData(user);
    await authLocalSource.saveToken(token);
    await authLocalSecuredSource.saveLastActiveUser(user.id!);
  }

  Future<void> clearUserData({bool deleteAllData = false}) async {
    if (deleteAllData) {
      await authLocalSource.clearAllUserData();
      return;
    }
    await authLocalSource.clearUserDataKeepingBioState();
  }

  Future<void> updateUserNotificationToken(String token) async {
    final bool updateToken = await authLocalSource
        .isNeedToUpdateNotificationToken(token);
    if (!updateToken) {
      return;
    }
    await authApiSource.updateUserNotificationToken(token);

    await authLocalSource.updateUserNotificationToken(token);
  }

  Future<bool> userHasEnableBioAuth() async {
    return await authLocalSource.userHasEnableBioAuth();
  }

  Future<void> enableBiometricLogin(String u, String p) async {
    await authLocalSecuredSource.saveUserLM(u);
    await authLocalSecuredSource.saveUserP(p);
    await authLocalSource.changeBioAuthState(true);
  }
}
