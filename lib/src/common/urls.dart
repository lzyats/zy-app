import 'config.dart';

class Urls {
  static var register2 = "${Config.imApiUrl()}/auth/user_register";
  static var login2 = "${Config.imApiUrl()}/auth/user_token";
  static var importFriends = "${Config.imApiUrl()}/friend/import_friend";
  static var inviteToGroup = "${Config.imApiUrl()}/group/invite_user_to_group";
  static var onlineStatus =
      "${Config.imApiUrl()}/manager/get_users_online_status";
  static var queryAllUsers = "${Config.imApiUrl()}/manager/get_all_users_uid";

  /// 登录注册 独立于im的业务
  static var sendMsg = "${Config.imApiUrl()}/manager/send_msg";

  /// office
  static var getUserTags = "${Config.imApiUrl()}/office/get_user_tags";
  static var createTag = "${Config.imApiUrl()}/office/create_tag";
  static var deleteTag = "${Config.imApiUrl()}/office/delete_tag";
  static var updateTag = "${Config.imApiUrl()}/office/set_tag";
  static var sendMsgToTag = "${Config.imApiUrl()}/office/send_msg_to_tag";
  static var getSendTagLog = "${Config.imApiUrl()}/office/get_send_tag_log";

  /// 自构用户业务逻辑
  static var userlogin = "${Config.workUrl()}/api/imuser/login";
  static var regsiter = "${Config.workUrl()}/api/imuser/regsiter";
  static var resetpass = "${Config.workUrl()}/api/imuser/reset_password";
  static var invitecode = "${Config.workUrl()}/api/imuser/invitecode";
  static var safepwd = "${Config.workUrl()}/api/imuser/safepwd";
  static var checkVerificationCode = "${Config.workUrl()}/api/imuser/vercode";
  static var getVerificationCode = "${Config.workUrl()}/api/imuser/code";
  static var getuseraddr = "${Config.workUrl()}/api/imuser/user_addr";
  static var putuseraddr = "${Config.workUrl()}/api/imuser/in_useraddr";
  static var getincode = "${Config.workUrl()}/api/imuser/getincode";
  static var getinlist = "${Config.workUrl()}/api/imuser/getinlist";

  /// 签到业务
  static var exserver_info = "${Config.workUrl()}/api/im/exserver_info";
  static var sing_in = "${Config.workUrl()}/api/im/sign_in";
  static var usdt_addr = "${Config.workUrl()}/api/im/usdt_addr";
  static var usdt_addr_put = "${Config.workUrl()}/api/im/in_usdtaddr";
  static var usdt_tx = "${Config.workUrl()}/api/im/usdt_tx";
  static var getinformation = "${Config.workUrl()}/api/im/get_information";

  ///红包业务geteninfo
  static var setenvelope = "${Config.workUrl()}/api/imenvelope/set_envelope";
  static var getenvelope = "${Config.workUrl()}/api/imenvelope/get_envelope";
  static var doenvelope = "${Config.workUrl()}/api/imenvelope/do_envelope";
  static var geteninfo = "${Config.workUrl()}/api/imenvelope/get_eninfo";

  /// 文件上传地址
  static var minioupfile = "${Config.workUrl()}/api/index/minioupfile";

  /// 升级地址
  //static var updatenew = "http://up.51im.xyz/api/im/get_version";
  static var updatenew = "https://mim.91im.vip/api/im/get_version";
}
