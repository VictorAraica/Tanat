import 'package:tanat/models/create_user_dto.dart';
import 'package:tanat/models/user_app.dart';
import 'package:tanat/utils/dio_helper.dart';
import 'package:tanat/utils/log_utils.dart';
import 'package:dio/dio.dart';

class AuthApiSource {
  Dio dio = dioInstance;

  Future<(UserApp, String token)> login(String user, String password) async {
    try {
      final Response response = await dio.post(
        '/auth/login',
        data: {'username': user, 'password': password},
      );

      LogUtils.logDebug('login response: ${response.data}');

      return (
        UserApp.fromJson(response.data['data']['user']),
        response.data['data']['accessToken'] as String,
      );
    } catch (e) {
      throw DioService.handleApiErrors(e, 'Error::::login');
    }
  }

  Future<Map<String, dynamic>> checkUserEmail(String email) async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .post<Map<String, dynamic>>(
            '/auth/checkIfEmailExists',
            data: {'email': email},
          );
      LogUtils.logDebug('data from checkUserEmail: ${response.data}');
      return response.data!['data'];
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::checkUserEmail');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> validateFields(
    CreateUserDto createUserDto,
  ) async {
    try {
      LogUtils.logDebug('data ${createUserDto.toJson()}');
      final Response<Map<String, dynamic>> response = await dio
          .post<Map<String, dynamic>>(
            '/auth/verifyRegisterData',
            data: createUserDto.toJson(),
          );
      LogUtils.logDebug('data from validateFields: ${response.data}');
      return response.data?['data'] ?? {};
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::validateFields');
      rethrow;
    }
  }

  Future<void> registerUser(CreateUserDto createUserDto) async {
    try {
      await dio.post('/auth/registerNewUser', data: createUserDto.toJson());
    } catch (e) {
      throw DioService.handleApiErrors(e, 'Error::::registerUser');
    }
  }

  Future<String> changeUserPassword(
    String account,
    String password,
    String otp,
  ) async {
    try {
      final Response response = await dio.patch(
        '/auth/resetPassword',
        data: {
          'account': account,
          'password': password,
          'confirmPassword': password,
          'otp': otp,
        },
      );

      return response.data['message'] as String;
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::changeUserPassword');
      rethrow;
    }
  }

  Future<(UserApp, String token)> validateOtp(
    String otp,
    String account,
  ) async {
    try {
      final Response response = await dio.post(
        '/auth/verifyOtp',
        data: {'account': account, 'otp': otp},
      );

      LogUtils.logDebug('data from validateOtp: ${response.data}');
      return (
        UserApp.fromJson(response.data['data']['user']),
        response.data['data']['accessToken'] as String,
      );
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::validateOtp');
      rethrow;
    }
  }

  Future<void> resendOtp(String account) async {
    try {
      final Response response = await dio.post(
        '/auth/sendOtp',
        data: {'account': account},
      );
      return response.data;
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::resendOtp');
      rethrow;
    }
  }

  Future<void> updateUserNotificationToken(String notificationToken) async {
    try {
      await dio.put('/users/pushToken', data: {'pushToken': notificationToken});
      return;
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::updateUserNotificationToken');
      rethrow;
    }
  }

  Future getSetting() async {
    try {
      final Response response = await dio.get('/settings');
      return response.data['data'];
    } catch (e) {
      DioService.handleApiErrors(e, 'Error::::getSettings');
      rethrow;
    }
  }
}
