import 'package:equatable/equatable.dart';

/// Domain-level error contract exposed outside the data layer.
sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Represents connectivity-related failures (timeouts, no internet, DNS, etc.).
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Represents HTTP/server-side failures with valid connectivity.
final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Represents local persistence/cache read-write failures.
final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Represents uncategorized failures when a specific type is not available.
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
