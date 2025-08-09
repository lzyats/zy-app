import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/app_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';

class CopyRightLogic extends GetxController {
  var version = "".obs;
  var appLogic = Get.find<AppController>();
  var name = "".obs;

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String buildNumber = packageInfo.buildNumber;
    name.value = StrRes.appServiceAgreement;
    version.value = packageInfo.version;
  }

  @override
  void onReady() {
    getPackageInfo();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
