import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cisco_gpl_effective_date.dart';

class EffectiveDateApiService {
  static Future<CiscoGplEffectiveDate?> fetchEffectiveDate() async {
    final response = await http.get(Uri.parse('https://dev.api.change-networks.com/api/v1/cisco-gpl/effective-date'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      print("API Response: ${response.body}");

      if (jsonBody['success'] && jsonBody['data'].isNotEmpty) {
        return CiscoGplEffectiveDate.fromJson(jsonBody['data'][0]);
      }
    }
    else {
      print('API failed with status code: ${response.statusCode}');
    }
    return null;
  }
}
