import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/config.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';

class ServerConfigLogic extends GetxController {
  var checked = true.obs;
  var index = 0.obs;
  var ipCtrl = TextEditingController();
  var authCtrl = TextEditingController();
  var imApiCtrl = TextEditingController();
  var imWsCtrl = TextEditingController();
  var callCtrl = TextEditingController();

  @override
  void onInit() {
    ipCtrl.text = Config.serverIp();
    authCtrl.text = Config.workUrl();
    imApiCtrl.text = Config.imApiUrl();
    imWsCtrl.text = Config.imWsUrl();
    callCtrl.text = Config.callUrl();

    ipCtrl.addListener(() {
      if (ipCtrl.text.isEmpty) {
        authCtrl.text = 'http://${Config.serverIp()}:88';
        imApiCtrl.text = 'http://${Config.serverIp()}:10000';
        imWsCtrl.text = 'ws://${Config.serverIp()}:17778';
        callCtrl.text = 'http://${Config.serverIp()}:7880';
      } else {
        authCtrl.text = 'http://${ipCtrl.text}:88';
        imApiCtrl.text = 'http://${ipCtrl.text}:10000';
        imWsCtrl.text = 'ws://${ipCtrl.text}:17778';
        callCtrl.text = 'http://${ipCtrl.text}:7880';
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    authCtrl.dispose();
    imApiCtrl.dispose();
    imWsCtrl.dispose();
    callCtrl.dispose();
    ipCtrl.dispose();
    super.onClose();
  }

  void toggleRadio() {
    checked.value = !checked.value;
  }

  void confirm() async {
    await DataPersistence.putServerConfig({
      'serverIP': ipCtrl.text,
      'workUrl': authCtrl.text,
      'apiUrl': imApiCtrl.text,
      'wsUrl': imWsCtrl.text,
      'callUrl': callCtrl.text,
    });
    IMWidget.showToast('重启app后配置生效');
    // Get.reset();
  }

  void toggleTab(i) {
    index.value = i;
  }
}
