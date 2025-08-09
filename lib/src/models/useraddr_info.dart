class UserAddrCertificate {
  String? addr = '';
  String? citys = '';

  UserAddrCertificate.fromJson(Map<String, dynamic> map)
      : addr = map["addr"] ?? '',
        citys = map["citys"] ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['addr'] = addr;
    data['citys'] = citys;
    return data;
  }
}
