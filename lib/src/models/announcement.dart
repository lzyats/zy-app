class AnnCertificate {
  int? id = 0;
  String? title = "";
  String? text = "";
  String? ctime = "";
  int? readid = 0;

  AnnCertificate.fromJson(Map<String, dynamic> map)
      : id = map["id"] ?? 0,
        title = map["title"] ?? "",
        text = map["text"] ?? "",
        ctime = map["ctime"] ?? "";

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id!;
    data['title'] = title!;
    data['text'] = text!;
    data['ctime'] = ctime!;
    return data;
  }
}
