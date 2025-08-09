import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/avatar_view.dart';

import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  final logic = Get.find<MineLogic>();
  final imLogic = Get.find<IMController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageStyle.c_FFFFFF,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xFF1777ff),
        title: Text(StrRes.mine),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            color: Color(0xFFffffff),
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 22.h,
            ),
            onPressed: () {
              logic.viewMyInfo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => Container(
              height: 64.h,
              color: Color(0xFF1777ff),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 14.w,
                    top: 0.h,
                    child: AvatarView(
                      size: 48.h,
                      url: imLogic.userInfo.value.faceURL,
                    ),
                  ),
                  Positioned(
                    left: 72.w,
                    top: 5.h,
                    child: Text(
                      imLogic.userInfo.value.getShowName(),
                      style: PageStyle.ts_FFFFFF_20sp,
                    ),
                  ),
                  Positioned(
                    left: 73.w,
                    top: 32.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => logic.copyID(),
                          child: Row(children: [
                            if (logic.openuserlelvel == '1')
                              Text(
                                '[' + logic.level + ']   ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: imLogic.userInfo.value.levelc,
                                ),
                              ),
                            Text(
                              'ID：${imLogic.userInfo.value.userID}',
                              style: PageStyle.ts_FFFFFF_14sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => logic.viewMyQrcode(),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImageRes.ic_mineQrCode,
                                    width: 18.w,
                                    height: 18.h,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Image.asset(
                                    ImageRes.ic_next,
                                    width: 7.w,
                                    height: 13.h,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          _buildItemView(
            icon: ImageRes.ic_myInfo,
            label: StrRes.myInfo,
            onTap: () => logic.viewMyInfo(),
          ),
          // _buildItemView(
          //   icon: ImageRes.ic_newsNotify,
          //   label: StrRes.newsNotify,
          // ),
          _buildItemView(
            icon: ImageRes.ic_accountSetup,
            label: StrRes.accountSetup,
            onTap: () => logic.accountSetup(),
          ),
          _buildItemView(
            icon: ImageRes.ic_aboutUs,
            label: StrRes.aboutUs,
            onTap: () => logic.aboutUs(),
          ),
          if (logic.morelang == '1')
            _buildItemView(
              icon: ImageRes.ic_lang,
              label: StrRes.language,
              onTap: () => logic.languageSetting(),
            ),
          if (logic.invitecode == '1')
            _buildItemView(
              icon: ImageRes.ic_tgyl,
              label: StrRes.tgyl,
              onTap: () => logic.posters(),
            ),
          _buildItemView(
            icon: ImageRes.ic_logout,
            label: StrRes.logout,
            onTap: () => logic.logout(),
          ),
        ],
      ),
    );
  }

  Widget _buildItemView({
    required String icon,
    required String label,
    Function()? onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          decoration: BoxDecoration(
              border: BorderDirectional(
            bottom: BorderSide(
              color: PageStyle.c_999999_opacity40p,
              width: 0.1,
            ),
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(icon, width: 22.w, height: 22.h),
              SizedBox(width: 13.w),
              Text(
                label,
                style: PageStyle.ts_333333_16sp,
              ),
              Spacer(),
              Image.asset(ImageRes.ic_next, width: 7.w, height: 13.h),
            ],
          ),
        ),
      );
}
