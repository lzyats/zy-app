import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';

class AccountSetupLogic extends GetxController {
  var loginCertificate = DataPersistence.getLoginCertificate();

  String? get uid => loginCertificate?.userID;

  var exCertificate = DataPersistence.getExinfo();

  String? get morelang => exCertificate?.morelang;

  var notDisturbModel = false.obs;
  var curLanguage = "".obs;

  final imLogic = Get.find<IMController>();
  String? phone = '';

  void toggleNotDisturbModel() {
    notDisturbModel.value = !notDisturbModel.value;
  }

  void setAddMyMethod() {
    AppNavigator.startAddMyMethod();
    // Get.toNamed(AppRoutes.ADD_MY_METHOD);
  }

  void blacklist() {
    AppNavigator.startBlacklist();
    // Get.toNamed(AppRoutes.BLACKLIST);
  }

  void clearHistory() {
    LoadingView.singleton.wrap(asyncFunction: () async {
      await OpenIM.iMManager.messageManager.deleteAllMsgFromLocalAndSvr();
    });
  }

  void languageSetting() async {
    await AppNavigator.startLanguageSetup();
    updateLanguage();
  }

  void setPwd() async {
    AppNavigator.startRegisterVerifyPhoneOrEmail(
        areaCode: '+86', phoneNumber: phone, email: null, usedFor: 3);
    // AppNavigator.startSetupPwd(
    //   areaCode: '',
    //   phoneNumber: uid,
    //   email: '',
    //   verifyCode: '666666',
    //   usedFor: 3,
    // );
  }

  void setsPwd() async {
    AppNavigator.startRegisterVerifyPhoneOrEmail(
        areaCode: '+86', phoneNumber: phone, email: null, usedFor: 2);
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
  void onReady() {
    updateLanguage();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    phone = imLogic.userInfo.value.phoneNumber;
    // TODO: implement onInit
    super.onInit();
  }
}
