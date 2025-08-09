import 'dart:convert';

import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';

class WorkbenchLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var name = "".obs;

  var loginCertificate = DataPersistence.getLoginCertificate();

  bool get isExistLoginCertificate => loginCertificate != null;

  String? get uid => loginCertificate?.userID;

  String? get token => loginCertificate?.token;

  var exCertificate = DataPersistence.getExinfo();

  String? get signusdt => exCertificate?.signusdt;

  String? get usdttxnum => exCertificate?.usdttxnum;

  var time = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch);

  void singin() async {
    try {
      var info = await Apis.sing_in(
          uid: imLogic.userInfo.value.userID,
          ex: imLogic.userInfo.value.ex,
          token: token);
      //log('---------sign--${info}');
      var ex = info['ex'].toString();
      IMWidget.showToast(StrRes.workbenchsu);
      imLogic.userInfo.update((val) {
        val?.ex = ex;
        val?.exinfo = ExInfoCertificate.fromJson(jsonDecode(ex));
      });
    } catch (e) {}
  }

  @override
  void onInit() {
    final a = StrRes.signtext;
    //sprintf(a, [signusdt])
    name.value = sprintf(a, [signusdt, usdttxnum]);
    super.onInit();
  }
}
