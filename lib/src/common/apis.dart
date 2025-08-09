import 'dart:io';
import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:openim_enterprise_chat/src/common/urls.dart';
import 'package:openim_enterprise_chat/src/models/login_certificate.dart';
import 'package:openim_enterprise_chat/src/models/online_status.dart';
import 'package:openim_enterprise_chat/src/models/upgrade_info.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/sdk_extension/message_manager.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/utils/http_util.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';

import '../models/tag_group.dart';
import '../models/tag_notification.dart';
import 'config.dart';
import 'package:openim_enterprise_chat/src/models/send_msg.dart';

class Apis {
  static int get _platform =>
      Platform.isAndroid ? IMPlatform.android : IMPlatform.ios;
  static final openIMMemberIDS = [
    "18349115126",
    "13918588195",
    "17396220460",
    "18666662412"
  ];

  static final openIMGroupID = '2a90f8c6f37edafd19c0ad8a9f4d347a';

  /// im登录，App端不再使用，该方法应该在业务服务端调用
  static Future<LoginCertificate> loginIM(String uid) async {
    try {
      var data = await HttpUtil.post(Urls.login2, data: {
        'secret': Config.secret,
        'platform': _platform,
        'userID': uid,
        'operationID': _getOperationID(),
      });
      return LoginCertificate.fromJson(data!);
    } catch (e) {
      print('e:$e');
      return Future.error(e);
    }
  }

  /// 获取验证码
  static Future<bool> requestVerificationCode({
    String? areaCode,
    String? phoneNumber,
    String? email,
  }) async {
    return HttpUtil.post(
      Urls.getVerificationCode,
      data: {
        "areaCode": areaCode,
        "phoneNumber": phoneNumber,
        "email": email,
        'operationID': _getOperationID(),
      },
    ).then((value) {
      IMWidget.showToast(StrRes.sentSuccessfully);
      return true;
    }).catchError((e) {
      print('e:$e');
      // var error = e as DioError;
      // IMWidget.showToast('发送失败:${error.response}');
      return false;
    });
  }

  /// 校验验证码
  static Future<dynamic> checkVerificationCode({
    String? areaCode,
    String? phoneNumber,
    String? email,
    required String verificationCode,
  }) {
    return HttpUtil.post(
      Urls.checkVerificationCode,
      data: {
        "phoneNumber": phoneNumber,
        "areaCode": areaCode,
        "email": email,
        "verificationCode": verificationCode,
        'operationID': _getOperationID(),
      },
    );
  }

  /// 查询tag组
  static Future<TagGroup> getUserTags() {
    return HttpUtil.post(
      Urls.getUserTags,
      data: {'operationID': _getOperationID()},
      options: _tokenOptions(),
    ).then((value) => TagGroup.fromJson(value));
  }

  /// 创建tag
  static createTag({
    required String tagName,
    required List<String> userIDList,
  }) {
    return HttpUtil.post(
      Urls.createTag,
      data: {
        'tagName': tagName,
        'userIDList': userIDList,
        'operationID': _getOperationID(),
      },
      options: _tokenOptions(),
    );
  }

  /// 创建tag
  static deleteTag({
    required String tagID,
  }) {
    return HttpUtil.post(
      Urls.deleteTag,
      data: {
        'tagID': tagID,
        'operationID': _getOperationID(),
      },
      options: _tokenOptions(),
    );
  }

  /// 创建tag
  static updateTag({
    required String tagID,
    required String newName,
    required List<String> increaseUserIDList,
    required List<String> reduceUserIDList,
  }) {
    return HttpUtil.post(
      Urls.updateTag,
      data: {
        'tagID': tagID,
        'newName': newName,
        'increaseUserIDList': increaseUserIDList,
        'reduceUserIDList': reduceUserIDList,
        'operationID': _getOperationID(),
      },
      options: _tokenOptions(),
    );
  }

