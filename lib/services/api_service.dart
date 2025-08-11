// services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/top_search_model.dart';

class ApiService {
  static const String baseUrl = 'https://dev.api.change-networks.com';

  static Future<List<TopSearchProduct>> fetchTopSearchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/cisco-gpl/top-search'));
    print("API Response Code: ${response.statusCode}");
    // print("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((e) => TopSearchProduct.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
