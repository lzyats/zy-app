import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/routes/app_navigator.dart';
import 'package:openim_enterprise_chat/src/models/group_member_info.dart' as en;
import 'package:openim_enterprise_chat/src/pages/chat/group_setup/group_member_manager/member_list/member_list_logic.dart';

///
/// 红包类
class ChatEnvelope extends StatefulWidget {
  const ChatEnvelope({
    Key? key,
    required this.types,
    required this.groupid,
    required this.members,
  }) : super(key: key);

  final int types;
  final int members;
  final String groupid;

  @override
  _ChatEnvelopeState createState() => _ChatEnvelopeState();
}

class _ChatEnvelopeState extends State<ChatEnvelope> {
  final GlobalKey webViewKey = GlobalKey();
  var inputCtrm = TextEditingController();
  var inputCtrd = TextEditingController();
  var inputCtr = TextEditingController();

  FocusNode _commentFocus = FocusNode();
  FocusNode _commentFocus1 = FocusNode();

  var loginCertificate = DataPersistence.getLoginCertificate();

  String? get uid => loginCertificate?.userID;

  int members = 2;
  double money = 0;
  String? extension; //定义红包类型
  String description = UILocalizations.envelope7;
  String lid = DateTime.now().millisecondsSinceEpoch.toString();
  String rid = '';
  String lrid = '';

  var memberList = <en.GroupMembersInfo>[].obs;
  var action = OpAction.RED;

  static String _getOperationID() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  final imLogic = Get.find<IMController>();

