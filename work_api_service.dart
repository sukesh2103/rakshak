// File: lib/core/services/api_service.dart
// WORK REQUIRED: Implement HTTP API service for backend communication

import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../utils/api_response.dart';

/// Abstract API service interface
abstract class ApiService {
  Future<ApiResponse<T>> get<T>(String endpoint, {Map<String, dynamic>? queryParameters});
  Future<ApiResponse<T>> post<T>(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters});
  Future<ApiResponse<T>> put<T>(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters});
  Future<ApiResponse<T>> delete<T>(String endpoint, {Map<String, dynamic>? queryParameters});
}

/// Implementation of API service using Dio
class ApiServiceImpl implements ApiService {
  final Dio _dio;
  
  ApiServiceImpl({required Dio dio}) : _dio = dio {
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    // Request interceptor for adding authentication headers
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: Add authentication token to requests
        // final token = await getAuthToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        options.headers['Content-Type'] = 'application/json';
        handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle successful responses
        handler.next(response);
      },
      onError: (error, handler) {
        // Handle API errors
        _handleApiError(error);
        handler.next(error);
      },
    ));
  }
  
  void _handleApiError(DioException error) {
    // TODO: Implement proper error handling and logging
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        print('Connection timeout error');
        break;
      case DioExceptionType.sendTimeout:
        print('Send timeout error');
        break;
      case DioExceptionType.receiveTimeout:
        print('Receive timeout error');
        break;
      case DioExceptionType.badResponse:
        print('Bad response: ${error.response?.statusCode}');
        break;
      case DioExceptionType.cancel:
        print('Request cancelled');
        break;
      case DioExceptionType.unknown:
        print('Unknown error: ${error.message}');
        break;
      default:
        print('API Error: ${error.message}');
    }
  }
  
  @override
  Future<ApiResponse<T>> get<T>(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(_getErrorMessage(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }
  
  @override
  Future<ApiResponse<T>> post<T>(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(endpoint, data: data, queryParameters: queryParameters);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(_getErrorMessage(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }
  
  @override
  Future<ApiResponse<T>> put<T>(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(endpoint, data: data, queryParameters: queryParameters);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(_getErrorMessage(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }
  
  @override
  Future<ApiResponse<T>> delete<T>(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(endpoint, queryParameters: queryParameters);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(_getErrorMessage(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }
  
  String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server response timeout. Please try again.';
      case DioExceptionType.badResponse:
        return _handleHttpError(error.response?.statusCode ?? 0);
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'Network error. Please check your connection.';
      default:
        return 'An unexpected error occurred.';
    }
  }
  
  String _handleHttpError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access forbidden.';
      case 404:
        return 'Resource not found.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'HTTP error: $statusCode';
    }
  }
}

/*
BACKEND INTEGRATION CHECKLIST:
1. Replace base URL in app_config.dart with your actual API endpoint
2. Implement getAuthToken() method to retrieve stored authentication token
3. Add proper error logging (consider using a logging service)
4. Implement refresh token logic for expired tokens
5. Add request retry mechanism for failed requests
6. Configure SSL certificate pinning for production
7. Add request/response logging for debugging
8. Implement proper data serialization/deserialization
9. Add API versioning support
10. Configure timeout values based on your backend requirements

DUMMY API ENDPOINTS (replace with actual ones):
- Auth: POST /auth/login, POST /auth/register, POST /auth/logout
- Emergency Contacts: GET/POST/PUT/DELETE /emergency-contacts
- Alerts: GET/POST /alerts
- Mitigation: GET/POST /mitigation-plans
- Relief: GET/POST /relief-requests
- Notifications: POST /notifications/register-token
*/