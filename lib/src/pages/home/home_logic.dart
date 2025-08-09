import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';

class HomeLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var index = 0.obs;
  var unreadMsgCount = 0.obs;
  var unhandledFriendApplicationCount = 0.obs;
  var unhandledGroupApplicationCount = 0.obs;
  var unhandledCount = 0.obs;
  var hasread = false;
  var annCertificate = DataPersistence.getAnninfo();
  var exCertificate = DataPersistence.getExinfo();

  String get shownews => exCertificate?.shownews ?? '0';

  int? get id => annCertificate?.id;
  String? get title => annCertificate?.title;
  String? get text => annCertificate?.text;
  String? get ctime => annCertificate?.ctime;
  String? get isactive => exCertificate?.activetab ?? '0';
  String? get activelevel => exCertificate?.activelevel ?? '0';
  String? get activelevelmin => exCertificate?.activelevelmin ?? '1';
  String? get activename => exCertificate?.activename ?? '';
  String? get activeurl => exCertificate?.activeurl ?? 'https://www.baidu.com';
  String? get opencheckin => exCertificate?.opencheckin ?? '0';
  bool showact = false;
  bool showcheckin = false;

  int readid = 0;

  void switchTab(int i) {
    index.value = i;
  }

  /// 获取消息未读数
  void getUnreadMsgCount() {
    OpenIM.iMManager.conversationManager.getTotalUnreadMsgCount().then((count) {
      unreadMsgCount.value = int.tryParse(count) ?? 0;
    });
  }

  /// 获取好友申请未处理数
  void getUnhandledFriendApplicationCount() {
    var i = 0;
    OpenIM.iMManager.friendshipManager
        .getRecvFriendApplicationList()
        .then((list) {
      for (var info in list) {
        if (info.handleResult == 0) i++;
      }
      unhandledFriendApplicationCount.value = i;
      unhandledCount.value = unhandledGroupApplicationCount.value + i;
    });
  }

  /// 获取群申请未处理数
  void getUnhandledGroupApplicationCount() {
    OpenIM.iMManager.groupManager.getRecvGroupApplicationList().then((list) {
      var i = list.where((e) => e.handleResult == 0).length;
      print('getUnhandledGroupApplicationCount-----------$i}');
      unhandledGroupApplicationCount.value = i;
      unhandledCount.value = unhandledFriendApplicationCount.value + i;
    });
  }

  @override
  void onInit() {
    imLogic.unreadMsgCountEventSubject.listen((value) {
      unreadMsgCount.value = value;
    });
    imLogic.friendApplicationChangedSubject.listen((value) {
      getUnhandledFriendApplicationCount();
    });
    imLogic.groupApplicationChangedSubject.listen((value) {
      getUnhandledGroupApplicationCount();
    });
    // imLogic.memberAddedSubject.listen((value) {
    //   getUnhandledGroupApplicationCount();
    // });
    //判断是否显示活动
    if (isactive == '1') {
      if (activelevel == '1') {
        if (imLogic.userInfo.value.exinfo!.level! >=
            double.parse(activelevelmin!)) {
          showact = true;
        }
      } else {
        showact = true;
      }
    }
    //判断是否显示签到
    if (opencheckin == '1') {
      showcheckin = true;
    }
    super.onInit();
  }

  @override
  void onReady() {
    getUnreadMsgCount();
    getUnhandledFriendApplicationCount();
    getUnhandledGroupApplicationCount();
    readid = annCertificate?.readid ?? 0;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
