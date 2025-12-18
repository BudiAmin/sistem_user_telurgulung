import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  static String get baseUrl {
    final url = dotenv.env['BASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('BASE_URL tidak ditemukan di file .env');
    }
    return url;
  }

  /// LOGIN
  static Future<http.Response> login({
    required String email,
    required String password,
  }) {
    return http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  /// REGISTER
  static Future<http.Response> register({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) {
    return http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
      }),
    );
  }

  /// GET USERS (ADMIN)
  static Future<http.Response> getUsers() {
    return http.get(Uri.parse('$baseUrl/users'));
  }
}
