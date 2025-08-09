import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/models/contacts_info.dart';

class EnvelopeLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var friendList = <ContactsInfo>[].obs;
  String lid = '';
  String title = StrRes.envelope7;
  bool hast = false;
  Map data = {};
  Map eninfo = {};
  List enlist = [];
  String tstr = '';

  ///获取红包详情信息
  geteninfo(Map data) {
    try {
      hast = data['hast'];
      eninfo = data['info'];
      //print(eninfo);
      if (hast == true) enlist = data['list'];
      tstr = eninfo['lnum'].toString() +
          '个红包共 ' +
          eninfo['lpirce'].toString() +
          ' Usdt';
      if (eninfo['ltypes'] == 3 && eninfo['lstatus'] == 1) {
        int ylnum = eninfo['lnum'] - eninfo['lnnum'];
        //print('----------' + ylnum.toString());
        double ylmoney = eninfo['lpirce'] - eninfo['lnmoney'];
        tstr = '已领取' +
            ylnum.toStringAsFixed(2).toString() +
            '/' +
            eninfo['lnum'].toString() +
            '个，共 ' +
            ylmoney.toStringAsFixed(2).toString() +
            '/' +
            eninfo['lpirce'].toString() +
            ' Usdt';
        //print('----------' + tstr);
      }
      if (eninfo['ltypes'] == 2 && eninfo['lstatus'] == 1) {
        tstr = '红包金额' + eninfo['lpirce'].toString() + 'Usdt，等待对方领取';
      }
    } catch (e) {}
  }

  @override
  void onInit() {
    lid = Get.arguments['lid'];
    if (Get.arguments['desc'] != null) title = Get.arguments['desc'];
    data = Get.arguments['info'];
    geteninfo(data);
    super.onInit();
  }
}
