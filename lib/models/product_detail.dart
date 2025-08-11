// class ProductDetail {
//   final String procCode;
//   final String proDesc;
//   final double price;
//
//   ProductDetail({
//     required this.procCode,
//     required this.proDesc,
//     required this.price,
//   });
//
//   factory ProductDetail.fromJson(Map<String, dynamic> json) {
//     return ProductDetail(
//       procCode: json['procCode'],
//       proDesc: json['proDesc'],
//       price: json['price']?.toDouble() ?? 0.0,
//     );
//   }
// }

class ProductDetail {
  final String procCode;
  final String proDesc;
  final double price;
  final String eos;

  ProductDetail({
    required this.procCode,
    required this.proDesc,
    required this.price,
    required this.eos,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      procCode: json['procCode'] ?? '',
      proDesc: json['proDesc'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      eos: json['eos'] ?? 'N/A',
    );
  }
}
