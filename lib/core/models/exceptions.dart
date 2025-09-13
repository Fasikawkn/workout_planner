abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const AppException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode, super.data});
}

class CacheException extends AppException {
  const CacheException({required super.message, super.statusCode, super.data});
}

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

class ParseException extends AppException {
  const ParseException({required super.message, super.statusCode, super.data});
}
