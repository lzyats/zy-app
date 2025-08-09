/// Is a friend not in the blacklist
/// 是好友不在黑名单
/// Not a friend on the blacklist
/// 不是好友在黑名单
/// Not a friend is not on the blacklist
/// 不是好友不在黑名单
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfo {
  String? userID;
  String? nickname;
  String? faceURL;
  int? gender;
  String? phoneNumber;
  int? birth;
  String? email;
  String? ex;
  int? createTime;
  String? remark;
  ExInfoCertificate? exinfo;
  String? level;
  Color? levelc;

  /// User's public profile（用户公开的资料）
  PublicUserInfo? publicInfo;

  /// Only friends can view information（好友才能查看的资料）
  FriendInfo? friendInfo;

  /// blacklist information（黑名单资料）
  BlacklistInfo? blackInfo;

  bool? isFriendship;

  bool? isBlacklist;

  UserInfo({
    this.publicInfo,
    this.friendInfo,
    this.blackInfo,
    this.isFriendship,
    this.isBlacklist,
    //
    this.userID,
    this.nickname,
    this.faceURL,
    this.phoneNumber,
    this.birth,
    this.gender,
    this.email,
    this.ex,
    this.createTime,
    this.remark,
    this.level,
    this.exinfo,
  });

  // UserInfo.self(Map<String, dynamic> json) {
  //   userID = json['userID'];
  //   nickname = json['nickname'];
  //   faceURL = json['faceURL'];
  //   gender = json['gender'];
  //   phoneNumber = json['phoneNumber'];
  //   birth = json['birth'];
  //   email = json['email'];
  //   ex = json['ex'];
  //   createTime = json['createTime'];
  // }

  UserInfo.fromJson(Map<String, dynamic> json) {
    publicInfo = json['publicInfo'] != null
        ? PublicUserInfo.fromJson(json['publicInfo'])
        : null;
    friendInfo = json['friendInfo'] != null
        ? FriendInfo.fromJson(json['friendInfo'])
        : null;
    blackInfo = json['blackInfo'] != null
        ? BlacklistInfo.fromJson(json['blackInfo'])
        : null;
    //
    isFriendship = friendInfo != null;
    isBlacklist = blackInfo != null;

    userID = json['userID'] ?? _userID;
    nickname = json['nickname'] ?? _nickname;
    faceURL = json['faceURL'] ?? _faceUrl;
    if (_gender != null) {
      gender = json['gender'] ?? _gender;
    } else {
      gender = json['gender'] ?? 1;
    }
    if (_phoneNumber != null) {
      phoneNumber = json['phoneNumber'] ?? _phoneNumber;
    } else {
      phoneNumber = json['phoneNumber'] ?? '';
    }
    if (_birth != null) {
      birth = json['birth'] ?? _birth;
    } else {
      birth = json['birth'] ?? 0;
    }
    if (_email != null) {
      email = json['email'] ?? _email;
    } else {
      email = json['email'] ?? '';
    }
    if (_remark != null) {
      remark = json['remark'] ?? _remark;
    } else {
      remark = json['remark'] ?? '';
    }
    try {
      if (json['ex'] != null && json['ex'] != '') {
        if (json['ex'].runtimeType == String) {
          ex = json['ex'];
          exinfo = ExInfoCertificate.fromJson(jsonDecode(ex!));
        } else {
          ex = jsonEncode(json['ex']);
          exinfo = ExInfoCertificate.fromJson(json['ex']);
        }
      } else {
        if (_ex != null && _ex != '') {
          ex = _ex;
          exinfo = ExInfoCertificate.fromJson(jsonDecode(ex!));
        } else {
          ex = '';
          exinfo!.level = 1;
          exinfo!.mangerlevel = 1;
          exinfo!.usdt = 0;
        }
      }
    } catch (e) {}
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['publicInfo'] = this.publicInfo?.toJson();
    data['friendInfo'] = this.friendInfo?.toJson();
    data['blackInfo'] = this.blackInfo?.toJson();
    //
    data['isFriendship'] = this.isFriendship;
    data['isBlacklist'] = this.isBlacklist;
    data['userID'] = this.userID;
    data['nickname'] = this.nickname;
    data['faceURL'] = this.faceURL;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['birth'] = this.birth;
    data['email'] = this.email;
    data['ex'] = this.ex;
    data['createTime'] = this.createTime;
    data['remark'] = this.remark;
    return data;
  }

  // bool get isFriendship => null != friendInfo;
  //
  // bool get isBlacklist => null != blackInfo;

  bool get isMale => gender == 1;

  String get _userID => isFriendship!
      ? friendInfo!.userID!
      : (isBlacklist! ? blackInfo!.userID! : publicInfo!.userID!);

  String? get _nickname => isFriendship!
      ? friendInfo?.nickname
      : (isBlacklist! ? blackInfo?.nickname : publicInfo?.nickname);

  String? get _faceUrl => isFriendship!
      ? friendInfo?.faceURL
      : (isBlacklist! ? blackInfo?.faceURL : publicInfo?.faceURL);

  int? get _gender => isFriendship!
      ? friendInfo?.gender
      : (isBlacklist! ? blackInfo?.gender : publicInfo?.gender);

  String? get _ex => isFriendship!
      ? friendInfo?.ex
      : (isBlacklist! ? blackInfo?.ex : publicInfo?.ex);

  String? get _phoneNumber => friendInfo?.phoneNumber;

  int? get _birth => friendInfo?.birth;

  String? get _email => friendInfo?.email;

  String? get _remark => friendInfo?.remark;

  String getShowName() => _isNull(remark) ?? _isNull(nickname) ?? userID!;

  static String? _isNull(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value;
  }

  String getlevel() {
    var jb = 1;
    if (exinfo != null) jb = exinfo!.level!;
    switch (jb) {
      case 2:
        level = StrRes.level2;
        levelc = Color(0xFFFFC027);
        break;
      case 3:
        level = StrRes.level3;
        levelc = Color(0xFF5C24EA);
        break;
      case 4:
        level = StrRes.level4;
        levelc = Color(0xFF222222);
        break;
      case 5:
        level = StrRes.level5;
        levelc = Color(0xFFEE3E54);
        break;
      case 6:
        level = StrRes.level6;
        levelc = Color(0xFFFF812E);
        break;
      case 7:
        level = StrRes.level7;
        levelc = Color(0xFFCCAAA1);
        break;
      case 8:
        level = StrRes.level8;
        levelc = Color(0xFF1C2D63);
        break;
      case 9:
        level = StrRes.level9;
        levelc = Color(0xFFE6AD27);
        break;
      case 10:
        level = StrRes.level10;
        levelc = Color(0xFFCFA573);
        break;
      default:
        level = StrRes.level1;
        levelc = Color(0xFFCCCCCC);
        break;
    }
    return level!;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfo &&
          runtimeType == other.runtimeType &&
          userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}

// 扩展信息结构体
class ExInfoCertificate {
  double? usdt = 0;
  int? level = 1;
  int? mangerlevel = 1;

  ExInfoCertificate.fromJson(Map<String, dynamic> map)
      : usdt = map["usdt"].toDouble() ?? 0,
        level = map["level"] ?? 1,
        mangerlevel = map["mangerlevel"] ?? 1;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['usdt'] = usdt!;
    data['level'] = level!;
    data['mangerlevel'] = mangerlevel!;
    return data;
  }
}

