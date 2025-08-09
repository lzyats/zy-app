import 'dart:async';

import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/routes/app_pages.dart';

class VerifyPhoneoLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var codeErrorCtrl = StreamController<ErrorAnimationType>();
  late int usedFor;

  void shake() {
    codeErrorCtrl.add(ErrorAnimationType.shake);
  }

  onCompleted(value) async {
    try {
      await Apis.safepwd(
        uid: imLogic.userInfo.value.userID!,
        password: value,
        usedFor: usedFor,
      );
    } catch (e) {
      shake();
      IMWidget.showToast('${StrRes.verifyCodeError}:$e');
      return false;
    }
    if (usedFor == 1) {
      Get.back(result: true);
      return true;
    }
    Get.until((route) => Get.currentRoute == AppRoutes.ACCOUNT_SETUP);
    //Get.back(result: true);
    return true;
  }

  @override
  void onInit() {
    usedFor = Get.arguments['usedFor'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    codeErrorCtrl.close();
    // codeEditCtrl.dispose();
    super.onClose();
  }
}
