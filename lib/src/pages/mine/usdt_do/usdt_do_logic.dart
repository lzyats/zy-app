import 'package:flutter/cupertino.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'dart:convert';

class SetUsdtdoLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var exCertificate = DataPersistence.getExinfo();
  String? get usdttxnum => exCertificate?.usdttxnum;
  var loginCertificate = DataPersistence.getLoginCertificate();
  String? get uid => loginCertificate?.userID;

  String? get token => loginCertificate?.token;

  var usdtCertificate = DataPersistence.getUsdtinfo();
  String? get addr => usdtCertificate?.addr;

  var list = [
    '30 Usdt',
    '50 Usdt',
    '80 Usdt',
    '100 Usdt',
    '200 Usdt',
  ];
  final controller = TextEditingController();
  final focusNode = FocusNode();
  var index = 10.obs;

  late String userID;

  void checkedIndex(index) {
    /*if (index < list.length) */ this.index.value = index;
    controller.clear();
    focusNode.unfocus();
  }

  @override
  void onInit() {
    controller.text = usdttxnum.toString();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        index.value = 10;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void completed() async {
    double seconds = 0;
    if (index < list.length) {
      switch (index.value) {
        case 0:
          seconds = 30;
          break;
        case 1:
          seconds = 50;
          break;
        case 2:
          seconds = 80;
          break;
        case 3:
          seconds = 100;
          break;
        case 4:
          seconds = 200;
          break;
      }
    }
    //判断钱包地址是否填写
    //print('-----ye----${addr}');
    if (addr == null) {
      IMWidget.showToast(StrRes.usdttip);
      return;
    }
    if (controller.text.isNotEmpty) {
      var day = double.parse(controller.text);
      seconds = day;
    }
    //判断提现金额是否大于用户金额

    var usdt = imLogic.userInfo.value.exinfo!.usdt ?? 0;
    if (seconds > usdt) {
      IMWidget.showToast(StrRes.tusdtxer);
      return;
    }
    //判断提现金额是否大于最低提现金额
    if (seconds < int.parse(usdttxnum.toString())) {
      IMWidget.showToast(StrRes.tusdtxer1);
      return;
    }
    var lastm = usdt - seconds;
    //发起远程提现操作
    try {
      var uinfo = await Apis.cashusdt(
          uid: imLogic.userInfo.value.userID,
          usdt: lastm,
          donum: seconds,
          token: token);
      IMWidget.showToast(StrRes.tusdtxs);
      var usdt = double.parse(uinfo['ex'].toString());
      //拼接新的EX值
      imLogic.userInfo.value.exinfo!.usdt = usdt;
      var ex = jsonEncode(imLogic.userInfo.value.exinfo!.toJson());
      print('---------' + ex);
      var data = imLogic.userInfo.update((val) {
        val?.ex = ex;
        val?.exinfo = imLogic.userInfo.value.exinfo;
      });
      Get.back();
    } catch (e) {
      print('login e: $e');
    }
  }
}
