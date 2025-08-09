class SendMsg {
  String serverMsgID;
  String clientMsgID;
  int sendTime;

  SendMsg.fromJson(Map<String, dynamic> map)
      : serverMsgID = map["serverMsgID"],
        clientMsgID = map["clientMsgID"],
        sendTime = map["sendTime"];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['serverMsgID'] = serverMsgID;
    data['clientMsgID'] = clientMsgID;
    data['sendTime'] = sendTime;
    return data;
  }
}
