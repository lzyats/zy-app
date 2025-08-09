import 'package:flutter/cupertino.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/models/usdt_info.dart';

class SetupUsdtAddrLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var inputCtrl = TextEditingController();
  var showClearBtn = false.obs;
  var uaddr = ''.obs;

  void setupName() async {
    if (!IMUtil.isUsername(inputCtrl.text) || inputCtrl.text.length < 15) {
      IMWidget.showToast(StrRes.usdttip1);
      return;
    }
    try {
      var ex = await Apis.putusdtaddr(
          uid: imLogic.userInfo.value.userID, addr: inputCtrl.text);
      print(ex);
      if (ex['addr'] != null) {
        ex = UsdtCertificate.fromJson(ex!);
        await DataPersistence.putUsdtinfo(ex);
      }
      Get.back(result: inputCtrl.text);
    } catch (e) {
      print('login e: $e');
    }
  }

  @override
  void onInit() {
    //获取钱包地址
    uaddr.value = Get.arguments['usdtaddr'];
    inputCtrl.text = uaddr.string;
    super.onInit();
  }

  @override
  void onReady() {
    inputCtrl.addListener(() {
      showClearBtn.value = inputCtrl.text.isNotEmpty;
    });
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    inputCtrl.dispose();
    super.onClose();
  }
}
