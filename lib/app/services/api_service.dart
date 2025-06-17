abstract class ApiService {
  /// GET request
  Future<T> get<T>(
    String url, {
    String? baseUrl,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  });

  /// POST request
  Future<T> post<T>(
    String url, {
    String? baseUrl,
    dynamic body,
    Map<String, String>? headers,
  });

  /// PUT request
  Future<T> put<T>(
    String url, {
    String? baseUrl,
    dynamic body,
    Map<String, String>? headers,
  });

  /// DELETE request
  Future<T> delete<T>(
    String url, {
    String? baseUrl,
    Map<String, String>? headers,
  });
}
