import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/pages/contacts/contacts_view.dart';
import 'package:openim_enterprise_chat/src/pages/conversation/conversation_view.dart';
import 'package:openim_enterprise_chat/src/pages/mine/mine_view.dart';
import 'package:openim_enterprise_chat/src/pages/workbench/active/active_view.dart';
import 'package:openim_enterprise_chat/src/pages/workbench/workbench_view.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/widgets/bottombar.dart';
import 'package:openim_enterprise_chat/src/widgets/show_news.dart';
import 'package:openim_enterprise_chat/src/widgets/im_widget.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();
  void showNewsDialogs({
    required BuildContext context,
    String? applicationName,
    String? applicationVersion,
    String? applicationLegalese,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    showDialog<void>(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return ShowNewsDialog(
          applicationName: applicationName!,
          applicationVersion: applicationVersion!,
          applicationLegalese: applicationLegalese,
        );
      },
      routeSettings: routeSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageStyle.c_FFFFFF,
      body: Obx(() => Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: logic.index.value,
                  children: [
                    ConversationPage(),
                    ContactsPage(),
                    if (logic.showact == true)
                      ActivePage(
                        url: logic.activeurl,
                        title: logic.activename,
                      ),
                    if (logic.showcheckin == true) WorkbenchPage(),
                    MinePage(),
                  ],
                ),
              ),
              BottomBar(
                index: logic.index.value,
                items: [
                  BottomBarItem(
                    selectedImgRes: ImageRes.ic_tabHomeSel,
                    unselectedImgRes: ImageRes.ic_tabHomeNor,
                    label: StrRes.home,
                    imgWidth: 24.w,
                    imgHeight: 25.h,
                    onClick: (i) => {
                      //if ((logic.readid != logic.id) && logic.shownews == '1')
                      //  IMWidget.showToast1(logic.text.toString()),
                      if ((logic.readid != logic.id) && logic.shownews == '1')
                        showNewsDialogs(
                          context: context,
                          applicationName: logic.title,
                          applicationVersion:
                              DateTime.now().toString().substring(0, 19),
                          applicationLegalese: logic.text,
                        ),
                      logic.switchTab(i)
                    },
                    // steam: logic.imLogic.unreadMsgCountCtrl.stream,
                    count: logic.unreadMsgCount.value,
                  ),
                  BottomBarItem(
                    selectedImgRes: ImageRes.ic_tabContactsSel,
                    unselectedImgRes: ImageRes.ic_tabContactsNor,
                    label: StrRes.contacts,
                    imgWidth: 22.w,
                    imgHeight: 23.h,
                    onClick: (i) => logic.switchTab(i),
                    count: logic.unhandledCount.value,
                  ),
                  if (logic.showact == true)
                    BottomBarItem(
                      selectedImgRes: ImageRes.ic_tabWorkSel1,
                      unselectedImgRes: ImageRes.ic_tabWorkNor1,
                      label: 'Atcive',
                      imgWidth: 22.w,
                      imgHeight: 23.h,
                      onClick: (i) => {logic.switchTab(i)},
                      // count: logic.unhandledCount.value,
                    ),
                  if (logic.showcheckin == true)
                    BottomBarItem(
                      selectedImgRes: ImageRes.ic_tabWorkSel,
                      unselectedImgRes: ImageRes.ic_tabWorkNor,
                      label: StrRes.workbench,
                      imgWidth: 22.w,
                      imgHeight: 23.h,
                      onClick: (i) => {logic.switchTab(i)},
                      // count: logic.unhandledCount.value,
                    ),
                  BottomBarItem(
                    selectedImgRes: ImageRes.ic_tabMineSel,
                    unselectedImgRes: ImageRes.ic_tabMineNor,
                    label: StrRes.mine,
                    imgWidth: 22.w,
                    imgHeight: 23.h,
                    onClick: (i) => logic.switchTab(i),
                    // count: logic.unhandledCount.value,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
