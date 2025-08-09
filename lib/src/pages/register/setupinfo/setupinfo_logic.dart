import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/core/controller/jpush_controller.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';

import '../../../utils/data_persistence.dart';

class SetupSelfInfoLogic extends GetxController {
  var imLogic = Get.find<IMController>();
  var jPushLogic = Get.find<JPushController>();
  var nameCtrl = TextEditingController();
  var showNameClearBtn = false.obs;
  var icon = "".obs;
  String? phoneNumber;
  String? areaCode;
  String? email;
  String? invitecode;
  late String verifyCode;
  late String password;
  var avatarIndex = 0.obs;

  var exCertificate = DataPersistence.getExinfo();
  String? get importkf => exCertificate?.importkf;
  List? get importkfid => exCertificate?.importkfid;

  // final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    phoneNumber = Get.arguments['phoneNumber'];
    areaCode = Get.arguments['areaCode'];
    email = Get.arguments['email'];
    verifyCode = Get.arguments['verifyCode'];
    password = Get.arguments['password'];
    invitecode = Get.arguments['invitecode'];
    avatarIndex.value = -1;
    // avatarIndex = Random().nextInt(indexAvatarList.length);
    super.onInit();
  }

  var stream = Stream.value(1);

  enterMain() async {
    if (icon.isEmpty && avatarIndex.value == -1) {
      IMWidget.showToast(StrRes.plsUploadAvatar);
      return;
    }
    if (nameCtrl.text.isEmpty) {
      IMWidget.showToast(StrRes.nameNotEmpty);
      return;
    }

    ///信息齐全提交服务器注册
    LoadingView.singleton.wrap(asyncFunction: () => _login());
    // await _login();
  }

  _login() async {
    try {
      var data = await Apis.regsiter(
          areaCode: areaCode,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
          nickname: nameCtrl.text,
          faceURL:
              icon.isEmpty ? indexAvatarList[avatarIndex.value] : icon.value,
          verificationCode: verifyCode,
          invitecode: invitecode);
      await DataPersistence.putLoginCertificate(data);
      var uid = data.userID;
      var token = data.token;
      print('---------login---------- uid: $uid, token: $token');
      await imLogic.login(uid, token);
      //由于注册时没有头像等信息，重设个人信息
      //await syncSelfInfo();注册时已经处理
      if (importkf == '1') {
        await adminOperate(uid); //以管理员身份导入好友
      }
      print('---------im login success-------');
      jPushLogic.login(uid);
      print('---------jpush login success----');
      AppNavigator.startMain();
    } catch (e) {}
  }

  /// 管理员操作
  adminOperate(uid) async {
    try {
      // 登录管理员
      var data = await Apis.loginIM('openIM123456');
      // 以管理员身份为用户导入好友
      await Apis.importFriends(
          uid: uid, token: data.token, memberIDS: importkfid!);
      // 拉用户进群
      //await Apis.inviteToGroup(uid: uid, token: data.token);
    } catch (e) {}
  }

  syncSelfInfo() async {
    await OpenIM.iMManager.userManager.setSelfInfo(
      nickname: nameCtrl.text,
      faceURL: icon.isEmpty ? indexAvatarList[avatarIndex.value] : icon.value,
      phoneNumber: phoneNumber,
      email: email,
    );
  }

  void pickerPic() {
    IMWidget.openPhotoSheet(
        onData: (path, url) {
          icon.value = url ?? '';
          if (icon.isNotEmpty) avatarIndex.value = -1;
        },
        isAvatar: true,
        fromCamera: false,
        fromGallery: false,
        onIndexAvatar: (index) {
          if (null != index) {
            avatarIndex.value = index;
            icon.value = "";
          }
        });
  }

  @override
  void onReady() {
    nameCtrl.addListener(() {
      showNameClearBtn.value = nameCtrl.text.isNotEmpty;
    });

    super.onReady();
  }

  @override
  void onClose() {
    nameCtrl.dispose();

    super.onClose();
  }
}