class PublicUserInfo {
  String? userID;
  String? nickname;
  String? faceURL;
  int? gender;
  int? appMangerLevel;
  String? ex;

  PublicUserInfo({
    this.userID,
    this.nickname,
    this.faceURL,
    this.gender,
    this.appMangerLevel,
    this.ex,
  });

  PublicUserInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickname = json['nickname'];
    faceURL = json['faceURL'];
    gender = json['gender'];
    appMangerLevel = json['appMangerLevel'];
    ex = json['ex'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['userID'] = this.userID;
    data['nickname'] = this.nickname;
    data['faceURL'] = this.faceURL;
    data['gender'] = this.gender;
    data['appMangerLevel'] = this.appMangerLevel;
    data['ex'] = this.ex;
    return data;
  }
}

class FriendInfo {
  String? userID;
  String? nickname;
  String? faceURL;
  int? gender;
  String? phoneNumber;
  int? birth;
  String? email;
  String? remark;
  String? ex;
  int? createTime;
  int? addSource;
  String? operatorUserID;

  FriendInfo({
    this.userID,
    this.nickname,
    this.faceURL,
    this.gender,
    this.phoneNumber,
    this.birth,
    this.email,
    this.remark,
    this.ex,
    this.createTime,
    this.addSource,
    this.operatorUserID,
  });

