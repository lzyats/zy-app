import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';

import 'package:openim_enterprise_chat/src/widgets/bottom_sheet_view.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:sprintf/sprintf.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/models/usdt_info.dart';
import 'package:openim_enterprise_chat/src/models/useraddr_info.dart';
import 'package:openim_enterprise_chat/src/widgets/mypost_view.dart';
import 'dart:convert';

class MyInfoLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  var ex;
  var exCertificate = DataPersistence.getExinfo();
  String? get usdttxnum => exCertificate?.usdttxnum;
  String? get openusdtwith => exCertificate?.openusdtwith;
  String? get isinvitecode => exCertificate?.invitecode;

  var usdtCertificate = DataPersistence.getUsdtinfo();
  String? get addr => usdtCertificate?.addr;

  var userAddrCertificate = DataPersistence.getUserAddrinfo();
  String? get uaddr => userAddrCertificate?.addr;
  String? get ucitys => userAddrCertificate?.citys;

  @override
  void onInit() {
    setusdt();
    //print('-----$addr');
    super.onInit();
  }

  void setusdt() {
    ex = imLogic.userInfo.value.ex;
    //兼容以前数据
    if (Apis.isNumeric(ex)) {
      ex = '{"usdt": 0, "mangerlevel": 1, "level": 1}';
    }
  }

  void setupUserName() {
    AppNavigator.startSetUserName();
    // Get.toNamed(AppRoutes.SETUP_USER_NAME);
  }

  void myQrcode() {
    AppNavigator.startMyQrcode();
    // Get.toNamed(AppRoutes.MY_QRCODE);
  }

  void myID() {
    AppNavigator.startMyID();
    // Get.toNamed(AppRoutes.MY_ID);
  }

  void udstaddr() async {
    var uaddr = '';
    //print('-----------${this.addr}');
    try {
      if (addr == null) {
        var ex = await Apis.get_usdt_addr(uid: imLogic.userInfo.value.userID);
        if (ex['addr'] != null) {
          uaddr = ex['addr'];
          ex = UsdtCertificate.fromJson(ex!);
          var put = await DataPersistence.putUsdtinfo(ex);
          print('-----------$put');
        }
      } else {
        uaddr = this.addr ?? '';
      }
    } catch (e) {
      print('login e: $e');
    }
    AppNavigator.startUsdtAddr(usdtaddr: uaddr);
  }

  void openPhotoSheet() {
    IMWidget.openPhotoSheet(onData: (path, url) {
      if (url != null) {
        OpenIM.iMManager.userManager.setSelfInfo(faceURL: url);
      }
    });
  }

  void tusdt() async {
    try {
      if (openusdtwith != '1') return;
      var usdt = imLogic.userInfo.value.exinfo!.usdt;
      double num = 10;
      print('------${usdttxnum}-------');
      //判断金额

      if (usdttxnum != null) num = double.parse(usdttxnum.toString());
      if (usdt! < num) {
        IMWidget.showToast(sprintf(StrRes.signtextj, [num]));
        return;
      }
      AppNavigator.startUsdtdo();
    } catch (e) {
      // AppNavigator.startLogin();
    }
  }

  void myadd() async {
    //获取远程地址信息
    var usaddr = '';
    var uscity = '';
    //print('-----------${this.addr}');
    try {
      if (uaddr == null) {
        var ex = await Apis.getuseraddr(uid: imLogic.userInfo.value.userID);
        if (ex['addr'] != null) {
          usaddr = ex['addr'];
          uscity = ex['citys'];
          ex = UserAddrCertificate.fromJson(ex!);
          var put = await DataPersistence.putUserAddrinfo(ex);
        }
      } else {
        usaddr = this.uaddr ?? '';
        uscity = this.ucitys ?? '';
      }
      print('-----------$usaddr');
      Get.toNamed('/my_addr', arguments: {'usaddr': usaddr, 'uscity': uscity});
    } catch (e) {
      print('login e: $e');
    }
  }

  void mytg() async {
    //AppNavigator.startPosttg();
    await Get.to(() => MyPostPage());
  }

  void openDatePicker() {
    var appLocale = Get.locale;
    var format = "yyyy/MM/dd";
    var locale = DateTimePickerLocale.en_us;
    if (appLocale!.languageCode.toLowerCase().contains("zh")) {
      format = "yyyy年/MM月/dd日";
      locale = DateTimePickerLocale.zh_cn;
    }
    DatePicker.showDatePicker(
      Get.context!,
      locale: locale,
      dateFormat: format,
      maxDateTime: DateTime.now(),
      onConfirm: (dateTime, List<int> selectedIndex) {
        _updateBirthday(dateTime.toString());
      },
    );
  }

  void selectGender() {
    Get.bottomSheet(
      BottomSheetView(
        items: [
          SheetItem(
            label: StrRes.man,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            onTap: () => _updateGender(1),
          ),
          SheetItem(
            label: StrRes.woman,
            onTap: () => _updateGender(2),
          ),
        ],
      ),
    );
  }

  void _updateGender(int gender) {
    LoadingView.singleton.wrap(
      asyncFunction: () => OpenIM.iMManager.userManager
          .setSelfInfo(gender: gender)
          .then((value) => imLogic.userInfo.update((val) {
                val?.gender = gender;
              })),
    );
  }

  void _updateBirthday(String birthday) {
    //把时间转为时间戳
    var ttime = DateTime.parse(birthday);
    var _intendtime = ttime.millisecondsSinceEpoch;
    print('----time--${_intendtime}--------');
    LoadingView.singleton.wrap(
      asyncFunction: () => OpenIM.iMManager.userManager
          .setSelfInfo(birth: _intendtime)
          .then((value) => imLogic.userInfo.update((val) {
                val?.birth = _intendtime;
              })),
    );
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
}
