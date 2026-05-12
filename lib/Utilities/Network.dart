import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }

  NetworkService._internal();

  final String baseUrl = "http://10.0.2.2:3001";

  Future<http.Response> get(String endpoint) async {
    Uri uri=Uri.parse('$baseUrl$endpoint');
    final response = await http.get(uri);
    _handleError(response);
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(),
      body: json.encode(data),
    );
    _handleError(response);
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(),
      body: json.encode(data),
    );
    _handleError(response);
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    _handleError(response);
    return response;
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  void _handleError(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
