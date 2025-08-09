import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/core/controller/jpush_controller.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/models/exserver_info.dart';
import 'package:openim_enterprise_chat/src/models/announcement.dart';

class SplashLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  final jPushLogic = Get.find<JPushController>();

  var loginCertificate = DataPersistence.getLoginCertificate();

  bool get isExistLoginCertificate => loginCertificate != null;

  String? get uid => loginCertificate?.userID;

  String? get token => loginCertificate?.token;

  getexserver() async {
    try {
      var ex = await Apis.ex_server();
      print(ex);
      ex = ExCertificate.fromJson(ex!);
      await DataPersistence.putExinfo(ex);
      print('---------get ex info success---');
      return true;
    } catch (e) {
      print('login e: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    imLogic.initializedSubject.listen((value) async {
      try {
        var ex = await Apis.ex_server();
        print(ex);
        ex = ExCertificate.fromJson(ex!);
        await DataPersistence.putExinfo(ex);
        print('---------get ex info success---');
        //获取公告信息
        var ggdata = await Apis.getinformation('');
        ggdata = AnnCertificate.fromJson(ggdata!);
        await DataPersistence.putAnninfo(ggdata);
        print('---------------------initialized---------------------');
        if (isExistLoginCertificate) {
          await _login();
        } else {
          AppNavigator.startLogin();
        }
      } catch (e) {
        print('login e: $e');
      }
    });
    super.onReady();
  }

  _login() async {
    try {
      //先通知服务器静默免密登录
      var data = await Apis.userlogin(
          areaCode: '',
          phoneNumber: uid,
          email: '',
          password: '',
          silent: true);
      print('---------login--------- uid: $uid, token: $token');
      await imLogic.login(uid!, token!);
      print('---------im login success-------');
      jPushLogic.login(uid!);
      print('---------jpush login success----');
      AppNavigator.startMain();
    } catch (e) {
      IMWidget.showToast(StrRes.loginerror);
      AppNavigator.startLogin();
    }
  }
}
