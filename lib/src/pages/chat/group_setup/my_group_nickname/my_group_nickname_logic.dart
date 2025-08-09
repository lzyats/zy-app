import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';

class MyGroupNicknameLogic extends GetxController {
  var nicknameCtrl = TextEditingController();
  var enabled = false.obs;
  String groupID = '';
  String nickname = '';

  @override
  void onInit() {
    groupID = Get.arguments['gid'];
    nickname = Get.arguments['nickname'];
    //print('-----' + groupID);
    nicknameCtrl.text = nickname;
    nicknameCtrl.addListener(() {
      enabled.value = nicknameCtrl.text.trim().isNotEmpty;
    });
    super.onInit();
  }

  void clear() {
    nicknameCtrl.clear();
  }

  void modifyMyNickname() async {
    var list = await OpenIM.iMManager.groupManager.setGroupMemberNickname(
      groupID: groupID,
      userID: OpenIM.iMManager.uInfo.userID!,
      groupNickname: nicknameCtrl.text,
    );
    Get.back(result: nicknameCtrl.text);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    nicknameCtrl.dispose();
    super.onClose();
  }
}
