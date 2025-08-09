import 'package:flutter/cupertino.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:get/get.dart';

class SetupUserNameLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var inputCtrl = TextEditingController();

  void setupName() async {
    var data = await OpenIM.iMManager.userManager
        .setSelfInfo(
          nickname: inputCtrl.text,
        )
        .then((value) => imLogic.userInfo.update((val) {
              val?.nickname = inputCtrl.text;
            }));

    //print('----back--${data}---');
    Get.back(result: inputCtrl.text);
  }

  @override
  void onInit() {
    inputCtrl.text = OpenIM.iMManager.uInfo.nickname ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    inputCtrl.dispose();
    super.onClose();
  }
}
