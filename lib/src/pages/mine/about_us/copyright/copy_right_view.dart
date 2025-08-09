import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';

import 'copy_right_logic.dart';

class CopyRightPage extends StatelessWidget {
  final logic = Get.find<CopyRightLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EnterpriseTitleBar.back(
        title: StrRes.appServiceAgreement,
      ),
      backgroundColor: PageStyle.c_F8F8F8,
      body: Column(
        children: [
          SizedBox(
            height: 24.h,
          ),
          Image.asset(
            ImageRes.ic_app,
            width: 74.h,
            height: 74.h,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            logic.name.value,
            style: PageStyle.ts_333333_18sp,
          ),
          SizedBox(
            height: 24.h,
          ),
          // _buildItemView(
          //   label: StrRes.goToRate,
          // ),
          // _buildItemView(
          //   label: StrRes.checkVersion,
          //   onTap: logic.checkUpdate,
          // ),
          _buildItemView(
            label: StrRes.copyright,
          ),
        ],
      ),
    );
  }

  Widget _buildItemView({required String label, Function()? onTap}) => Ink(
        color: PageStyle.c_FFFFFF,
        height: 558.h,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: PageStyle.c_999999_opacity40p,
                  width: 0.5,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 28.w),
              child: SingleChildScrollView(
                child: Text(
                  label,
                  maxLines: 50,
                  style: PageStyle.ts_333333_14sp,
                ),
              ),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                    color: PageStyle.c_999999_opacity40p,
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
