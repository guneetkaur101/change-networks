import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_detail.dart';

class ProductDetailApi {
  static Future<ProductDetail?> fetchProductDetail(String procCode) async {
    final uri = Uri.parse('https://dev.api.change-networks.com/api/v1/cisco-gpl/productcode');
    final response = await http.get(uri.replace(queryParameters: {'procCode': procCode}));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody['success']) {
        return ProductDetail.fromJson(jsonBody['data']);
      }
    }
    return null;
  }
}
