import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/avatar_view.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';

import 'my_posters_logic.dart';

import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import 'dart:io';
import 'dart:async';

class MypostersPage extends StatelessWidget {
  final logic = Get.find<MypostersLogic>();
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  ScreenshotController screenshotController = ScreenshotController();

  int _counter = 0;
  Uint8List? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EnterpriseTitleBar.back(
            backgroundColor: Color(0xFF1777ff),
            title: StrRes.tgyl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ),
            arrcolor: Colors.white),
        backgroundColor: Color(0xFF1777ff),
        body: SingleChildScrollView(
            child: Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Color(0xFF1777ff),
                  height: 1.sh,
                  child: Stack(alignment: Alignment.topCenter, children: [
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 25.w,
                            ),
                            child: Image.asset(
                              ImageRes.ic_hp,
                              width: 350.w,
                              height: 182.w,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 75.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 25.w,
                            ),
                            child: Text(
                              '',
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 128.h,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          width: 302.w,
                          height: 434.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  color: Color(0xFF000000).withOpacity(0.08)),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 15.h,
                                width: 270.w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        StrRes.tgylm,
                                        style: PageStyle.ts_333333_24sp,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 65.h,
                                width: 270.w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Color(0xFFefefef),
                                      width: 32.h,
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        logic.invitecode.string.substring(0, 1),
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Container(
                                      color: Color(0xFFefefef),
                                      width: 32.h,
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        logic.invitecode.string.substring(1, 2),
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Container(
                                      color: Color(0xFFefefef),
                                      width: 32.h,
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        logic.invitecode.string.substring(2, 3),
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Container(
                                      color: Color(0xFFefefef),
                                      width: 32.h,
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        logic.invitecode.string.substring(3, 4),
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Container(
                                      color: Color(0xFFefefef),
                                      width: 32.h,
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        logic.invitecode.string.substring(4, 5),
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Container(
                                      color: Color(0xFFefefef),
                                      width: 32.h,
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          left: 5.h,
                                          right: 5.h,
                                          bottom: 5.h),
                                      child: Text(
                                        logic.invitecode.string.substring(5, 6),
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 113.h,
                                width: 262.w,
                                child: Text(
                                  StrRes.tgylmtip1,
                                  style: PageStyle.ts_999999_14sp,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Positioned(
                                top: 144.h,
                                width: 272.w,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 180.h,
                                    height: 180.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFEB2B2),
                                          Color(0xFF5496E4),
                                        ],
                                      ),
                                    ),
                                    child: QrImage(
                                      data: logic.buildQRContent(),
                                      size: 176.h,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 333.h,
                                width: 262.w,
                                child: Text(
                                  StrRes.tgylmtip2,
                                  style: PageStyle.ts_999999_14sp,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Positioned(
                                top: 364.h,
                                width: 282.w,
                                child: GestureDetector(
                                  onTap: () => save(),
                                  child: Container(
                                    height: 42.h,
                                    width: 262.w,
                                    padding: EdgeInsets.only(
                                      top: 3.h,
                                      bottom: 4.5.h,
                                      left: 40.w,
                                      right: 40.w,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: PageStyle.c_1B72EC,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      StrRes.saveimg,
                                      style: PageStyle.ts_FFFFFF_16sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 584.h,
                      width: 302.w,
                      child: GestureDetector(
                        onTap: () => saveimg(),
                        child: Container(
                          height: 42.h,
                          width: 262.w,
                          padding: EdgeInsets.only(
                            top: 3.h,
                            bottom: 4.5.h,
                            left: 10.w,
                            right: 10.w,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: PageStyle.c_FFFFFF,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            StrRes.tgylmtip3,
                            style: PageStyle.ts_333333_16sp,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ))));
  }

  void save() async {
    screenshotController
        .capture(delay: Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/share.png').create();
        await imagePath.writeAsBytes(image);
        await Share.shareFiles([imagePath.path]);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void saveimg() {
    Share.share('${logic.appdown!}', subject: '邀请好友赢丰厚礼品');
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
}
