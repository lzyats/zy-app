import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/app_controller.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/pages/home/home_logic.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../sdk_extension/message_manager.dart';
import 'package:flutter/cupertino.dart';

class ConversationLogic extends GetxController {
  var popCtrl = CustomPopupMenuController();
  var list = <ConversationInfo>[].obs;
  var resultList = <ConversationInfo>[];
  var imLogic = Get.find<IMController>();
  var homeLogic = Get.find<HomeLogic>();
  var appLogic = Get.find<AppController>();
  final refreshController = RefreshController(initialRefresh: false);
  var tempDraftText = <String, String>{};
  final _pageSize = 40;

  var focusNode = FocusNode();
  var searchCtrl = TextEditingController();

  var unreadMsgCount = 0.obs;

  @override
  void onInit() {
    imLogic.conversationAddedSubject.listen((newList) {
      // getConversationListSplit();
      // getAllConversationList();
      // list.addAll(newList);
      for (var newValue in newList) {
        list.remove(newValue);
      }
      list.insertAll(0, newList);
      _sortConversationList();
      // _parseDoNotDisturb(newList);
    });
    imLogic.conversationChangedSubject.listen((newList) {
      for (var newValue in newList) {
        list.remove(newValue);
      }
      list.insertAll(0, newList);
      _sortConversationList();
      // getConversationListSplit();
      // getAllConversationList();
      // list.assignAll(newList);
      // _parseDoNotDisturb(newList);
    });
    imLogic.unreadMsgCountEventSubject.listen((value) {
      unreadMsgCount.value = value;
    });
    super.onInit();
  }

  @override
  void onReady() {
    onRefresh();
    //searchCtrl.addListener(search);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String getConversationId(int index) {
    var info = list.elementAt(index);
    return info.conversationID;
  }

  /// 标记会话已读
  void markMessageHasRead(int index) {
    var info = list.elementAt(index);
    _markMessageHasRead(
      conversationType: info.conversationType!,
      conversationID: info.conversationID,
      uid: info.userID,
      gid: info.groupID,
      unreadCount: info.unreadCount!,
    );
  }

  /// 置顶会话
  void pinConversation(int index) async {
    var info = list.elementAt(index);
    OpenIM.iMManager.conversationManager.pinConversation(
      conversationID: info.conversationID,
      isPinned: !info.isPinned!,
    );
  }

  /// 删除会话
  void deleteConversation(int index) async {
    var info = list.elementAt(index);
    await OpenIM.iMManager.conversationManager
        .deleteConversationFromLocalAndSvr(
      conversationID: info.conversationID,
    );
    list.removeAt(index);
  }

  /// 设置草稿
  void setConversationDraft({required String cid, required String draftText}) {
    OpenIM.iMManager.conversationManager.setConversationDraft(
      conversationID: cid,
      draftText: draftText,
    );
  }

  String? getPrefixText(int index) {
    var info = list.elementAt(index);
    String? prefix;
    try {
      // 草稿
      if (null != info.draftText && '' != info.draftText) {
        var map = json.decode(info.draftText!);
        String text = map['text'];
        if (text.isNotEmpty) {
          prefix = '[${StrRes.draftText}]';
        }
      } else if (info.latestMsg?.contentType == MessageType.at_text) {
        // @ 消息
        Map map = json.decode(info.latestMsg!.content!);
        String text = map['text'];
        // bool isAtSelf = map['isAtSelf'];
        bool isAtSelf = text.contains('@${OpenIM.iMManager.uid} ');
        if (isAtSelf == true) {
          prefix = '[@${StrRes.you}]';
        }
      }
    } catch (e) {}

    return prefix;
  }

