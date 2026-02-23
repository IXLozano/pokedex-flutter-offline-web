import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Lightweight network interceptor for development-time traceability.
class LoggingInterceptor extends Interceptor {
  /// Logs outgoing method, URL, and optional body before dispatch.
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

  /// Logs status code and URL for successful responses.
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('RESPONSE [${response.statusCode}] ${response.requestOptions.uri}');
    }

    super.onResponse(response, handler);
  }

  /// Logs status and message for failed requests.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('ERROR [${err.response?.statusCode}] ${err.requestOptions.uri}');
      debugPrint('Message: ${err.message}');
    }

    super.onError(err, handler);
  }
}
