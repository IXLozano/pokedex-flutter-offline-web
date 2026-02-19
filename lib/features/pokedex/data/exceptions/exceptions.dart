sealed class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => '$runtimeType(statusCode: $statusCode, message: $message)';
}

final class ServerException extends AppException {
  ServerException({required super.message, super.statusCode});
}

final class NetworkException extends AppException {
  NetworkException({required super.message, super.statusCode});
}

final class CacheException extends AppException {
  CacheException({required super.message});
}

final class ParsingException extends AppException {
  ParsingException({required super.message});
}
