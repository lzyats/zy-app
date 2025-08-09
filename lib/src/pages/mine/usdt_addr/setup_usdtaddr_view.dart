import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';
import 'package:openim_enterprise_chat/src/widgets/touch_close_keyboard.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:rxdart/rxdart.dart';

import 'setup_usdtaddr_logic.dart';

class SetupUsdtAddrPage extends StatelessWidget {
  final logic = Get.find<SetupUsdtAddrLogic>();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: EnterpriseTitleBar.back(
          title: StrRes.udstaddr,
        ),
        backgroundColor: PageStyle.c_FFFFFF,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 22.w,
                right: 22.w,
                top: 40.h,
              ),
              padding: EdgeInsets.only(bottom: 7.h),
              decoration: BoxDecoration(
                border: BorderDirectional(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    maxLines: 5,
                    cursorColor: Colors.blue,
                    cursorHeight: 26,
                    cursorRadius: Radius.circular(10),
                    cursorWidth: 2,
                    showCursor: true,
                    controller: logic.inputCtrl,
                    focusNode: _focusNode,
                    obscuringCharacter: "*",
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: StrRes.usdttip,
                      helperText: StrRes.usdtction,
                      counterText: '',
                      icon: Icon(Icons.attach_money),
                    ),
                    onSubmitted: (str) {},
                    textInputAction: TextInputAction.search,
                    onChanged: (content) {
                      print('_TextFieldViewState.buildView-changed:$content');
                    },
                  ),
                  Visibility(
                    visible: logic.showClearBtn.value,
                    child: GestureDetector(
                      onTap: () {
                        logic.inputCtrl.clear();
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.all(7.w),
                        child: Image.asset(
                          ImageRes.ic_clearInput,
                          color: PageStyle.c_000000_opacity40p,
                          width: 14.w,
                          height: 14.w,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                // width: double.infinity,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: 69.h, right: 69.h, top: 14.h, bottom: 14.h),
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
                    onPressed: () => logic.setupName(),
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
        ),
      ),
    );
  }

  Widget _clearBtn() => Visibility(
        visible: logic.showClearBtn.value,
        child: GestureDetector(
          onTap: () {
            logic.inputCtrl.clear();
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: EdgeInsets.all(7.w),
            child: Image.asset(
              ImageRes.ic_clearInput,
              color: PageStyle.c_000000_opacity40p,
              width: 14.w,
              height: 14.w,
            ),
          ),
        ),
      );
}
