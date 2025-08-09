import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';
import 'package:openim_enterprise_chat/src/widgets/touch_close_keyboard.dart';
import 'package:openim_enterprise_chat/src/widgets/verify_code_send_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';

import 'verifyphone_logic.dart';

class VerifyPhoneoPage extends StatelessWidget {
  final logic = Get.find<VerifyPhoneoLogic>();
  final color1 = const Color(0xFF999999);
  final color2 = const Color(0xFF1D6BED);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EnterpriseTitleBar.backButton(left: 0),
                  SizedBox(height: 49.h),
                  Text(
                    StrRes.envelope8,
                    style: PageStyle.ts_333333_26sp,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 28.h),
                  PinCodeTextField(
                    appContext: context,
                    autoFocus: true,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    obscuringWidget: Image.asset(
                      ImageRes.ic_app,
                      width: 25.w,
                      height: 25.w,
                    ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      return null;
                      // if (v!.length < 3) {
                      //   return "I'm from validator";
                      // } else {
                      //   return null;
                      // }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: color2,
                      selectedColor: color2,
                      inactiveColor: color1,
                      disabledColor: color1,
                      activeFillColor: color1,
                      selectedFillColor: color1,
                      inactiveFillColor: color1,
                      // borderRadius: BorderRadius.circular(5),
                      // fieldHeight: 50,
                      // fieldWidth: 40,
                      // activeFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    // enableActiveFill: true,
                    errorAnimationController: logic.codeErrorCtrl,
                    // controller: logic.codeEditCtrl,
                    keyboardType: TextInputType.number,
                    // boxShadows: [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   )
                    // ],
                    onCompleted: (v) {
                      logic.onCompleted(v);
                      //if (logic.onCompleted(v) == true) {
                      //Get.back();
                      //Navigator.pop(context, {'check': true});
                      //}
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
