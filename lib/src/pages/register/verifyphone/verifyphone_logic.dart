import 'dart:async';

import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneLogic extends GetxController {
  var codeErrorCtrl = StreamController<ErrorAnimationType>();

  // var codeEditCtrl = TextEditingController();
  String? phoneNumber;
  String? areaCode;
  String? email;
  int usedFor = 1;
  String? invitecode;

  void shake() {
    codeErrorCtrl.add(ErrorAnimationType.shake);
  }

  void onCompleted(value) async {
    try {
      await Apis.checkVerificationCode(
        areaCode: areaCode,
        phoneNumber: phoneNumber,
        email: email,
        verificationCode: value,
      );
      //print('---' + usedFor.toString());
      if (usedFor == 2) {
        AppNavigator.startSafePwd(
          usedFor: usedFor,
        );
      } else {
        AppNavigator.startSetupPwd(
            areaCode: areaCode,
            phoneNumber: phoneNumber,
            email: email,
            verifyCode: value,
            usedFor: usedFor,
            invitecode: invitecode);
      }
    } catch (e) {
      shake();
      IMWidget.showToast('${StrRes.verifyCodeError}:$e');
    }
  }

  @override
  void onInit() {
    phoneNumber = Get.arguments['phoneNumber'];
    areaCode = Get.arguments['areaCode'];
    email = Get.arguments['email'];
    usedFor = Get.arguments['usedFor'];
    invitecode = Get.arguments['invitecode'];
    super.onInit();
  }

  bool get isPhoneRegister => null != phoneNumber;

  @override
  void onReady() {
    requestVerificationCode();
    super.onReady();
  }

  Future<bool> requestVerificationCode() => Apis.requestVerificationCode(
        areaCode: areaCode,
        phoneNumber: phoneNumber,
        email: email,
      );

  @override
  void onClose() {
    codeErrorCtrl.close();
    // codeEditCtrl.dispose();
    super.onClose();
  }
}
