import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_enterprise_chat/src/widgets/avatar_view.dart';
import 'package:intl/intl.dart';

import 'envelope_logic.dart';

class EnvelopePage extends StatelessWidget {
  final logic = Get.find<EnvelopeLogic>();
  List<Map> list =
      List.generate(5, (index) => {'val': "This is title $index element"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.backn(
        context,
        backgroundColor: Color(0xFFf25542),
        arrColor: Colors.white,
        height: 49.h,
        title: '',
        //backgroundColor: Colors.red,
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: Color(0xFFFFFFFF),
        ),
        right: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Text(
              '....',
              style: TextStyle(
                fontSize: 18.sp,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            // margin: EdgeInsets.only(left: 20, top: -50), // 报错: 不支持负数边距值
            transform: Matrix4.translationValues(0.0, -1.0, 0.0),
            child: Image.asset(
              ImageRes.ic_redtop,
              width: 1800.h,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            width: 5.w,
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: AvatarView(
                    size: 24.h,
                    url: logic.eninfo['face_url'],
                    enabledPreview: true,
                  )),
              SizedBox(
                width: 5.w,
              ),
              Text(
                logic.eninfo['name'].toString() + "的红包",
                style: TextStyle(
                    fontSize: 17.sp,
                    color: Color(0xFF181818),
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 5.w,
              height: 5.h,
            ),
            Text(
              logic.title,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Color(0xFFB4B4B4),
                  fontWeight: FontWeight.w400),
            )
          ]),
          SizedBox(
            width: 5.w,
            height: 15.h,
          ),
          if (logic.eninfo['ltypes'] != 2 && logic.eninfo['lstatus'] != 1)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                double.parse(logic.data['myusdt'].toString()).toString(),
                style: TextStyle(
                    fontSize: 50.sp,
                    color: Color(0xFFd0ad75),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                    top: 15.w,
                    bottom: 1.h,
                  ),
                  child: Text(
                    "Usdt",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFFd0ad75),
                        fontWeight: FontWeight.w600),
                  ))
            ]),
          if (logic.eninfo['ltypes'] != 2 && logic.eninfo['lstatus'] != 1)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                    top: 10.h,
                    bottom: 5.h,
                  ),
                  child: Text(
                    StrRes.envelope6,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFFd0ad75),
                        fontWeight: FontWeight.w600),
                  ))
            ]),
          SizedBox(
            width: 5.w,
            height: 25.h,
          ),
          if (logic.hast == true ||
              (logic.eninfo['ltypes'] == 2 && logic.eninfo['lstatus'] == 1))
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.only(
                    left: 15.w, right: 5.w, top: 1.h, bottom: 10.h),
                child: Text(
                  logic.tstr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xFFB4B4B4),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ]),
          if (logic.hast == true ||
              (logic.eninfo['ltypes'] == 2 && logic.eninfo['lstatus'] == 1))
            Divider(
              height: 1.0,
              indent: 0.0,
              color: Color(0xFFe5e5e5),
            ),
          if (logic.hast == true)
            SizedBox(
              width: 15.w,
            ),
          if (logic.hast == true)
            Expanded(
              child: ListView.builder(
                  itemCount: logic.enlist.length,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      Container(
                          child: SizedBox(
                        height: 68.h,
                      )),
                      Container(
                          padding: EdgeInsets.only(
                            left: 15.w,
                            right: 5.w,
                            top: 5.h,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.w),
                              child: AvatarView(
                                size: 42.h,
                                url: logic.enlist[index]['face_url'],
                                enabledPreview: true,
                              ))),
                      Container(
                        child: Column(children: [
                          Row(children: [
                            Container(
                              width: 180.w,
                              child: Text(
                                logic.enlist[index]['name'],
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0xFF181818),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: 10.w,
                              ),
                              width: 120.w,
                              child: Text(
                                double.parse(logic.enlist[index]['rusdt']
                                            .toString())
                                        .toStringAsFixed(2)
                                        .toString() +
                                    ' Usdt',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0xFF181818),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                          Container(
                              width: 308.w,
                              padding: EdgeInsets.only(
                                  left: 3.w, right: 5.w, top: 5.w),
                              child: Text(
                                DateFormat('HH:mm').format(
                                    DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .parse(logic.enlist[index]['ratime'])),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xFFB4B4B4),
                                    fontWeight: FontWeight.w400),
                              )),
                          Container(
                            padding: EdgeInsets.only(top: 15.h),
                            width: 310.w,
                            height: 5.h,
                            child: Divider(
                              height: 1.0,
                              indent: 0.0,
                              color: Color(0xFFe5e5e5),
                            ),
                          ),
                        ]),
                      ),
                    ]);
                  }),
            ),
        ],
      ),
    );
  }
}