  FriendInfo.fromJson(Map<String, dynamic> json) {
    // ownerUserID = json['ownerUserID'];
    userID = json['userID'];
    remark = json['remark'];
    createTime = json['createTime'];
    addSource = json['addSource'];
    operatorUserID = json['operatorUserID'];
    nickname = json['nickname'];
    faceURL = json['faceURL'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    birth = json['birth'];
    email = json['email'];
    ex = json['ex'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    // data['ownerUserID'] = this.ownerUserID;
    data['userID'] = this.userID;
    data['remark'] = this.remark;
    data['createTime'] = this.createTime;
    data['addSource'] = this.addSource;
    data['operatorUserID'] = this.operatorUserID;
    data['nickname'] = this.nickname;
    data['faceURL'] = this.faceURL;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['birth'] = this.birth;
    data['email'] = this.email;
    data['ex'] = this.ex;
    return data;
  }
}

class BlacklistInfo {
  String? userID;
  String? nickname;
  String? faceURL;
  int? gender;
  int? createTime;
  int? addSource;
  String? operatorUserID;
  String? ex;

  BlacklistInfo({
    this.userID,
    this.nickname,
    this.faceURL,
    this.gender,
    this.createTime,
    this.addSource,
    this.operatorUserID,
    this.ex,
  });

  BlacklistInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickname = json['nickname'];
    faceURL = json['faceURL'];
    gender = json['gender'];
    createTime = json['createTime'];
    addSource = json['addSource'];
    operatorUserID = json['operatorUserID'];
    ex = json['ex'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['userID'] = this.userID;
    data['nickname'] = this.nickname;
    data['faceURL'] = this.faceURL;
    data['gender'] = this.gender;
    data['createTime'] = this.createTime;
    data['addSource'] = this.addSource;
    data['operatorUserID'] = this.operatorUserID;
    data['ex'] = this.ex;
    return data;
  }
}

class FriendshipInfo {
  String? userID;

  /// 1 means friend (and not blacklist)
  /// 1表示好友（并且不是黑名单）
  int? result;

  FriendshipInfo({this.userID, this.result});

  FriendshipInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['result'] = this.result;
    return data;
  }
}

class FriendApplicationInfo {
  String? fromUserID;
  String? fromNickname;
  String? fromFaceURL;
  int? fromGender;
  String? toUserID;
  String? toNickname;
  String? toFaceURL;
  int? toGender;
  int? handleResult;
  String? reqMsg;
  int? createTime;
  String? handlerUserID;
  String? handleMsg;
  int? handleTime;
  String? ex;

  FriendApplicationInfo(
      {this.fromUserID,
      this.fromNickname,
      this.fromFaceURL,
      this.fromGender,
      this.toUserID,
      this.toNickname,
      this.toFaceURL,
      this.toGender,
      this.handleResult,
      this.reqMsg,
      this.createTime,
      this.handlerUserID,
      this.handleMsg,
      this.handleTime,
      this.ex});

  FriendApplicationInfo.fromJson(Map<String, dynamic> json) {
    fromUserID = json['fromUserID'];
    fromNickname = json['fromNickname'];
    fromFaceURL = json['fromFaceURL'];
    fromGender = json['fromGender'];
    toUserID = json['toUserID'];
    toNickname = json['toNickname'];
    toFaceURL = json['toFaceURL'];
    toGender = json['toGender'];
    handleResult = json['handleResult'];
    reqMsg = json['reqMsg'];
    createTime = json['createTime'];
    handlerUserID = json['handlerUserID'];
    handleMsg = json['handleMsg'];
    handleTime = json['handleTime'];
    ex = json['ex'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['fromUserID'] = this.fromUserID;
    data['fromNickname'] = this.fromNickname;
    data['fromFaceURL'] = this.fromFaceURL;
    data['fromGender'] = this.fromGender;
    data['toUserID'] = this.toUserID;
    data['toNickname'] = this.toNickname;
    data['toFaceURL'] = this.toFaceURL;
    data['toGender'] = this.toGender;
    data['handleResult'] = this.handleResult;
    data['reqMsg'] = this.reqMsg;
    data['createTime'] = this.createTime;
    data['handlerUserID'] = this.handlerUserID;
    data['handleMsg'] = this.handleMsg;
    data['handleTime'] = this.handleTime;
    data['ex'] = this.ex;
    return data;
  }

  /// friend application waiting handle
  bool get isWaitingHandle => handleResult == 0;

  /// friend application agreed
  bool get isAgreed => handleResult == 1;

  /// friend application rejected
  bool get isRejected => handleResult == -1;
}
