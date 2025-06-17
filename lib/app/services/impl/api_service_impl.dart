import 'package:default_projec/app/constants/api_constants.dart';
import 'package:default_projec/app/services/api_service.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl implements ApiService {
  @override
  Future<T> delete<T>(
    String endPoint, {
    String? baseUrl,
    Map<String, String>? headers,
  }) {
    String fullUrl = baseUrl != null
        ? '$baseUrl$endPoint'
        : '${ApiConstants.baseUrl}/$endPoint';
    return http.delete(Uri.parse(fullUrl), headers: headers).then((response) {
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body as T; // Adjust the type as needed
      } else {
        throw Exception('Failed to delete data');
      }
    });
  }

  @override
  Future<T> get<T>(
    String endPoint, {
    String? baseUrl,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) {
    String fullUrl = baseUrl != null
        ? '$baseUrl$endPoint'
        : '${ApiConstants.baseUrl}/$endPoint';
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map(
            (entry) =>
                '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
          )
          .join('&');
      fullUrl += '?$queryString';
    }
    return http.get(Uri.parse(fullUrl), headers: headers).then((response) {
      if (response.statusCode == 200) {
        return response.body as T; // Adjust the type as needed
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  @override
  Future<T> post<T>(
    String url, {
    String? baseUrl,
    body,
    Map<String, String>? headers,
  }) {
    String fullUrl = baseUrl != null
        ? '$baseUrl$url'
        : '${ApiConstants.baseUrl}/$url';
    return http.post(Uri.parse(fullUrl), body: body, headers: headers).then((
      response,
    ) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body as T; // Adjust the type as needed
      } else {
        throw Exception('Failed to post data');
      }
    });
  }

  @override
  Future<T> put<T>(
    String url, {
    String? baseUrl,
    body,
    Map<String, String>? headers,
  }) {
    String fullUrl = baseUrl != null
        ? '$baseUrl$url'
        : '${ApiConstants.baseUrl}/$url';
    return http.put(Uri.parse(fullUrl), body: body, headers: headers).then((
      response,
    ) {
      if (response.statusCode == 200) {
        return response.body as T; // Adjust the type as needed
      } else {
        throw Exception('Failed to update data');
      }
    });
  }
}