  /// 下发tag通知
  static sendMsgToTag({
    String? url,
    int? duration,
    String? text,
    List<String> tagIDList = const [],
    List<String> userIDList = const [],
    List<String> groupIDList = const [],
  }) async {
    return HttpUtil.post(
      Urls.sendMsgToTag,
      data: {
        'tagList': tagIDList,
        'userList': userIDList,
        'groupList': groupIDList,
        'senderPlatformID': _platform,
        'content': {
          'data': {
            "customType": CustomMessageType.tag_message,
            "data": {
              'url': url,
              'duration': duration,
              'text': text,
            },
          },
          'extension': '',
          'description': '',
        },
        'operationID': _getOperationID(),
      },
      options: _tokenOptions(),
    );
  }

  /// 获取tag通知列表
  static Future<TagNotification> getSendTagLog({
    required int pageNumber,
    required int showNumber,
  }) async {
    return HttpUtil.post(
      Urls.getSendTagLog,
      data: {
        'pageNumber': pageNumber,
        'showNumber': showNumber,
        'operationID': _getOperationID(),
      },
      options: _tokenOptions(),
    ).then((value) => TagNotification.fromJson(value));
  }

  //////////////////////////////////////////新IM业务逻辑//////////////////////////////////////////////////

  //获取服务器基本配置
  static Future<dynamic> ex_server() async {
    return HttpUtil.post(
      Urls.exserver_info,
      data: {
        'secret': Config.secret,
        'operationID': _getOperationID(),
      },
    );
  }

  //每日签到
  static Future<dynamic> sing_in(
      {required String? uid,
      required String? ex,
      required String? token}) async {
    return HttpUtil.post(
      Urls.sing_in,
      data: {
        "uid": uid,
        'secret': Config.secret,
        'usdt': ex,
        'token': token,
        'operationID': _getOperationID(),
      },
    );
  }

  //获取钱包地址信息
  static Future<dynamic> get_usdt_addr({required String? uid}) async {
    return HttpUtil.post(
      Urls.usdt_addr,
      data: {"uid": uid},
    );
  }

  /// 设置钱包地址
  static Future<dynamic> putusdtaddr({
    required String? uid,
    required String? addr,
  }) async {
    var operationID = _getOperationID();
    var token = gettoken(4, operationID);
    return HttpUtil.post(
      Urls.usdt_addr_put,
      data: {
        "uid": uid,
        'addr': addr,
        'operationID': operationID,
        'token': token
      },
    );
  }

  //获取收货地址信息
  static Future<dynamic> getuseraddr({required String? uid}) async {
    return HttpUtil.post(
      Urls.getuseraddr,
      data: {"uid": uid},
    );
  }

  //获取推广码getinlist
  static Future<dynamic> getincode({required String? uid}) async {
    return HttpUtil.post(
      Urls.getincode,
      data: {"uid": uid},
    );
  }

  //获取推广列表
  static Future<dynamic> getinlist(
      {required String? uid, int? page = 1}) async {
    var operationID = _getOperationID();
    var token = gettoken(4, operationID);
    return HttpUtil.post(
      Urls.getinlist,
      data: {
        "uid": uid,
        'page': page,
        'operationID': operationID,
        'token': token
      },
    );
  }

  /// 设置收货地址
  static Future<dynamic> putuseraddr({
    required String? uid,
    required String? addr,
    required String? citys,
  }) async {
    var operationID = _getOperationID();
    var token = gettoken(5, operationID);
    return HttpUtil.post(
      Urls.putuseraddr,
      data: {
        "uid": uid,
        'addr': addr,
        'citys': citys,
        'operationID': operationID,
        'token': token
      },
    );
  }

  ///注册账号
  static Future<LoginCertificate> regsiter({
    String? areaCode,
    String? phoneNumber,
    String? email,
    String? invitecode,
    required String password,
    required String nickname,
    required String faceURL,
    required String verificationCode,
  }) async {
    try {
      var data = await HttpUtil.post(Urls.regsiter,
          data: {
            "areaCode": areaCode,
            'phoneNumber': phoneNumber,
            'email': email,
            'password': IMUtil.generateMD5(password),
            'verificationCode': '666666',
            'invitecode': invitecode,
            'nickname': nickname,
            'faceURL': faceURL,
            'platform':
                Platform.isAndroid ? IMPlatform.android : IMPlatform.ios,
            'operationID': _getOperationID(),
          },
          check: true);
      return LoginCertificate.fromJson(data!);
    } catch (e) {
      print('e:$e');
      // var error = e as DioError;
      // IMWidget.showToast('注册失败，请联系管理员:${error.response}');
      return Future.error(e);
    }
  }

