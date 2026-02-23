/// Base exception type used inside the data layer.
sealed class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => '$runtimeType(statusCode: $statusCode, message: $message)';
}

/// Raised for non-connectivity server/API failures.
final class ServerException extends AppException {
  ServerException({required super.message, super.statusCode});
}

/// Raised for connectivity and transport-level failures.
final class NetworkException extends AppException {
  NetworkException({required super.message, super.statusCode});
}

/// Raised for local cache read/write failures.
final class CacheException extends AppException {
  CacheException({required super.message});
}

/// Raised for malformed or unexpected response parsing issues.
final class ParsingException extends AppException {
  ParsingException({required super.message});
}
