import '../models/product_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GplPaginatedApi {
  static Future<List<ProductDetail>> fetchFilteredProducts(String query) async {
    final response = await http.get(Uri.parse(
        'https://dev.api.change-networks.com/api/v1/cisco-gpl/get-products?limit=20&page=1&procCode=$query'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List data = jsonBody['data'];
      return data.map((e) => ProductDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
