import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/core/controller/jpush_controller.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:openim_enterprise_chat/src/widgets/custom_dialog.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';

class MineLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  final jPushLogic = Get.find<JPushController>();
  var curLanguage = "".obs;
  var loginCertificate = DataPersistence.getExinfo();

  String? get morelang => loginCertificate?.morelang;
  String? get invitecode => loginCertificate?.invitecode;

  String? get openuserlelvel => loginCertificate?.openuserlelvel;

  var level = '';

  var invitecodemy = '';

  // Rx<UserInfo>? userInfo;

  // void getMyInfo() async {
  //   var info = await OpenIM.iMManager.getLoginUserInfo();
  //   userInfo?.value = info;
  // }

  void viewMyQrcode() {
    AppNavigator.startMyQrcode();
    // Get.toNamed(AppRoutes.MY_QRCODE /*, arguments: imLogic.loginUserInfo*/);
  }

  void viewMyInfo() {
    AppNavigator.startMyInfo();
    // Get.toNamed(AppRoutes.MY_INFO /*, arguments: userInfo*/);
  }

  void copyID() {
    IMUtil.copy(text: 'text');
  }

  void accountSetup() {
    AppNavigator.startAccountSetup();
    // Get.toNamed(AppRoutes.ACCOUNT_SETUP);
  }

  void aboutUs() {
    AppNavigator.startAboutUs();
    // Get.toNamed(AppRoutes.ABOUT_US);
  }

  void languageSetting() async {
    await AppNavigator.startLanguageSetup();
    updateLanguage();
  }

  void posters() async {
    try {
      var ex = await Apis.getincode(uid: imLogic.userInfo.value.userID);
      if (ex['invitecode'] != null) {
        invitecodemy = ex['invitecode'];
      }
    } catch (e) {
      print('login e: $e');
    }
    AppNavigator.startPoster(invitecodemy: invitecodemy);
  }

  void getlevel() {
    var jb = imLogic.userInfo.value.exinfo!.level ?? 1;
    switch (jb) {
      case 2:
        level = StrRes.level2;
        break;
      case 3:
        level = StrRes.level3;
        break;
      case 4:
        level = StrRes.level4;
        break;
      case 5:
        level = StrRes.level5;
        break;
      case 6:
        level = StrRes.level6;
        break;
      case 7:
        level = StrRes.level7;
        break;
      case 8:
        level = StrRes.level8;
        break;
      case 9:
        level = StrRes.level9;
        break;
      case 10:
        level = StrRes.level10;
        break;
      default:
        level = StrRes.level1;
        break;
    }
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

  void logout() async {
    var confirm = await Get.dialog(CustomDialog(
      title: StrRes.confirmLogout,
    ));
    if (confirm == true) {
      try {
        await LoadingView.singleton.wrap(asyncFunction: () async {
          await imLogic.logout();
          await DataPersistence.removeLoginCertificate();
          await jPushLogic.logout();
        });
        AppNavigator.startLogin();
      } catch (e) {
        // AppNavigator.startLogin();
        IMWidget.showToast('e:$e');
      }
    }
  }

  void kickedOffline() async {
    await DataPersistence.removeLoginCertificate();
    await jPushLogic.logout();
    AppNavigator.startLogin();
  }

  @override
  void onInit() {
    // imLogic.selfInfoUpdatedSubject.listen((value) {
    //   userInfo?.value = value;
    // });
    getlevel();
    imLogic.onKickedOfflineSubject.listen((value) {
      Get.snackbar(StrRes.accountWarn, StrRes.accountException);
      kickedOffline();
    });
    updateLanguage();
    super.onInit();
  }

  @override
  void onReady() {
    // getMyInfo();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