  ///
  static Future<dynamic> checkinvitecode({required String? invitecode}) async {
    return HttpUtil.post(Urls.invitecode,
        data: {
          "invitecode": invitecode,
          'secret': Config.secret,
          'operationID': _getOperationID()
        },
        check: true);
  }

  /// 用户登录
  static Future<LoginCertificate> userlogin({
    required String? areaCode,
    required String? phoneNumber,
    String? email,
    required String? password,
    bool? silent,
  }) async {
    var data = await HttpUtil.post(Urls.userlogin,
        data: {
          "areaCode": areaCode,
          'phoneNumber': phoneNumber,
          "email": email,
          'password': IMUtil.generateMD5(password!),
          'platform': _platform,
          'operationID': _getOperationID(),
          'silent': silent
        },
        check: true);
    return LoginCertificate.fromJson(data!);
  }

  ///重设密码
  static Future<dynamic> resetpass({
    String? areaCode,
    String? phoneNumber,
    String? email,
    required String password,
    required String verificationCode,
  }) {
    return HttpUtil.post(Urls.resetpass, data: {
      "areaCode": areaCode,
      'phoneNumber': phoneNumber,
      'email': email,
      'newPassword': IMUtil.generateMD5(password),
      'verificationCode': verificationCode,
      'platform': Platform.isAndroid ? IMPlatform.android : IMPlatform.ios,
      'operationID': _getOperationID(),
    });
  }

  ///验证支付密码
  static Future<dynamic> safepwd({
    required String uid,
    required String password,
    required int usedFor,
  }) {
    var operationID = _getOperationID();
    var token = gettoken(5, operationID);
    return HttpUtil.post(Urls.safepwd, data: {
      "uid": uid,
      'password': IMUtil.generateMD5(password),
      'usedFor': usedFor,
      'operationID': operationID,
      'token': token
    });
  }

  /// 提现申请
  static Future<dynamic> cashusdt(
      {required String? uid,
      required double? usdt,
      required double? donum,
      required String? token}) async {
    return HttpUtil.post(
      Urls.usdt_tx,
      data: {
        "uid": uid,
        'secret': Config.secret,
        'usdt': usdt,
        'donum': donum,
        'token': token,
        'operationID': _getOperationID()
      },
    );
  }

  /// 获取公告信息
  static Future<dynamic> getinformation(String? id) async {
    return HttpUtil.post(
      Urls.getinformation,
      data: {
        'id': id,
        'secret': Config.secret,
        'operationID': _getOperationID()
      },
    );
  }

  /// 发红包
  static Future<dynamic> setenvelope(
      String uid,
      String rid,
      int types,
      int members,
      double money,
      String extension,
      String groupid,
      String description,
      String lid) async {
    return HttpUtil.post(
      Urls.setenvelope,
      data: {
        'uid': uid,
        'rid': rid,
        'types': types,
        'members': members,
        'money': money,
        'extension': extension,
        'groupid': groupid,
        'description': description,
        'operationID': lid,
        'secret': Config.secret
      },
    );
  }

  /// 获取红包信息
  static Future<dynamic> getenvelope(String lid) async {
    return HttpUtil.post(
      Urls.getenvelope,
      data: {
        'lid': lid,
        'operationID': _getOperationID(),
        'secret': Config.secret
      },
    );
  }

  /// 发红包
  static Future<dynamic> doenvelope(
    String rlid,
    String rrid,
  ) async {
    return HttpUtil.post(
      Urls.doenvelope,
      data: {'rlid': rlid, 'rrid': rrid, 'secret': Config.secret},
    );
  }

  /// 获取红包全部详情(领取信息)
  static Future<dynamic> geteninfo(String lid, String uid) async {
    return HttpUtil.post(
      Urls.geteninfo,
      data: {'lid': lid, 'uid': uid, 'operationID': _getOperationID()},
    );
  }

