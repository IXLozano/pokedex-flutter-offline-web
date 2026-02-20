import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex_flutter_offline_web/core/network/logging_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(LoggingInterceptor());

    if (kDebugMode) dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
