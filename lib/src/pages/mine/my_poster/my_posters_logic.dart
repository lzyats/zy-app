import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/widgets/qr_view.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class MypostersLogic extends GetxController {
  // late Rx<UserInfo> userInfo;
  final imLogic = Get.find<IMController>();
  var loginCertificate = DataPersistence.getExinfo();
  String? get appdown => loginCertificate?.appdown;

  var invitecode = ''.obs;

  @override
  void onInit() async {
    // userInfo = Get.arguments;
    invitecode.value = Get.arguments['invitecode'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  String buildQRContent() {
    return '${appdown!}';
  }
}
