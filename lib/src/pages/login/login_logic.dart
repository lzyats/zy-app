import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/core/controller/jpush_controller.dart';
import 'package:openim_enterprise_chat/src/pages/server_config/server_config_binding.dart';
import 'package:openim_enterprise_chat/src/pages/server_config/server_config_view.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';

class LoginLogic extends GetxController {
  var phoneCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();
  var phoneFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var showAccountClearBtn = false.obs;
  var showPwdClearBtn = false.obs;
  var obscureText = true.obs;
  var agreedProtocol = true.obs;
  var imLogic = Get.find<IMController>();
  var jPushLogic = Get.find<JPushController>();
  var enabledLoginButton = false.obs;
  var index = 0.obs;
  var areaCode = "+86".obs;
  var curLanguage = "".obs;
  var loginCertificate = DataPersistence.getExinfo();

  String? get openreg => loginCertificate?.openreg;
  String? get invitecode => loginCertificate?.invitecode;
  String? get morelang => loginCertificate?.morelang;

  login() async {
    if (index.value == 0 && !IMUtil.isMobile(phoneCtrl.text)) {
      //Sprint('----${IMUtil.isLUsername(phoneCtrl.text)}----');
      IMWidget.showToast(StrRes.plsInputRightPhone);
      return;
    }
    if (index.value == 1 && !GetUtils.isEmail(emailCtrl.text)) {
      IMWidget.showToast(StrRes.plsInputRightEmail);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      var suc = await _login();
      if (suc) {
        AppNavigator.startMain();
      }
    });
  }

  void languageSetting() async {
    await AppNavigator.startLanguageSetup();
    updateLanguage();
  }

  void updateLanguage() {
    var index = DataPersistence.getLanguage() ?? 0;
    switch (index) {
      case 1:
        curLanguage.value = StrRes.chinese;
        break;
      case 2:
        curLanguage.value = StrRes.english;
        break;
      default:
        curLanguage.value = StrRes.followSystem;
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> _login() async {
    print('-------------');
    try {
      var data = await Apis.userlogin(
          areaCode: areaCode.value,
          phoneNumber: index.value == 0 ? phoneCtrl.text : null,
          email: index.value == 1 ? emailCtrl.text : null,
          password: pwdCtrl.text,
          silent: false);
      await DataPersistence.putLoginCertificate(data);
      print(
          '---------login---------- uid: ${data.userID}, token: ${data.token}');

      await imLogic.login(data.userID, data.token);
      print('---------im login success-------');
      jPushLogic.login(data.userID);
      print('---------jpush login success----');
      return true;
    } catch (e) {
      print('login e: $e');
    } finally {}
    return false;
  }

  void register() {
    if (invitecode == '1') {
      AppNavigator.startInvitecode(index.value == 0 ? 'phone' : 'email');
    } else {
      AppNavigator.startRegister('phone', '');
    }
  }

  void toggleEye() {
    obscureText.value = !obscureText.value;
  }

  void toggleProtocol() {
    agreedProtocol.value = !agreedProtocol.value;
  }

  @override
  void onReady() {
    phoneCtrl.addListener(() {
      showAccountClearBtn.value = phoneCtrl.text.isNotEmpty;
      _changeLoginButtonStatus();
    });
    emailCtrl.addListener(() {
      showAccountClearBtn.value = emailCtrl.text.isNotEmpty;
      _changeLoginButtonStatus();
    });
    pwdCtrl.addListener(() {
      showPwdClearBtn.value = pwdCtrl.text.isNotEmpty;
      _changeLoginButtonStatus();
    });
    super.onReady();
  }

  void _changeLoginButtonStatus() {
    enabledLoginButton.value = pwdCtrl.text.isNotEmpty &&
        (phoneCtrl.text.isNotEmpty || emailCtrl.text.isNotEmpty);
  }

  void toServerConfig() {
    Get.to(() => ServerConfigPage(), binding: ServerConfigBinding());
  }

  @override
  void onClose() {
    print('-----------onClose----------------');
    phoneCtrl.dispose();
    pwdCtrl.dispose();
    emailCtrl.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    super.onClose();
  }

  void switchTab(index) {
    // FocusScope.of(Get.context!).requestFocus(FocusNode());
    this.index.value = index;
    phoneCtrl.clear();
    emailCtrl.clear();
    pwdCtrl.clear();
    if (index == 0) {
      emailFocusNode.unfocus();
      phoneFocusNode.requestFocus();
    } else {
      phoneFocusNode.unfocus();
      emailFocusNode.requestFocus();
    }
  }

  void openCountryCodePicker() async {
    String? code = await IMWidget.showCountryCodePicker();
    if (null != code) areaCode.value = code;
  }

  void forgetPassword() {
    AppNavigator.startForgetPassword();
  }

  void copyright() {
    AppNavigator.startCopyRight();
    // Get.toNamed(AppRoutes.MY_ID);
  }
}
