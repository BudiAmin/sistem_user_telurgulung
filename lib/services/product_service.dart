import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductService {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  /// =========================
  /// GET - List Produk (USER)
  /// =========================
  Future<List<dynamic>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      return result['data'];
    } else {
      throw Exception(result['message'] ?? 'Gagal mengambil produk');
    }
  }

  /// =========================
  /// GET - Detail Produk (USER)
  /// =========================
  Future<Map<String, dynamic>> getProductDetail(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$productId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      return result['data'];
    } else {
      throw Exception(result['message'] ?? 'Gagal mengambil detail produk');
    }
  }
}
