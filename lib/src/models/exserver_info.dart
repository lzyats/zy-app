class ExCertificate {
  String? openreg = "0";
  String? openusdtwith = "0";
  String? signusdt = "0";
  String? invitecode = "0";
  String? shownews = "0";
  String? loginweb = "0";
  String? usdttxnum = "0";
  String? activetab = "0";
  String? activeurl = "";
  String? activename = "";
  String? activelevel = "0";
  String? morelang = "0";
  String? openreden = "0";
  String? openredlevel = "0";
  String? redlevel = "1";
  String? opencheckin = "0";
  String? openvidio = "0";
  String? openvoice = "0";
  String? openuserlelvel = "0";
  String? openlocation = "0";
  String? opencards = "0";
  String? importkf = "0";
  List? importkfid = [];
  String? appdown = "";
  String? activelevelmin = "1";

  ExCertificate.fromJson(Map<String, dynamic> map)
      : openreg = map["openreg"] ?? "0",
        openusdtwith = map["openusdtwith"] ?? "0",
        signusdt = map["signusdt"] ?? "0",
        invitecode = map["invitecode"] ?? "0",
        shownews = map["shownews"] ?? "0",
        loginweb = map["loginweb"] ?? "0",
        activetab = map["activetab"] ?? "0",
        activeurl = map["activeurl"] ?? "",
        activename = map["activename"] ?? "",
        activelevel = map["activelevel"] ?? "0",
        activelevelmin = map["activelevelmin"] ?? "1",
        morelang = map["morelang"] ?? "0",
        openreden = map["openreden"] ?? "0",
        openredlevel = map["openredlevel"] ?? "0",
        redlevel = map["redlevel"] ?? "1",
        opencheckin = map["opencheckin"] ?? "0",
        openvidio = map["openvidio"] ?? "0",
        openvoice = map["openvoice"] ?? "0",
        openuserlelvel = map["openuserlelvel"] ?? "0",
        openlocation = map["openlocation"] ?? "0",
        opencards = map["opencards"] ?? "0",
        importkf = map["importkf"] ?? "0",
        importkfid = map["importkfid"] ?? [],
        appdown = map["appdown"] ?? '',
        usdttxnum = map["usdttxnum"] ?? "0";

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['openreg'] = openreg!;
    data['openusdtwith'] = openusdtwith!;
    data['signusdt'] = signusdt!;
    data['invitecode'] = invitecode!;
    data['shownews'] = shownews!;
    data['loginweb'] = loginweb!;
    data['usdttxnum'] = usdttxnum!;
    data['activetab'] = activetab!;
    data['activeurl'] = activeurl!;
    data['activename'] = activename!;
    data['activelevel'] = activelevel!;
    data['morelang'] = morelang!;
    data['openreden'] = openreden!;
    data['openredlevel'] = openredlevel!;
    data['redlevel'] = redlevel!;
    data['opencheckin'] = opencheckin!;
    data['openvidio'] = openvidio!;
    data['openvoice'] = openvoice!;
    data['opencheckin'] = opencheckin!;
    data['openlocation'] = openlocation!;
    data['opencards'] = opencards!;
    data['importkf'] = importkf!;
    data['importkfid'] = importkfid!;
    data['appdown'] = appdown!;
    data['openuserlelvel'] = openuserlelvel!;
    return data;
  }
}
