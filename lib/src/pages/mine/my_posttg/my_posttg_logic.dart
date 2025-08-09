import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:flutter/material.dart';

class MyposttgLogic extends GetxController {
  // late Rx<UserInfo> userInfo;
  final imLogic = Get.find<IMController>();
  List<dynamic> inlist = [].obs;
  var load = true.obs;
  var kb = ''.obs;
  int page = 1;
  bool end = false;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    // userInfo = Get.arguments;
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //达到最大滚动位置
        if (end == false) getlist(page);
      }
    });
  }

  @override
  void onReady() {
    getlist(page);
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController.dispose();
    super.onClose();
  }

  void getlist(int? page) async {
    List<dynamic> tlist = [];
    try {
      await LoadingView.singleton.wrap(asyncFunction: () async {
        var data = await Apis.getinlist(
            uid: imLogic.userInfo.value.userID, page: page);
        if (data['have'] == true) {
          if (page == 1) {
            inlist = data['list'];
          } else {
            await Future.delayed(Duration(seconds: 2), () {
              inlist..addAll(data['list']);
            });
          }
        }
        if (data['next'] == true) {
          this.page++;
        } else {
          this.end = true;
        }
      });
      print(inlist.last.toString());
      print(inlist.length.toString());
    } catch (e) {}
    load.value = false;
  }
}
