/// Generic API response wrapper
class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool isSuccess;
  
  const ApiResponse._({
    this.data,
    this.error,
    required this.isSuccess,
  });
  
  factory ApiResponse.success(T data) {
    return ApiResponse._(
      data: data,
      isSuccess: true,
    );
  }
  
  factory ApiResponse.error(String error) {
    return ApiResponse._(
      error: error,
      isSuccess: false,
    );
  }
  
  /// Check if the response has data
  bool get hasData => data != null;
  
  /// Check if the response has an error
  bool get hasError => error != null;
  
  /// Get data or throw if not available
  T get requireData {
    if (data == null) {
      throw StateError('No data available');
    }
    return data!;
  }
}