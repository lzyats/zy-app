import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';

class InvitecodeLogic extends GetxController {
  var controller = TextEditingController();
  var showClearBtn = false.obs;
  var agreedProtocol = true.obs;
  var isPhoneRegister = true;
  var areaCode = "+86".obs;
  int usedFor = 1;

  void nextStep() {
    if (isPhoneRegister && !IMUtil.isinvitecode(controller.text)) {
      IMWidget.showToast(StrRes.plinvitecode);
      return;
    }
    onCompleted(invitecode: controller.text);
  }

  void onCompleted({String? invitecode}) async {
    try {
      ////邀请码验证
      await Apis.checkinvitecode(invitecode: invitecode);

      AppNavigator.startRegister('phone', invitecode);
    } catch (e) {
      //IMWidget.showToast('${StrRes.verifyCodeError}:$e');
    }
  }

  void toggleProtocol() {
    agreedProtocol.value = !agreedProtocol.value;
  }

  @override
  void onReady() {
    controller.addListener(() {
      showClearBtn.value = controller.text.isNotEmpty;
    });
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    isPhoneRegister = Get.arguments['registerWay'] == "phone";

    usedFor = usedFor;
    super.onInit();
  }

  void openCountryCodePicker() async {
    String? code = await IMWidget.showCountryCodePicker();
    if (null != code) {
      areaCode.value = code;
    }
  }
}
