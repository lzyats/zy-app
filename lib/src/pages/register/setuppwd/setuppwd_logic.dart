import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';

import '../../../common/apis.dart';
import '../../../widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/routes/app_pages.dart';

class SetupPwdLogic extends GetxController {
  var pwdCtrl = TextEditingController();
  var showPwdClearBtn = false.obs;
  var obscureText = true.obs;
  var enabled = false.obs;
  String? phoneNumber;
  String? areaCode;
  String? email;
  String? invitecode;
  late int usedFor;
  late String verifyCode;

  void nextStep() {
    if (pwdCtrl.text.length < 6 || pwdCtrl.text.length > 20) {
      IMWidget.showToast(StrRes.pwdFormatError);
      return;
    }
    print('---' + usedFor.toString());
    if (usedFor == 1 || usedFor == 0) {
      // 设置密码/注册
      AppNavigator.startRegisterSetupSelfInfo(
          areaCode: areaCode,
          phoneNumber: phoneNumber,
          email: email,
          verifyCode: verifyCode,
          password: pwdCtrl.text,
          invitecode: invitecode);
    } else if (usedFor == 2) {
      //重置密码
      LoadingView.singleton.wrap(asyncFunction: () async {
        await Apis.safepwd(
          uid: phoneNumber!,
          password: pwdCtrl.text,
          usedFor: usedFor,
        ).then((value) {
          Get.until((route) => Get.currentRoute == AppRoutes.ACCOUNT_SETUP);
        });
      });
    } else if (usedFor == 3) {
      //重置密码
      LoadingView.singleton.wrap(asyncFunction: () async {
        await Apis.resetpass(
          areaCode: areaCode,
          phoneNumber: phoneNumber,
          email: email,
          password: pwdCtrl.text,
          verificationCode: verifyCode,
        ).then((value) {
          Get.until((route) => Get.currentRoute == AppRoutes.ACCOUNT_SETUP);
        });
      });
    } else if (usedFor == 4) {
      //重置密码
      LoadingView.singleton.wrap(asyncFunction: () async {
        await Apis.resetpass(
          areaCode: areaCode,
          phoneNumber: phoneNumber,
          email: email,
          password: pwdCtrl.text,
          verificationCode: verifyCode,
        ).then((value) {
          Get.until((route) => Get.currentRoute == AppRoutes.LOGIN);
        });
      });
    }
  }

  void toggleEye() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onInit() {
    phoneNumber = Get.arguments['phoneNumber'];
    areaCode = Get.arguments['areaCode'];
    email = Get.arguments['email'];
    verifyCode = Get.arguments['verifyCode'];
    usedFor = Get.arguments['usedFor'];
    invitecode = Get.arguments['invitecode'];
    super.onInit();
  }

  @override
  void onReady() {
    pwdCtrl.addListener(() {
      showPwdClearBtn.value = pwdCtrl.text.isNotEmpty;
      enabled.value = pwdCtrl.text.isNotEmpty;
    });
    super.onReady();
  }

  @override
  void onClose() {
    pwdCtrl.dispose();
    super.onClose();
  }
}
