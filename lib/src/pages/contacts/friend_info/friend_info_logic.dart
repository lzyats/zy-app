import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_openim_live/flutter_openim_live.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/pages/contacts/friend_info/personal_info/personal_info.dart';
import 'package:openim_enterprise_chat/src/pages/conversation/conversation_logic.dart';
import 'package:openim_enterprise_chat/src/pages/select_contacts/select_contacts_logic.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/widgets/custom_dialog.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';

class FriendInfoLogic extends GetxController {
  late Rx<UserInfo> userInfo;
  String? groupID;
  bool havePermissionMute = false;
  bool qrcode = false;
  var imLogic = Get.find<IMController>();
  var conversationLogic = Get.find<ConversationLogic>();
  var mutedTime = "".obs;

  var level = '';
  int mangerlevel = 1;

  void toggleBlacklist() {
    if (userInfo.value.isBlacklist == true) {
      removeBlacklist();
    } else {
      addBlacklist();
    }
  }

  void getlevel() {
    var jb = 1;
    if (userInfo.value.exinfo != null) jb = userInfo.value.exinfo!.level!;
    switch (jb) {
      case 2:
        level = StrRes.level2;
        break;
      case 3:
        level = StrRes.level3;
        break;
      case 4:
        level = StrRes.level4;
        break;
      case 5:
        level = StrRes.level5;
        break;
      case 6:
        level = StrRes.level6;
        break;
      case 7:
        level = StrRes.level7;
        break;
      case 8:
        level = StrRes.level8;
        break;
      case 9:
        level = StrRes.level9;
        break;
      case 10:
        level = StrRes.level10;
        break;
      default:
        level = StrRes.level1;
        break;
    }
  }

  /// 加入黑名单
  void addBlacklist() async {
    var confirm = await Get.dialog(CustomDialog(
      title: StrRes.areYouSureAddBlacklist,
      rightText: StrRes.sure,
    ));
    if (confirm == true) {
      var result = await OpenIM.iMManager.friendshipManager.addBlacklist(
        uid: userInfo.value.userID!,
      );
      userInfo.update((val) {
        val?.isBlacklist = true;
      });
      print('result:$result');
    }
  }

  /// 从黑名单移除
  void removeBlacklist() async {
    var result = await OpenIM.iMManager.friendshipManager.removeBlacklist(
      uid: userInfo.value.userID!,
    );
    userInfo.update((val) {
      val?.isBlacklist = false;
    });
    print('result:$result');
  }

  /// 解除好友关系
  void deleteFromFriendList() async {
    var confirm = await Get.dialog(CustomDialog(
      title: StrRes.areYouSureDelFriend,
      rightText: StrRes.delete,
    ));
    if (confirm) {
      var result = await OpenIM.iMManager.friendshipManager.deleteFriend(
        uid: userInfo.value.userID!,
      );
      userInfo.update((val) {
        val?.isFriendship = false;
      });
      print('result:$result');
    }
  }

  /// 检查是否是好友
  void checkFriendship() async {
    // var list = await OpenIM.iMManager.friendshipManager
    //     .checkFriend(uidList: [info.value.userID!]);
    // if (list.isNotEmpty) {
    //   info.update((val) {
    //     val?.flag = list.first.flag;
    //   });
    // }
  }

  void toChat() {
    conversationLogic.startChat(
      userID: userInfo.value.userID,
      nickname: userInfo.value.getShowName(),
      faceURL: userInfo.value.faceURL,
      type: 1,
    );
  }

  void toCall() {
    IMWidget.openIMCallSheet(userInfo.value.getShowName(), (index) {
      imLogic.call(
        CallObj.single,
        index == 0 ? CallType.audio : CallType.video,
        null,
        [userInfo.value.userID!],
      );
    });
  }

  void addFriend() {
    if (userInfo.value.userID == OpenIM.iMManager.uid) {
      IMWidget.showToast(StrRes.notAddSelf);
      return;
    }
    AppNavigator.startSendFriendRequest(info: userInfo.value);
  }

  void toCopyId() {
    AppNavigator.startFriendIDCode(info: userInfo.value);
  }

  void toSetupRemark() async {
    var remarkName = await AppNavigator.startSetFriendRemarksName(
      info: userInfo.value,
    );
    if (remarkName != null) {
      userInfo.update((val) {
        val?.remark = remarkName;
      });
    }
  }

