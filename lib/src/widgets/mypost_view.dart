import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/widgets/avatar_view.dart';
import 'package:intl/intl.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({
    Key? key,
  }) : super(key: key);
  @override
  MyPostPageState createState() => new MyPostPageState();
}

class MyPostPageState extends State<MyPostPage> {
  final imLogic = Get.find<IMController>();
  List<dynamic> inlist = [];
  var load = true;
  var kb = '';
  int page = 1;
  bool end = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getlist(page);
    super.initState();
    scrollController = ScrollController();
    scrollController
      ..addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          //达到最大滚动位置
          if (end == false) getlist(page);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Future<void> _refresh() async {
    return;
    setState(() {
      this.page = 1;
      this.end = false;
    });
    getlist(page);
  }

  void getlist(int page) async {
    try {
      await LoadingView.singleton.wrap(asyncFunction: () async {
        var data = await Apis.getinlist(
            uid: imLogic.userInfo.value.userID, page: page);
        if (data['have'] == true) {
          if (page == 1) {
            setState(() {
              inlist = data['list'];
            });
          } else {
            await Future.delayed(Duration(seconds: 2), () {
              setState(() {
                inlist..addAll(data['list']);
              });
            });
          }
        }
        if (data['next'] == true) {
          setState(() {
            this.page++;
          });
        } else {
          setState(() {
            this.end = true;
          });
        }
      });
      print(inlist.last.toString());
      print(inlist.length.toString());
    } catch (e) {}
    setState(() {
      this.load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: EnterpriseTitleBar.back(title: StrRes.mytg),
        body: load == true
            ? _buildItemViewl()
            : inlist.length < 1
                ? _buildItemViewn()
                : _buildItemallView());
  }

  Widget _buildItemViewl() => Column(children: [
        Container(
            width: 1.sh,
            height: 1.sw,
            color: Colors.white,
            // margin: EdgeInsets.only(left: 20, top: -50), // 报错: 不支持负数边距值
            transform: Matrix4.translationValues(0.0, -1.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(), //没有数据就转圈
                )
              ],
            )),
        SizedBox(
          width: 5.w,
          height: 15.h,
        )
      ]);

  Widget _buildItemViewn() => Column(children: [
        Container(
            width: 1.sh,
            height: 1.sw,
            color: Colors.white,
            // margin: EdgeInsets.only(left: 20, top: -50), // 报错: 不支持负数边距值
            transform: Matrix4.translationValues(0.0, -1.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageRes.ic_emptyTag,
                  height: 123.h,
                ),
                Text(StrRes.tgylmtip4)
              ],
            )),
        SizedBox(
          width: 5.w,
          height: 15.h,
        )
      ]);

  Widget _buildItemallView() => Column(
        children: [
          Row(
            children: [
              Container(
                  child: SizedBox(
                height: 48.h,
              )),
              Container(
                  padding: EdgeInsets.only(
                    left: 45.w,
                    right: 5.w,
                    top: 5.h,
                  ),
                  child: Text(StrRes.nickname)),
              Expanded(child: Text('')),
              Container(
                  padding: EdgeInsets.only(
                    left: 45.w,
                    right: 35.w,
                    top: 5.h,
                  ),
                  child: Text(StrRes.ctime)),
            ],
          ),
          Expanded(child: _buildItemView())
        ],
      );
  Widget _buildItemView() => RefreshIndicator(
        onRefresh: _refresh,
        displacement: 40.0,
        child: new ListView.builder(
            reverse: false,
            shrinkWrap: true,
            controller: scrollController,
            itemCount: inlist.length,
            itemBuilder: (context, index) {
              if (index == inlist.length) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return _itemView(inlist[index]);
            }),
      );

  Widget _itemView(Map list) => Row(
        children: [
          Container(
              child: SizedBox(
            height: 68.h,
            child: Text(kb),
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
                    url: list['face_url'],
                    enabledPreview: true,
                  ))),
          Container(
            child: Column(children: [
              Row(children: [
                Container(
                  width: 180.w,
                  child: Text(
                    list['name'],
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
                    DateFormat('MM-dd HH:mm').format(
                        DateFormat('yyyy-MM-dd HH:mm:ss')
                            .parse(list['create_time'])),
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
                  padding: EdgeInsets.only(left: 3.w, right: 5.w, top: 5.w),
                  child: Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(
                        DateFormat('yyyy-MM-dd HH:mm:ss')
                            .parse(list['create_time'])),
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
        ],
      );
}