  ///加密验证
  static gettoken(int pnum, String operationID) {
    String token = IMUtil.generateMD5(
        pnum.toString() + Config.secret + operationID + pnum.toString());
    return token;
  }

  /// 文件上传
  static Future<String> minioupfile({
    required String path,
    required String name,
  }) async {
    var burl = '';
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(path, filename: name),
      });
      Dio dio = new Dio();
      Response result = await dio.post(
        Urls.minioupfile,
        data: formData,
        onSendProgress: (int progress, int total) {
          print("当前进度是 $progress 总进度是 $total");
        },
      );
      Map nickname = jsonDecode(result.toString());
      //如果成功就吐司
      if (nickname['code'] == 200) {
        burl = nickname['data'].toString();
        //返回个人档案界面
      }
    } catch (e) {
      print('e:$e');
    }
    return burl;
  }

  //////////////////////以下功能不应该出现在app里///////////////////////////////////
  /// 为用户导入好友OpenIM成员
  static Future<bool> importFriends({
    required String uid,
    required List memberIDS,
    required String token,
  }) async {
    try {
      await HttpUtil.post(
        Urls.importFriends,
        data: {
          "friendUserIDList": memberIDS,
          "fromUserID": uid,
          'operationID': _getOperationID(),
        },
        options: Options(headers: {'token': token}),
      );
      return true;
    } catch (e) {
      print('e:$e');
    }
    return false;
  }

  /// 拉用户进OpenIM官方体验群
  static Future<bool> inviteToGroup({
    required String uid,
    required String token,
  }) async {
    try {
      await dio.post(
        Urls.inviteToGroup,
        data: {
          "groupID": openIMGroupID,
          "uidList": [uid],
          "reason": "Welcome join openim group",
          'operationID': _getOperationID(),
        },
        options: Options(headers: {'token': token}),
      );
      return true;
    } catch (e) {
      print('e:$e');
    }
    return false;
  }

  /// 管理员调用获取IM已经注册的所有用户的userID接口
  static Future<List<String>?> queryAllUsers() async {
    try {
      var data = await loginIM('openIM123456');
      var list = await HttpUtil.post(
        Urls.queryAllUsers,
        data: {'operationID': _getOperationID()},
        options: Options(headers: {'token': data.token}),
      );
      return list.cast<String>();
    } catch (e) {
      print('e:$e');
    }
    return null;
  }

  /// 蒲公英更新检测
  static Future<UpgradeInfoV2> checkUpgradeV2() {
    Dio dio = new Dio();
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 300000;
    return dio.post<Map<String, dynamic>>(
      //'https://www.pgyer.com/apiv2/app/check',
      Urls.updatenew,
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
      data: {
        '_api_key': '17cbaafefd116c493af2130a0922cebc',
        'appKey': 'bc40c8acd98a8e7ebb7f7682ac1c2a96',
      },
    ).then((resp) {
      //resp = jsonDecode(resp);
      //log(resp.data.toString());
      //resp = jsonDecode(resp);
      Map<String, dynamic> map = resp.data!;
      if (map['code'] == 0) {
        map['data']['needForceUpdate'] = false;
        map['data']['buildHaveNewVersion'] = false;
        if (map['data']['needForceUpdate'] == 'true') {
          map['data']['needForceUpdate'] = true;
        }
        if (map['data']['buildHaveNewVersion'] == 'true') {
          map['data']['buildHaveNewVersion'] = true;
        }
        return UpgradeInfoV2.fromJson(map['data']);
      }
      return Future.error(map);
    });
  }

  static Future<List<OnlineStatus>> _onlineStatus({
    required List<String> uidList,
    required String token,
  }) async {
    var resp = await dio.post<Map<String, dynamic>>(
      Urls.onlineStatus,
      data: {
        'operationID': _getOperationID(),
        "secret": Config.secret,
        "userIDList": uidList,
      },
      options: Options(headers: {'token': token}),
    );
    Map<String, dynamic> map = resp.data!;
    if (map['errCode'] == 0) {
      return (map['data'] as List)
          .map((e) => OnlineStatus.fromJson(e))
          .toList();
    }
    return Future.error(map);
  }

  /// 每次最多查询200条
  static void queryOnlineStatus({
    required List<String> uidList,
    Function(Map<String, String>)? onlineStatusDescCallback,
    Function(Map<String, bool>)? onlineStatusCallback,
  }) async {
    return;
    if (uidList.isEmpty) return;
    var data = await Apis.loginIM('openIM123456');
    var batch = uidList.length ~/ 200;
    var remainder = uidList.length % 200;
    var i = 0;
    var subList;
    if (batch > 0) {
      for (; i < batch; i++) {
        subList = uidList.sublist(i * 200, 200 * (i + 1));
        Apis._onlineStatus(uidList: subList, token: data.token)
            .then((list) => _handleStatus(
                  list,
                  onlineStatusCallback: onlineStatusCallback,
                  onlineStatusDescCallback: onlineStatusDescCallback,
                ));
      }
    }
    if (remainder > 0) {
      if (i > 0) {
        subList = uidList.sublist(i * 200, 200 * i + remainder);
        Apis._onlineStatus(uidList: subList, token: data.token)
            .then((list) => _handleStatus(
                  list,
                  onlineStatusCallback: onlineStatusCallback,
                  onlineStatusDescCallback: onlineStatusDescCallback,
                ));
      } else {
        subList = uidList.sublist(0, remainder);
        Apis._onlineStatus(uidList: subList, token: data.token)
            .then((list) => _handleStatus(
                  list,
                  onlineStatusCallback: onlineStatusCallback,
                  onlineStatusDescCallback: onlineStatusDescCallback,
                ));
      }
    }
  }

  static _handleStatus(
    List<OnlineStatus> list, {
    Function(Map<String, String>)? onlineStatusDescCallback,
    Function(Map<String, bool>)? onlineStatusCallback,
  }) {
    final statusDesc = <String, String>{};
    final status = <String, bool>{};
    list.forEach((e) {
      if (e.status == 'online') {
        // IOSPlatformStr     = "IOS"
        // AndroidPlatformStr = "Android"
        // WindowsPlatformStr = "Windows"
        // OSXPlatformStr     = "OSX"
        // WebPlatformStr     = "Web"
        // MiniWebPlatformStr = "MiniWeb"
        // LinuxPlatformStr   = "Linux"
        final pList = <String>[];
        for (var platform in e.detailPlatformStatus!) {
          if (platform.platform == "Android" || platform.platform == "IOS") {
            pList.add(StrRes.phoneOnline);
          } else if (platform.platform == "Windows") {
            pList.add(StrRes.pcOnline);
          } else if (platform.platform == "Web") {
            pList.add(StrRes.webOnline);
          } else if (platform.platform == "MiniWeb") {
            pList.add(StrRes.webMiniOnline);
          } else {
            statusDesc[e.userID!] = StrRes.online;
          }
        }
        statusDesc[e.userID!] = '${pList.join('/')}${StrRes.online}';
        status[e.userID!] = true;
      } else {
        statusDesc[e.userID!] = StrRes.offline;
        status[e.userID!] = false;
      }
    });
    onlineStatusDescCallback?.call(statusDesc);
    onlineStatusCallback?.call(status);
  }

  static Options _tokenOptions() {
    return Options(
        headers: {'token': DataPersistence.getLoginCertificate()!.token});
  }

  static String _getOperationID() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// 撤回消息
  static Future<SendMsg> sendMsg(
      {required String sendID,
      required String groupID,
      required String revokeMsgClientID,
      required String msg,
      required String token}) async {
    try {
      var data = await HttpUtil.post(
        Urls.sendMsg,
        data: {
          "groupID": groupID,
          "sendID": sendID,
          "senderPlatformID": 2,
          "content": {"revokeMsgClientID": revokeMsgClientID},
          "contentType": 111,
          "sessionType": 2,
          "isOnlineOnly": false,
          "offlinePushInfo": {
            "title": msg,
            "desc": "",
            "ex": "",
            "iOSPushSound": "default",
            "iOSBadgeCount": false
          },
          'operationID': _getOperationID(),
        },
        options: Options(headers: {'token': token}),
      );
      return SendMsg.fromJson(data);
    } catch (e) {
      print('e:$e');
      return Future.error(e);
    }
  }

  ///判断是否为数字
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
