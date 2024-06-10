import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    if (kDebugMode) {
      print('REQUEST HEADERS: ${options.headers}');
    }
    if (kDebugMode) {
      print('REQUEST DATA: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}');
    }
    return handler.next(err);
  }
}

class DioService {
  final Dio dio;

  DioService()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(milliseconds: 10000),
            receiveTimeout: const Duration(milliseconds: 60000),
          ),
        ) {
    dio.interceptors.add(LoggingInterceptor());
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
          'deviceId': '12',
          'deviceOS': 'ANDROID',
          'deviceType': 'sda',
          'appVersion': 'dsada'
        },
      );
      if (kDebugMode) {
        print('Login response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print('Dio error: ${e.message}');
        }
        throw Exception('Failed to login');
      } else {
        if (kDebugMode) {
          print('Other error: $e');
        }
        throw Exception('Failed to login');
      }
    }
  }
}

class ApiConstants {
  static const String baseUrl = "https://score-up.velox.am/";
  static const String login = "api/user/login";
}
