class LoginCertificate {
  String userID;
  String token;
  String? ustoken;

  LoginCertificate.fromJson(Map<String, dynamic> map)
      : userID = map["userID"],
        ustoken = map["ustoken"] ?? '',
        token = map["token"];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userID'] = userID;
    data['ustoken'] = ustoken;
    data['token'] = token;
    return data;
  }
}
