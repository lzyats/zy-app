import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';

import 'package:city_pickers/city_pickers.dart';

import 'my_addr_logic.dart';

class MyAddrPage extends StatelessWidget {
  final logic = Get.find<MyAddrLogic>();
  final imLogic = Get.find<IMController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EnterpriseTitleBar.back(
          title: StrRes.myaddr,
        ),
        backgroundColor: PageStyle.c_FFFFFF,
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 22.w, top: 22.w),
                    child: Icon(Icons.add_location),
                  ),
                  Text("省/市/区", style: TextStyle(color: Colors.black54)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 22.w,
                  right: 22.w,
                ),
                padding: EdgeInsets.only(bottom: 7.h),
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      width: 1,
                      color: PageStyle.c_999999,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setaddr(context),
                        child: Container(
                            height: 60.h,
                            padding: EdgeInsets.only(
                              top: 3.h,
                              bottom: 4.5.h,
                              left: 10.w,
                              right: 10.w,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(logic.ucitys.string,
                                style: TextStyle(color: Colors.black54))),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 22.w, top: 22.w),
                    child: Icon(Icons.add_location),
                  ),
                  Text("详细地址", style: PageStyle.ts_333333_16sp),
                ],
              ),
              Container(
                height: 60.h,
                margin: EdgeInsets.only(
                  left: 22.w,
                  right: 22.w,
                ),
                padding: EdgeInsets.only(bottom: 7.h),
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      width: 1,
                      color: PageStyle.c_999999,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          style: PageStyle.ts_333333_16sp,
                          controller: logic.inputCtrladdr,
                          // focusNode: logic.focusNode,
                          autofocus: true,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintText: logic.uaddr.string,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
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
                            gradient: LinearGradient(colors: [
                              Color(0xFF1DE0FA),
                              Color(0xFF1376EE)
                            ]), // 渐变色
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
                              StrRes.save,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
  }

  void setaddr(BuildContext context) async {
    Result? result1 = await CityPickers.showFullPageCityPicker(
      context: context,
    );
    print(result1);
    if (result1 != null) {
      logic.ucitys.value =
          "${result1.provinceName}${result1.cityName}${result1.areaName}";
      logic.inputCtrlcity.text = logic.ucitys.string;
    }
  }
}
