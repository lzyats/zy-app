import 'package:flutter/material.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';

class ShowNewsContentPage extends StatefulWidget {
  const ShowNewsContentPage({Key? key, required this.id, required this.data})
      : super(key: key);
  final String id;
  final Map data;

  @override
  _ShowNewsContentPage createState() => _ShowNewsContentPage();
}

class _ShowNewsContentPage extends State<ShowNewsContentPage> {
  Map info = {};

  @override
  void initState() {
    setState(() {
      info = widget.data;
    });
    super.initState();
  }

  @override
  void dispose() {
    info.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.backn(
        context,
        backgroundColor: Colors.blue,
        arrColor: Colors.white,
        height: 49.h,
        title: StrRes.new1,
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
          SizedBox(height: 15),
          IconTheme(
              data: Theme.of(context).iconTheme,
              child: Image.asset(
                'assets/images/ic_app.webp',
                height: 35,
                width: 35,
              )),
          Text(info['title'],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 6),
          Text(info['ctime'],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption),
          const SizedBox(height: 6),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Color(0xFF333333),
          ),
          Ink(
            color: PageStyle.c_FFFFFF,
            height: 570.h,
            child: InkWell(
              onTap: () => {},
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                  child: SingleChildScrollView(
                    child: Text(
                      info['text'],
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
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            InkWell(
                onTap: () => showLicensePage(info['last'].toString()),
                child: Container(
                  width: 60.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                  child: SingleChildScrollView(
                    child: Text(
                      StrRes.new2,
                      style: PageStyle.ts_333333_14sp,
                    ),
                  ),
                )),
            Expanded(child: SizedBox(height: 6)),
            InkWell(
                onTap: () => showLicensePage(info['next'].toString()),
                child: Container(
                  width: 60.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                  child: SingleChildScrollView(
                    child: Text(
                      StrRes.new3,
                      style: PageStyle.ts_333333_14sp,
                    ),
                  ),
                )),
          ])
        ],
      ),
    );
  }

  showLicensePage(String id) async {
    if (id == 'null') {
      return;
    }
    var binfo = await Apis.getinformation(id);
    setState(() {
      info = binfo;
    });
  }
}
