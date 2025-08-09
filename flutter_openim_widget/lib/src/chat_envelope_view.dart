import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatEnvelopeView extends StatelessWidget {
  ChatEnvelopeView({
    Key? key,
    required this.data,
    required this.extension,
    required this.description,
    required this.isReceivedMsg,
  }) : super(key: key);
  final String data;
  final String extension;
  final String description;
  final bool isReceivedMsg;
  final int zoom = 15;
  final _decoder = JsonDecoder();

  @override
  Widget build(BuildContext context) {
    if (isReceivedMsg == true) {
      try {
        return Container(
          width: 210.w,
          height: 80.5.h,
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Column(
            children: [
              Stack(
                children: [
                  ImageUtil.envolopel(),
                  Positioned(
                      top: 18.h,
                      left: 54.w,
                      child: Container(
                          width: 140.w,
                          height: 70.5.h,
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xFFffffff),
                            ),
                          ))),
                  Positioned(
                      top: 20.h,
                      left: 14.w,
                      child: Container(
                        width: 173.w,
                        height: 70.5.h,
                        child: Divider(
                          height: 1.0,
                          indent: 0.0,
                          color: Color(0xFFFFDCA6),
                        ),
                      )),
                  Positioned(
                      top: 59.h,
                      left: 14.w,
                      child: Container(
                          width: 135.w,
                          height: 70.5.h,
                          child: Text(
                            extension,
                            style: TextStyle(
                              fontSize: 9.sp,
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xFFFFDCA6),
                            ),
                          ))),
                ],
              )
            ],
          ),
        );
      } catch (e) {}
    } else {
      try {
        return Container(
          width: 210.w,
          height: 80.5.h,
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Column(
            children: [
              Stack(
                children: [
                  ImageUtil.envoloper(),
                  Positioned(
                      top: 18.h,
                      left: 54.w,
                      child: Container(
                          width: 140.w,
                          height: 70.5.h,
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xFFffffff),
                            ),
                          ))),
                  Positioned(
                      top: 20.h,
                      left: 14.w,
                      child: Container(
                        width: 173.w,
                        height: 70.5.h,
                        child: Divider(
                          height: 1.0,
                          indent: 0.0,
                          color: Color(0xFFFFDCA6),
                        ),
                      )),
                  Positioned(
                      top: 59.h,
                      left: 14.w,
                      child: Container(
                          width: 135.w,
                          height: 70.5.h,
                          child: Text(
                            extension,
                            style: TextStyle(
                              fontSize: 9.sp,
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xFFFFDCA6),
                            ),
                          ))),
                ],
              )
            ],
          ),
        );
      } catch (e) {}
    }

    return Container();
  }
}
