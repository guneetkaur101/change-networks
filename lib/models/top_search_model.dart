// models/top_search_model.dart

class TopSearchProduct {
  final String id;
  final String procCode;
  final String proDesc;
  final int searchFrequency;

  TopSearchProduct({
    required this.id,
    required this.procCode,
    required this.proDesc,
    required this.searchFrequency,
  });

  factory TopSearchProduct.fromJson(Map<String, dynamic> json) {
    return TopSearchProduct(
      id:json['_id'],
      procCode: json['procCode'],
      proDesc: json['proDesc'],
      searchFrequency: json['searchFrequency'],
    );
  }
}
