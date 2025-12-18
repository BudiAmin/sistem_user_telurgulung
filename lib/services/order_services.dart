import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderService {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  /// Ambil token JWT
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// =========================
  /// GET - Order milik USER
  /// =========================
  Future<List<dynamic>> getMyOrders() async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      return result['data'];
    } else {
      throw Exception(result['message'] ?? 'Gagal mengambil order');
    }
  }

  /// =========================
  /// POST - Buat Order
  /// =========================
  Future<bool> createOrder({
    required int productId,
    required int totalBarang,
    bool balado = false,
    bool keju = false,
    bool pedas = false,
    bool asin = false,
    bool barbeque = false,
  }) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'product_id': productId,
        'total_barang': totalBarang,
        'balado': balado,
        'keju': keju,
        'pedas': pedas,
        'asin': asin,
        'barbeque': barbeque,
      }),
    );

    final result = json.decode(response.body);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception(result['message'] ?? 'Gagal membuat order');
    }
  }

  /// =========================
  /// GET - Detail Order USER
  /// =========================
  Future<Map<String, dynamic>> getOrderDetail(int orderId) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/orders/$orderId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      return result['data'];
    } else {
      throw Exception(result['message'] ?? 'Gagal mengambil detail order');
    }
  }
}
