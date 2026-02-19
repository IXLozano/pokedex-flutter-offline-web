import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('REQUEST [${options.method}] ${options.uri}');
      if (options.data != null) {
        debugPrint('Body: ${options.data}');
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('RESPONSE [${response.statusCode}] ${response.requestOptions.uri}');
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('ERROR [${err.response?.statusCode}] ${err.requestOptions.uri}');
      debugPrint('Message: ${err.message}');
    }

    super.onError(err, handler);
  }
}