  /// 解析消息内容
  String getMsgContent(int index) {
    var info = list.elementAt(index);
    try {
      if (null != info.draftText && '' != info.draftText) {
        var map = json.decode(info.draftText!);
        String text = map['text'];
        if (text.isNotEmpty) {
          return text;
        }
      }

      if (null == info.latestMsg) return "";

      final text = IMUtil.parseNotification(info.latestMsg!);
      if (text != null) return text;

      if (info.latestMsg?.contentType == MessageType.picture) {
        return '[${StrRes.picture}]';
      } else if (info.latestMsg?.contentType == MessageType.video) {
        return '[${StrRes.video}]';
      } else if (info.latestMsg?.contentType == MessageType.voice) {
        return '[${StrRes.voice}]';
      } else if (info.latestMsg?.contentType == MessageType.file) {
        return '[${StrRes.file}]';
      } else if (info.latestMsg?.contentType == MessageType.location) {
        return '[${StrRes.location}]';
      } else if (info.latestMsg?.contentType == MessageType.merger) {
        return '[${StrRes.chatRecord}]';
      } else if (info.latestMsg?.contentType == MessageType.card) {
        return '[${StrRes.carte}]';
      } else if (info.latestMsg?.contentType == MessageType.revoke) {
        if (info.latestMsg?.sendID == OpenIM.iMManager.uid) {
          return '[${StrRes.you} ${StrRes.revokeMsg}]';
        } else {
          return '[${info.latestMsg!.senderNickname} ${StrRes.revokeMsg}]';
        }
      } else if (info.latestMsg?.contentType == MessageType.at_text) {
        String text = info.latestMsg!.content!;
        Map map = json.decode(text);
        text = map['text'] ?? '';
        return text;
      } else if (info.latestMsg?.contentType == MessageType.quote) {
        return info.latestMsg?.quoteElem?.text ?? "";
      } else if (info.latestMsg?.contentType == MessageType.text) {
        return info.latestMsg?.content?.trim() ?? '';
      } else if (info.latestMsg?.contentType == MessageType.custom_face) {
        return '[${StrRes.customEmoji}]';
      } else if (info.latestMsg?.contentType == MessageType.oaNotification) {
        // OA通知
        String detail = info.latestMsg!.notificationElem!.detail!;
        var oa = OANotification.fromJson(json.decode(detail));
        return oa.text!;
      } else if (info.latestMsg?.contentType == MessageType.custom) {
        // 自定义消息
        var data = info.latestMsg?.customElem!.data;
        var map = json.decode(data!);
        var customType = map['customType'];
        var customData = map['data'];
        switch (customType) {
          case CustomMessageType.envelope:
            {
              var type = map['data']['types'];
              String str = StrRes.envelope1;
              switch (type) {
                case 1:
                  str = StrRes.envelope1;
                  break;
                case 2:
                  str = StrRes.envelope2;
                  break;
                default:
                  str = StrRes.envelope3;
              }
              return '[${str}]';
            }
          case CustomMessageType.call:
            {
              var type = map['data']['type'];
              return '[${type == 'video' ? StrRes.callVideo : StrRes.callVoice}]';
            }
          case CustomMessageType.custom_emoji:
            {
              return '[${StrRes.customEmoji}]';
            }
          case CustomMessageType.tag_message:
            {
              final text = customData['text'];
              final duration = customData['duration'];
              final url = customData['url'];
              if (text != null) {
                return text!;
              } else if (url != null) {
                return '[${StrRes.video}]';
              } else {
                return '[${StrRes.unsupportedMessage}]';
              }
            }
          default:
            {
              return '[${StrRes.unsupportedMessage}]';
            }
        }
      } else {
        var content = json.decode(info.latestMsg!.content!);
        var text = content['defaultTips'] ?? '[${StrRes.unsupportedMessage}]';
        return text;
      }
    } catch (e) {
      print('------e:$e');
    }
    return '[${StrRes.unsupportedMessage}]';
  }

  Map<String, String> getAtUserMap(int index) {
    var info = list.elementAt(index);
    if (info.isGroupChat) {
      Map<String, String> map =
          DataPersistence.getAtUserMap(info.groupID!)?.cast() ?? {};
      return map;
    }
    return {};
  }

  search() {
    var key = searchCtrl.text.trim();
    if (key.isEmpty || key == '') {
      return;
    }
    resultList = list;
    var lists = <ConversationInfo>[];
    if (key.isNotEmpty) {
      resultList.forEach((element) {
        if (element.conversationID.toUpperCase().contains(key.toUpperCase())) {
          lists.add(element);
        }
      });
      list.clear();
      list = lists.obs;
    }
  }

  /// 头像
  String? getAvatar(int index) {
    var info = list.elementAt(index);
    return info.faceURL;
  }

  bool isGroupChat(int index) {
    var info = list.elementAt(index);
    return info.isGroupChat;
  }

  /// 显示名
  String getShowName(int index) {
    var info = list.elementAt(index);
    if (info.showName == null || info.showName.isBlank!) {
      return info.userID!;
    }
    return info.showName!;
  }

  /// 时间
  String getTime(int index) {
    var info = list.elementAt(index);
    return IMUtil.getChatTimeline(info.latestMsgSendTime!);
  }

  /// 未读数
  int getUnreadCount(int index) {
    var info = list.elementAt(index);
    return info.unreadCount ?? 0;
  }

  bool existUnreadMsg(int index) {
    return getUnreadCount(index) > 0;
  }

  /// 判断置顶
  bool isPinned(int index) {
    var info = list.elementAt(index);
    return info.isPinned!;
  }

  bool isNotDisturb(int index) {
    var info = list.elementAt(index);
    return info.recvMsgOpt != 0;
  }

  void toAddFriend() {
    AppNavigator.startAddFriend();
  }

  void toAddGroup() {
    AppNavigator.startAddGroupBySearch();
  }

  void createGroup() {
    AppNavigator.createGroup();
  }

  void toScanQrcode() {
    AppNavigator.startScanQrcode();
  }

  void toViewCallRecords() {
    AppNavigator.startCallRecords();
  }

