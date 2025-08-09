import 'package:openim_enterprise_chat/src/res/strings.dart';

class ErrorInfo {
  static Map<String, String> errorlist = {
    '12001': StrRes.loginerr,
    '12002': StrRes.loginerrpass,
    '12003': StrRes.loginnouse,
    '12005': StrRes.Immediatelyerr,
    '12006': StrRes.regerror1,
    '12007': StrRes.regerror2,
    '12008': StrRes.regerror3,
    '12009': StrRes.regerror4,
    '12010': StrRes.plsInputRightEmail,
    '12011': StrRes.Immediatelyerr,
  };

  /// 获取输出值
  static String geterrstr(String errcode) {
    String out = StrRes.unerror;
    errorlist.forEach((key, value) {
      if (key == errcode) out = value;
    });
    return out;
  }
}
