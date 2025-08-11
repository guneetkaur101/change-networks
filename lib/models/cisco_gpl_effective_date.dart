class CiscoGplEffectiveDate {
  final String effectiveDate;

  CiscoGplEffectiveDate({required this.effectiveDate});

  factory CiscoGplEffectiveDate.fromJson(Map<String, dynamic> json) {
    return CiscoGplEffectiveDate(
      effectiveDate: json['ciscogplEffectiveDate'],
    );
  }
}