  void getFriendInfo() async {
    print('------' + userInfo.value.userID!.toString());
    var list = await OpenIM.iMManager.userManager.getUsersInfo(
      uidList: [userInfo.value.userID!],
    );
    // var list = await OpenIM.iMManager.friendshipManager.getFriendsInfo(
    //   uidList: [info.value.userID!],
    // );
    if (list.isNotEmpty) {
      var user = list.first;
      userInfo.update((val) {
        val?.nickname = user.nickname;
        val?.faceURL = user.faceURL;
        val?.remark = user.remark;
        val?.gender = user.gender;
        val?.phoneNumber = user.phoneNumber;
        val?.birth = user.birth;
        val?.email = user.email;
        val?.isBlacklist = user.isBlacklist;
        val?.isFriendship = user.isFriendship;
      });
    }
  }

  void recommendFriend() async {
    var result = await AppNavigator.startSelectContacts(
      action: SelAction.RECOMMEND,
      excludeUidList: [userInfo.value.userID!],
    );
    if (null == result) return;
    var uid = result['userID'];
    // var name = result['nickname'];
    // var icon = result['faceURL'];
    // AppNavigator.startChat();
    var message = await OpenIM.iMManager.messageManager.createCardMessage(
      data: {
        "userID": userInfo.value.userID,
        'nickname': userInfo.value.getShowName(),
        'faceURL': userInfo.value.faceURL
      },
    );
    OpenIM.iMManager.messageManager.sendMessage(
      message: message,
      userID: uid,
      offlinePushInfo: OfflinePushInfo(
        title: "你收到了了一条消息",
        desc: "",
        iOSBadgeCount: true,
        iOSPushSound: '+1',
      ),
    );
  }

  @override
  void onInit() {
    userInfo = Rx(Get.arguments['userInfo']);
    //print(' user:   ${json.encode(userInfo.value)}');
    groupID = Get.arguments['groupID'];
    havePermissionMute = Get.arguments['havePermissionMute'];
    //if (mangerlevel > 1) havePermissionMute = true;
    if (Get.arguments['qrcode'] != null) qrcode = Get.arguments['qrcode'];
    //print(' user:   ${json.encode(userInfo.value)}');
    imLogic.friendAddSubject.listen((user) {
      //print('add user:   ${json.encode(user)}');
      if (user.userID == userInfo.value.userID) {
        userInfo.update((val) {
          val?.isFriendship = true;
        });
      }
    });
    imLogic.friendInfoChangedSubject.listen((user) {
      print('update user info:   ${json.encode(user)}');
      if (user.userID == userInfo.value.userID) {
        userInfo.update((val) {
          val?.nickname = user.nickname;
          val?.gender = user.gender;
          val?.phoneNumber = user.phoneNumber;
          val?.birth = user.birth;
          val?.email = user.email;
          val?.remark = user.remark;
        });
      }
    });
    imLogic.memberInfoChangedSubject.listen((value) {
      if (value.userID == userInfo.value.userID && null != value.muteEndTime) {
        _calMuteTime(value.muteEndTime!);
      }
    });
    getFriendInfo();
    checkFriendship();
    getlevel();
    //判断用户管理级别
    mangerlevel = imLogic.userInfo.value.exinfo!.mangerlevel!;
    //print('--------mangerlevel--' + mangerlevel.toString());
    super.onInit();
  }

  void viewPersonalInfo() {
    Get.to(() => PersonalInfoPage());
  }

  @override
  void onReady() {
    queryGroupMemberInfo();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setMute() {
    AppNavigator.startSetGroupMemberMute(
      userID: userInfo.value.userID!,
      groupID: groupID!,
    );
  }

  void queryGroupMemberInfo() async {
    if (null != groupID) {
      var list = await OpenIM.iMManager.groupManager.getGroupMembersInfo(
        groupId: groupID!,
        uidList: [userInfo.value.userID!],
      );
      var info = list.firstOrNull;
      if (null != info && null != info.muteEndTime && info.muteEndTime! > 0) {
        _calMuteTime(info.muteEndTime!);
      }
    }
  }

  _calMuteTime(int time) {
    var date = DateUtil.formatDateMs(time * 1000, format: 'yyyy/MM/dd HH:mm');
    var now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var diff = time - now;
    if (diff > 0) {
      mutedTime.value = date;
    } else {
      mutedTime.value = "";
    }
  }
}