  @override
  void initState() {
    super.initState();
    members = 1;
    switch (widget.types) {
      case 1:
        extension = UILocalizations.envelope1;
        break;
      case 2:
        extension = UILocalizations.envelope2;
        break;
      default:
        members = 2;
        extension = UILocalizations.envelope3;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  static var textStyle = TextStyle(
    fontSize: 14.sp,
    color: Color(0xFF333333),
    textBaseline: TextBaseline.alphabetic,
  );

  static var atStyle = TextStyle(
    fontSize: 14.sp,
    color: Colors.blue,
    textBaseline: TextBaseline.alphabetic,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.back(
        context,
        height: 49.h,
        title: extension,
        //backgroundColor: Colors.red,
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: Color(0xFF333333),
        ),
        right: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dohb();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Text(
              '....',
              style: TextStyle(
                fontSize: 18.sp,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (widget.types == 3)
              Container(
                margin: EdgeInsets.only(top: 8.h, left: 22.w, right: 22.w),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.08),
                      blurRadius: 7,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                        top: 15.w,
                        bottom: 15.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            UILocalizations.envelope6,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xFF000000),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          Container(
                              width: 120.w,
                              child: TextField(
                                keyboardType: TextInputType.number, //键盘类型，数字键盘
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xFF333333),
                                ),
                                focusNode: _commentFocus1,
                                controller: inputCtr,
                                autofocus: true,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  hintText: members.toString(),
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')), //只输入数字
                                  LengthLimitingTextInputFormatter(6) //限制长度
                                ],
                                onChanged: (value) {
                                  //print("你输入的内容为$value");
                                  if (value.length > 0)
                                    members = int.parse(value);
                                },
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.types == 2)
              Container(
                margin: EdgeInsets.only(top: 8.h, left: 22.w, right: 22.w),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.08),
                      blurRadius: 7,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: transferGroup,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                          top: 15.w,
                          bottom: 15.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              UILocalizations.envelope14,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Container(
                              width: 190.w,
                              child: Text(
                                lrid,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            Container(
                              width: 20.w,
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: Image.asset(
                                  ImageRes.ic_next,
                                  width: 10.w,
                                  height: 17.h,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 8.h, left: 22.w, right: 22.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.08),
                    blurRadius: 7,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      top: 15.w,
                      bottom: 15.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          UILocalizations.envelope5,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                        ),
                        Container(
                            width: 120.w,
                            child: TextField(
                              keyboardType: TextInputType.number, //键盘类型，数字键盘
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xFF333333),
                              ),
                              focusNode: _commentFocus,
                              controller: inputCtrm,
                              autofocus: true,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintText: '￥0.00',
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.]')), //只输入数字
                                LengthLimitingTextInputFormatter(6) //限制长度
                              ],
                              onChanged: (value) {
                                //print("你输入的内容为$value");
                                if (value.length > 0)
                                  changemoney(double.parse(value));
                              },
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.h, left: 22.w, right: 22.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.08),
                    blurRadius: 7,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      top: 15.w,
                      bottom: 15.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 295.w,
                            child: TextField(
                              keyboardType: TextInputType.text, //键盘类型，汉字
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xFF333333),
                              ),
                              controller: inputCtrd,
                              autofocus: true,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintText: description,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(
                                    '[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]')), //只能输入汉字或者字母或数字
                                LengthLimitingTextInputFormatter(14) //限制长度
                              ],
                              onChanged: (value) {
                                //print("你输入的内容为$value");
                                if (value.length > 0) description = value;
                              },
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "￥" + money.toString(),
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48.sp,
                color: Color(0xFF333333),
              ),
            ),
            Container(
              // width: double.infinity,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  left: 89.h, right: 89.h, top: 22.h, bottom: 22.h),
              height: 89.h,
              color: Colors.white,
              child: Container(
                height: 40.h,
                width: 120.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: RaisedButton(
                  color: Colors.transparent, // 设为透明色
                  elevation: 0, // 正常时阴影隐藏
                  highlightElevation: 0, // 点击时阴影隐藏
                  onPressed: () => dohb(),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      UILocalizations.envelope4,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changemoney(double moneys) {
    setState(() {
      money = moneys;
    });
  }

  getGroupMembers() async {
    var list = await OpenIM.iMManager.groupManager.getGroupMemberListMap(
      groupId: widget.groupid,
    );

    var l = list.map((e) => en.GroupMembersInfo.fromJson(e));
    memberList.assignAll(l);
  }

  void transferGroup() async {
    getGroupMembers();
    var list = memberList;
    list.removeWhere((e) => e.userID == uid);
    var result = await AppNavigator.startGroupMemberList(
      gid: widget.groupid,
      list: list,
      action: OpAction.RED,
    );
    if (result != null) {
      lrid = result.nickname;
      rid = result.userID;
    }
  }

  static void showToast(String msg) {
    if (msg.trim().isNotEmpty) EasyLoading.showToast(msg);
  }

  //设置红包金额
  setmoney(String value) {
    if (value.length > 0) money = double.parse(value);
  }

  void dohb() async {
    lid = _getOperationID();
    //print('---------lid--' + lid);

    if (widget.types == 3) {
      if (members == null || members < 1) {
        showToast(UILocalizations.envelope9);
        FocusScope.of(context).requestFocus(_commentFocus1);
        return;
      }
      if (members > widget.members) {
        showToast(UILocalizations.envelope10);
        FocusScope.of(context).requestFocus(_commentFocus1);
        return;
      }
    }
    if (widget.types == 2) {
      if (lrid == '' || lrid == null) {
        //showToast(UILocalizations.envelope15);
        transferGroup();
        return;
      }
    }
    if (money == null || money < 0.01) {
      showToast(UILocalizations.envelope8);
      FocusScope.of(context).requestFocus(_commentFocus);
      return;
    }
    //输入查询密码
    var rlue = await Get.toNamed('/register_verify_phoneo', arguments: {
      'usedFor': 1,
    });
    if (rlue == null) return;
    //查询USDT金额是否够支付
    try {
      await LoadingView.singleton.wrap(asyncFunction: () async {
        var info = await Apis.setenvelope(uid!, rid, widget.types, members,
            money, widget.groupid, extension!, description, lid);
        ExInfoCertificate exinfo = ExInfoCertificate.fromJson(info['ex']);
        if (exinfo.usdt! < money) {
          showToast(UILocalizations.envelope13);
          return;
        }
        var ex = jsonEncode(exinfo);
        //更新当前用户信息
        await OpenIM.iMManager.userManager
            .setSelfInfo(ex: ex)
            .then((value) => imLogic.userInfo.update((val) {
                  val?.ex = ex;
                  val?.exinfo = exinfo;
                }));
      });
    } catch (e) {
      //print('login e: $e');
      return;
    }
    Navigator.pop(context, {
      'lid': lid,
      'uid': uid,
      'rid': rid,
      'types': widget.types,
      'members': members,
      'money': money,
      'groupid': widget.groupid,
      'extension': extension,
      'description': description,
    });
  }
}
