class UsdtCertificate {
  String? addr = '';

  UsdtCertificate.fromJson(Map<String, dynamic> map) : addr = map["addr"] ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['addr'] = addr;
    return data;
  }
}
