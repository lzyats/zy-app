import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'workbench_logic.dart';

class WorkbenchPage extends StatelessWidget {
  final logic = Get.find<WorkbenchLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EnterpriseTitleBar.leftTitle(
        title: StrRes.workbench,
      ),
      backgroundColor: PageStyle.c_FFFFFF,
      body: Column(
        children: [
          Image.asset(
            ImageRes.ic_checkin,
            width: 800.h,
            alignment: Alignment.center,
          ),
          Container(
              // width: double.infinity,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  left: 129.h, right: 129.h, top: 14.h, bottom: 14.h),
              height: 69.h,
              color: Colors.white,
              child: // 渐变色按钮
                  Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF1DE0FA), Color(0xFF1376EE)]), // 渐变色
                    borderRadius: BorderRadius.circular(25)),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Colors.transparent, // 设为透明色
                  elevation: 0, // 正常时阴影隐藏
                  highlightElevation: 0, // 点击时阴影隐藏
                  onPressed: () => logic.singin(),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      StrRes.workbench,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )),
          Obx(() => Text(
                '${logic.name.value}',
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              )),
        ],
      ),
    );
  }
}
