import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/models/useraddr_info.dart';

class MyAddrLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var uaddr = ''.obs;
  var ucitys = '请设置省市信息'.obs;

  var inputCtrlcity = TextEditingController();
  var inputCtrladdr = TextEditingController();

  @override
  void onInit() {
    print('----' + Get.arguments['usaddr']);
    if (Get.arguments['usaddr'] != null && Get.arguments['usaddr'] != '') {
      print('----' + Get.arguments['usaddr']);
      uaddr.value = Get.arguments['usaddr'];
      inputCtrladdr.text = uaddr.string;
    }
    if (Get.arguments['uscity'] != null && Get.arguments['uscity'] != '') {
      ucitys.value = Get.arguments['uscity'];
      inputCtrlcity.text = ucitys.string;
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  singin() async {
    if (inputCtrlcity.text.length < 5 || inputCtrladdr.text == '请设置省市信息') {
      IMWidget.showToast("省市信息不能为空");
      return;
    }
    if (inputCtrladdr.text.length < 5) {
      IMWidget.showToast("收货详细地址不能为空");
      return;
    }
    try {
      var ex = await Apis.putuseraddr(
          uid: imLogic.userInfo.value.userID,
          citys: inputCtrlcity.text,
          addr: inputCtrladdr.text);
      print(ex);
      if (ex['addr'] != null) {
        ex = UserAddrCertificate.fromJson(ex!);
        var put = await DataPersistence.putUserAddrinfo(ex);
      }
      Get.back(result: inputCtrladdr.text);
    } catch (e) {
      print('login e: $e');
    }
  }
}
