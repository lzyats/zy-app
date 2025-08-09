import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';

import 'package:openim_enterprise_chat/src/widgets/show_news_content.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';

import 'about_us_logic.dart';

class AboutUsPage extends StatelessWidget {
  final logic = Get.find<AboutUsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EnterpriseTitleBar.back(
        title: StrRes.aboutUs,
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
          Obx(() => Text(
                'V${logic.version.value}',
                style: PageStyle.ts_333333_18sp,
              )),
          SizedBox(
            height: 24.h,
          ),
          // _buildItemView(
          //   label: StrRes.goToRate,
          // ),
          _buildItemView(
            label: StrRes.checkVersion,
            onTap: logic.checkUpdate,
          ),
          _buildItemView(
            label: StrRes.new7,
            onTap: () => showLicensePage(context: context),
          ),
          _buildItemView(
            label: StrRes.appServiceAgreement,
            onTap: logic.copy,
          ),
          _buildItemView(
            label: StrRes.appPrivacyPolicy,
            onTap: logic.copy,
          ),
          _buildItemView(
            label: StrRes.copyrightInformation,
            onTap: logic.copy,
          ),
        ],
      ),
    );
  }

  Widget _buildItemView({required String label, Function()? onTap}) => Ink(
        color: PageStyle.c_FFFFFF,
        height: 58.h,
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
            child: Row(
              children: [
                Text(
                  label,
                  style: PageStyle.ts_333333_18sp,
                ),
                Spacer(),
                Image.asset(
                  ImageRes.ic_next,
                  width: 10.w,
                  height: 18.h,
                )
              ],
            ),
          ),
        ),
      );

  showLicensePage({required BuildContext context}) async {
    var newsinfo = await Apis.getinformation(logic.id.toString());
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) =>
          ShowNewsContentPage(id: logic.id.toString(), data: newsinfo),
    ));
  }
}