  /// 聊天
  void toChat(int index) async {
    var info = list.elementAt(index);
    if (info.conversationType == ConversationType.notification) {
      // OA系统通知
      await AppNavigator.startOANotificationList(info: info);
      // 标记已读
      _markMessageHasRead(
        conversationType: info.conversationType!,
        conversationID: info.conversationID,
        uid: info.userID,
        gid: info.groupID,
        unreadCount: info.unreadCount,
      );
    } else {
      startChat(
        userID: info.userID,
        groupID: info.groupID,
        nickname: info.showName,
        faceURL: info.faceURL,
        conversationInfo: info,
      );
    }
  }

  bool isUserGroup(int index) => list.elementAt(index).conversationType == 2;

  /// 从其他界面进入聊天界面（非会话界面进入聊天界面）
  void startChat({
    int type = 0,
    String? userID,
    String? groupID,
    String? nickname,
    String? faceURL,
    ConversationInfo? conversationInfo,
    // int? unreadCount,
  }) async {
    // 获取会话信息，若不存在则创建
    conversationInfo ??=
        await OpenIM.iMManager.conversationManager.getOneConversation(
      sourceID: userID == null ? groupID! : userID,
      sessionType: userID == null ? 2 : 1,
    );

    // 保存旧草稿
    updateDartText(
      conversationID: conversationInfo.conversationID,
      uid: userID,
      gid: groupID,
      text: conversationInfo.draftText ?? '',
    );

    // 打开聊天窗口，关闭返回草稿
    /*var newDraftText = */
    await AppNavigator.startChat(
      type: type,
      uid: userID,
      gid: groupID,
      name: nickname,
      icon: faceURL,
      draftText: conversationInfo.draftText,
    );

    // 读取草稿
    var newDraftText = tempDraftText[conversationInfo.conversationID];

    int? count;
    var l =
        list.where((e) => e.conversationID == conversationInfo!.conversationID);
    if (l.isNotEmpty) {
      count = l.first.unreadCount;
    }
    // count ??= unreadCount ?? info!.unreadCount!;

    // 标记已读
    _markMessageHasRead(
      conversationType: conversationInfo.conversationType!,
      conversationID: conversationInfo.conversationID,
      uid: userID,
      gid: groupID,
      unreadCount: count,
    );

    // 记录草稿
    _setupDraftText(
      conversationID: conversationInfo.conversationID,
      oldDraftText: conversationInfo.draftText ?? '',
      newDraftText: newDraftText!,
    );
    // 回到会话列表
    // homeLogic.switchTab(0);
  }

  /// 草稿
  /// 聊天页调用，不在通过onWillPop事件返回，因为该事件会拦截ios的右滑返回上一页。
  void updateDartText({
    String? conversationID,
    String? uid,
    String? gid,
    required String text,
  }) {
    print(
        '----conversationID:$conversationID uid:$uid   gid:$gid   text:$text');
    if (null == conversationID || conversationID.isEmpty) {
      if (null != uid && uid.isNotEmpty) {
        conversationID = 'single_$uid';
      } else if (null != gid && gid.isNotEmpty) {
        conversationID = 'group_$gid';
      }
    }
    if (null != conversationID) tempDraftText[conversationID] = text;
  }

  /// 清空未读消息数
  void _markMessageHasRead({
    required int conversationType,
    String? conversationID,
    String? uid,
    String? gid,
    int? unreadCount,
  }) {
    if (unreadCount != null && unreadCount > 0) {
      print('-------_markMessageHasRead: $conversationID---$uid---$gid');
      if (conversationType == ConversationType.single) {
        OpenIM.iMManager.messageManager.markC2CMessageAsRead(
          userID: uid!,
          messageIDList: [],
        );
      } else if (conversationType == ConversationType.group) {
        OpenIM.iMManager.conversationManager.markGroupMessageHasRead(
          groupID: gid!,
        );
      } else if (conversationType == ConversationType.notification) {
        OpenIM.iMManager.messageManager.markMessageAsReadByConID(
          conversationID: conversationID!,
          messageIDList: [],
        );
      }
    }
  }

  /// 设置草稿
  void _setupDraftText({
    required String conversationID,
    required String oldDraftText,
    required String newDraftText,
  }) {
    if (oldDraftText.isEmpty && newDraftText.isEmpty) {
      return;
    }

    /// 保存草稿
    print('draftText:$newDraftText');
    OpenIM.iMManager.conversationManager.setConversationDraft(
      conversationID: conversationID,
      draftText: newDraftText,
    );
  }

  /// 自定义会话列表排序规则
  void _sortConversationList() =>
      OpenIM.iMManager.conversationManager.simpleSort(list);

  void onRefresh() async {
    var list;
    try {
      list = await _request(0);
      this.list..assignAll(list);
      if (null == list || list.isEmpty || list.length < _pageSize) {
        refreshController.loadNoData();
      }
    } finally {
      refreshController.refreshCompleted();
    }
  }

  void onLoading() async {
    var list;
    try {
      list = await _request(this.list.length);
      this.list..addAll(list);
    } finally {
      if (null == list || list.isEmpty || list.length < _pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    }
  }

  _request(int offset) =>
      OpenIM.iMManager.conversationManager.getConversationListSplit(
        offset: offset,
        count: _pageSize,
      );
}
