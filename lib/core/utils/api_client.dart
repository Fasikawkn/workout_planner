import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../models/exceptions.dart';

@Injectable()
class ApiClient {
  final http.Client _client;
  final Duration _timeout;

  ApiClient() : _client = http.Client(), _timeout = const Duration(seconds: 30);

  /// Generic GET request
  Future<dynamic> get(
    String route, {
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
  }) async {
    return _makeRequest(
      () => _client.get(
        _buildUri(route, parameters),
        headers: _buildHeaders(headers),
      ),
    );
  }

  /// Generic POST request
  Future<dynamic> post(
    String route, {
    Map<String, dynamic>? parameters,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _makeRequest(
      () => _client.post(
        _buildUri(route, parameters),
        headers: _buildHeaders(headers),
        body: body != null ? json.encode(body) : null,
      ),
    );
  }

  /// Generic PUT request
  Future<dynamic> put(
    String route, {
    Map<String, dynamic>? parameters,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _makeRequest(
      () => _client.put(
        _buildUri(route, parameters),
        headers: _buildHeaders(headers),
        body: body != null ? json.encode(body) : null,
      ),
    );
  }

  /// Generic DELETE request
  Future<dynamic> delete(
    String route, {
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
  }) async {
    return _makeRequest(
      () => _client.delete(
        _buildUri(route, parameters),
        headers: _buildHeaders(headers),
      ),
    );
  }

  /// Make HTTP request with proper error handling
  Future<dynamic> _makeRequest(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(_timeout);
      return _handleResponse(response);
    } on TimeoutException {
      throw const NetworkException(
        message: 'Request timeout. Please check your internet connection.',
        statusCode: 408,
      );
    } on SocketException {
      throw const NetworkException(
        message: 'No internet connection. Please check your network settings.',
        statusCode: 0,
      );
    } on HttpException catch (e) {
      throw NetworkException(
        message: 'Network error: ${e.message}',
        statusCode: 0,
      );
    } catch (e) {
      throw NetworkException(
        message: 'Unexpected error occurred: $e',
        statusCode: 0,
      );
    }
  }

  /// Handle HTTP response
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        try {
          if (response.body.isEmpty) return null;
          return json.decode(response.body);
        } catch (e) {
          throw ParseException(
            message: 'Failed to parse response: $e',
            statusCode: response.statusCode,
            data: response.body,
          );
        }
      case 400:
        throw ValidationException(
          message: _extractErrorMessage(response.body, 'Bad request'),
          statusCode: response.statusCode,
          data: response.body,
        );
      case 401:
        throw ServerException(
          message: _extractErrorMessage(response.body, 'Unauthorized'),
          statusCode: response.statusCode,
          data: response.body,
        );
      case 403:
        throw ServerException(
          message: _extractErrorMessage(response.body, 'Forbidden'),
          statusCode: response.statusCode,
          data: response.body,
        );
      case 404:
        throw ServerException(
          message: _extractErrorMessage(response.body, 'Resource not found'),
          statusCode: response.statusCode,
          data: response.body,
        );
      case 500:
      case 502:
      case 503:
        throw ServerException(
          message: _extractErrorMessage(response.body, 'Server error'),
          statusCode: response.statusCode,
          data: response.body,
        );
      default:
        throw ServerException(
          message: _extractErrorMessage(
            response.body,
            'HTTP ${response.statusCode}: ${response.reasonPhrase}',
          ),
          statusCode: response.statusCode,
          data: response.body,
        );
    }
  }

  /// Extract error message from response body
  String _extractErrorMessage(String responseBody, String fallback) {
    try {
      final decoded = json.decode(responseBody);
      if (decoded is Map<String, dynamic>) {
        return decoded['message'] ??
            decoded['error'] ??
            decoded['detail'] ??
            fallback;
      }
    } catch (_) {
      // If parsing fails, return fallback
    }
    return fallback;
  }

  /// Build URI with query parameters
  Uri _buildUri(String route, Map<String, dynamic>? parameters) {
    final uri = Uri.parse(route);

    if (parameters != null && parameters.isNotEmpty) {
      final queryParams = <String, String>{};
      parameters.forEach((key, value) {
        queryParams[key] = value.toString();
      });
      return uri.replace(queryParameters: queryParams);
    }

    return uri;
  }

  /// Build headers with default content type
  Map<String, String> _buildHeaders(Map<String, String>? headers) {
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return defaultHeaders;
  }

  /// Dispose resources
  void dispose() {
    _client.close();
  }
}
