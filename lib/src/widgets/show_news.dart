import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/pages/home/home_logic.dart';
import 'package:openim_enterprise_chat/src/widgets/show_news_content.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowNewsDialog extends StatelessWidget {
  const ShowNewsDialog({
    Key? key,
    //required this.content,
    this.applicationName,
    this.applicationVersion,
    this.applicationLegalese,
    this.children,
  }) : super(key: key);
  //final BuildContext content;
  final String? applicationName;
  final String? applicationVersion;
  final String? applicationLegalese;
  final List<Widget>? children;

  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final String name = applicationName!;
    final String version = applicationVersion!;
    final annCertificate = DataPersistence.getAnninfo();
    final logic = Get.find<HomeLogic>();
    final Widget? icon = Image.asset(
      'assets/images/ic_app.webp',
      height: 35,
      width: 35,
    );
    return AlertDialog(
      content: ListBody(
        children: <Widget>[
          IconTheme(data: Theme.of(context).iconTheme, child: icon!),
          Text(name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 6),
          Text(version,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption),
          const SizedBox(height: 6),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Color(0xFF333333),
          ),
          const SizedBox(height: 12),
          Ink(
            color: PageStyle.c_FFFFFF,
            height: 320.h,
            child: InkWell(
              onTap: () => {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
                  child: SingleChildScrollView(
                    child: Text(
                      applicationLegalese!,
                      style: PageStyle.ts_333333_14sp,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('查看详情'),
          onPressed: () {
            showLicensePage(context: context, id: annCertificate?.id);
          },
        ),
        TextButton(
          child: Text('已阅'),
          onPressed: () {
            //标记为已读
            hasreads(annCertificate);
            logic.readid = annCertificate?.id ?? 0;
            Navigator.pop(context);
          },
        ),
      ],
      scrollable: true,
    );
  }

  ///标记消息为已读
  void hasreads(annCertificate) async {
    try {
      annCertificate?.readid = annCertificate.id!;
      await DataPersistence.putAnninfo(annCertificate!);
    } catch (e) {
      print('login e: $e');
    }
  }

  showLicensePage({required BuildContext context, int? id}) async {
    var newsinfo = await Apis.getinformation(id.toString());
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) =>
          ShowNewsContentPage(id: id.toString(), data: newsinfo),
    ));
  }
}
