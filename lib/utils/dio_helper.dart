import 'dart:async';

import 'package:tanat/utils/api_response_exception.dart';
import 'package:tanat/utils/log_utils.dart';
import 'package:tanat/utils/standar_exception_class.dart';
import 'package:dio/dio.dart';

Future<DioService> initDioService() async {
  DioService dioService = DioService.instance;
  await dioService.initDio;
  return dioService;
}

Dio get dioInstance => DioService.instance.dio;

DioService get dioServiceInstance => DioService.instance;

class DioService {
  DioService._singleton();

  late final Dio dio;

  static final DioService instance = DioService._singleton();

  Future<void> get initDio async {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: await headers(),
      ),
    );
  }

  void addUserDataToHeaders(String token) {
    dio.options.headers.addAll({'Authorization': 'Bearer $token'});
  }

  Future<void> removeUserDataFromHeaders() async {
    dio.options.headers.remove('Authorization');
  }

  String get baseUrl {
    const String port = "4000";
    const String baseUrl = 'https://localhost:$port';
    LogUtils.logDebug('baseUrl $baseUrl');
    return '$baseUrl/api/v1';
  }

  Future<Map<String, dynamic>> headers() async {
    return {'Accept': 'application/json', 'Content-Type': 'application/json'};
  }

  static Exception handleApiErrors(
    dynamic e, [
    String? indicator,
    dynamic stackTrace,
  ]) {
    //LogUtils.logDebug('Error::::handleDioErrors $e', indicator);
    if (e is! DioException) {
      LogUtils.logDebug('Error::::handleDioErrors $e', indicator);
      throw e;
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw const StandardException(
        'Error de conexión - Asegurese de estar conectado a internet antes de continuar',
      );
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      throw const StandardException(
        'Error de conexión - Asegurese de estar conectado a internet antes de continuar',
      );
    }

    if (e.type == DioExceptionType.badResponse) {
      LogUtils.logDebug('DioErrorType.RESPONSE ${e.response}', indicator);
      if (e.response?.data != null && e.response?.data is Map) {
        final Map<String, dynamic>? data = e.response?.data;
        if (data?['message'] != null) {
          throw ApiResponseException(
            data?['message'] ?? 'Error procesando la solicitud',
            e.response?.statusCode,
            data?['data'],
            data?['code'],
          );
        }
        if (data?['error'] != null) {
          throw ApiResponseException(
            data?['error'] ?? 'Error procesando la solicitud',
          );
        }
      }

      throw const ApiResponseException('Error procesando la solicitud');
    }

    if (e.type == DioExceptionType.cancel) {
      throw 'Canceled by user';
    }

    if (e.type == DioExceptionType.unknown) {
      if (e.error != null) {
        if (e.toString().contains('SocketException')) {
          throw const StandardException(
            'Error de conexión - Asegurese de estar conectado a internet antes de continuar',
          );
        } else {
          LogUtils.logDebug('error default $e');
          throw const StandardException(
            'Ocurrió un error inesperado, por favor intente de nuevo',
          );
        }
      }
    }
    throw const StandardException(
      'Ocurrió un error inesperado, por favor intente de nuevo',
    );
  }
}
