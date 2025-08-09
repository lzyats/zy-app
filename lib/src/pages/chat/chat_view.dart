import 'package:flutter/material.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_enterprise_chat/src/res/images.dart';
import 'package:openim_enterprise_chat/src/res/strings.dart';
import 'package:openim_enterprise_chat/src/res/styles.dart';
import 'package:openim_enterprise_chat/src/utils/im_util.dart';
import 'package:openim_enterprise_chat/src/widgets/chat_listview.dart';
import 'package:openim_enterprise_chat/src/widgets/titlebar.dart';
import 'package:openim_enterprise_chat/src/widgets/water_mark_view.dart';
import 'package:rxdart/rxdart.dart';

import '../../sdk_extension/message_manager.dart';
import '../../widgets/avatar_view.dart';
import 'chat_logic.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.find<ChatLogic>();

  Widget _itemView(int index, Message message) => ChatItemView(
        key: logic.itemKey(message),
        index: index,
        message: message,
        timeStr: logic.getShowTime(message),
        isSingleChat: logic.isSingleChat,
        clickSubject: logic.clickSubject,
        msgSendStatusSubject: logic.msgSendStatusSubject,
        msgSendProgressSubject: logic.msgSendProgressSubject,
        multiSelMode: logic.multiSelMode.value,
        multiList: logic.multiSelList.value,
        allAtMap: logic.atUserNameMappingMap,
        delaySendingStatus: true,
        textScaleFactor: logic.scaleFactor.value,
        needReadCount: logic.getNeedReadCount(message),
        isPrivateChat: logic.isPrivateChat(message),
        readingDuration: logic.readTime(message),
        onFailedResend: () {
          logic.failedResend(message);
        },
        onDestroyMessage: () {
          logic.deleteMsg(message);
        },
        onViewMessageReadStatus: () {
          logic.viewGroupMessageReadStatus(message);
        },
        onMultiSelChanged: (checked) {
          logic.multiSelMsg(message, checked);
        },
        onTapCopyMenu: () {
          logic.copy(message);
        },
        onTapDelMenu: () {
          logic.deleteMsg(message);
        },
        onTapForwardMenu: () {
          logic.forward(message);
        },
        onTapReplyMenu: () {
          logic.setQuoteMsg(message);
        },
        enabledRevokeMenu: logic.enabledRevokeMenu(index),
        onTapRevokeMenu: () {
          logic.revokeMsg(index);
        },
        onTapMultiMenu: () {
          logic.openMultiSelMode(message);
        },
        onTapAddEmojiMenu: () {
          logic.addEmoji(message);
        },
        visibilityChange: (context, index, message, visible) {
          logic.markMessageAsRead(message, visible);
        },
        onLongPressLeftAvatar: () {
          logic.onLongPressLeftAvatar(message);
        },
        onLongPressRightAvatar: () {},
        onTapLeftAvatar: () {
          logic.onTapLeftAvatar(message);
        },
        onTapRightAvatar: () {},
        onClickAtText: (uid) {
          logic.clickAtText(uid);
        },
        onTapQuoteMsg: () {
          logic.onTapQuoteMsg(message);
        },
        patterns: <MatchPattern>[
          MatchPattern(
            type: PatternType.AT,
            style: PageStyle.ts_1B72EC_14sp,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.EMAIL,
            style: PageStyle.ts_1B72EC_14sp,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.URL,
            style: PageStyle.ts_1B72EC_14sp_underline,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.MOBILE,
            style: PageStyle.ts_1B72EC_14sp,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.TEL,
            style: PageStyle.ts_1B72EC_14sp,
            onTap: logic.clickLinkText,
          ),
        ],
        customItemBuilder: _buildCustomItemView,
        customMessageBuilder: _buildCustomMessageView,
        enabledReadStatus: logic.enabledReadStatus(message),
        isBubbleMsg: !logic.isNotificationType(message),
      );

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: logic.multiSelMode.value ? () async => logic.exit() : null,
          child: ChatVoiceRecordLayout(
            locale: Get.locale,
            builder: (bar) => Obx(() => Scaffold(
                  backgroundColor: PageStyle.c_FFFFFF,
                  appBar: EnterpriseTitleBar.chatTitle(
                    showone: logic.showcall,
                    title: logic.name.value,
                    subTitle: logic.getSubTile(),
                    onClickCallBtn: () => logic.call(),
                    onClickMoreBtn: () => logic.chatSetup(),
                    leftButton: logic.multiSelMode.value ? StrRes.cancel : null,
                    onClose: () => logic.exit(),
                    showOnlineStatus: logic.showOnlineStatus(),
                    online: logic.onlineStatus.value,
                  ),
                  body: SafeArea(
                    child: WaterMarkBgView(
                      /// 聊天水印设置
                      text: '',
                      path: logic.background.value,
                      child: Column(
                        children: [
                          Expanded(
                            child: ChatListView(
                              listViewKey: ObjectKey(logic.listViewKey.value),
                              onTouch: () => logic.closeToolbox(),
                              itemCount: logic.messageList.length,
                              controller: logic.autoCtrl,
                              onLoad: () => logic.getHistoryMsgList(),
                              itemBuilder: (_, index) => Obx(
                                () => _itemView(
                                  index,
                                  logic.indexOfMessage(index),
                                ),
                              ),
                            ),
                          ),
                          ChatInputBoxView(
                            controller: logic.inputCtrl,
                            allAtMap: logic.atUserNameMappingMap,
                            toolbox: ChatToolsView(
                              onTapAlbum: () => logic.onTapAlbum(),
                              onTapCamera: () => logic.onTapCamera(),
                              onTapCarte: () => logic.onTapCarte(),
                              onTapFile: () => logic.onTapFile(),
                              onTapLocation: () => logic.onTapLocation(),
                              onTapVideoCall: () => logic.call(),
                              onEnvelope: () => logic.red(),
                              onStopVoiceInput: () => logic.onStopVoiceInput(),
                              onStartVoiceInput: () =>
                                  logic.onStartVoiceInput(),
                              cards: logic.opencards,
                              location: logic.openlocation,
                              voice: logic.openvidio,
                              envelopen: logic.showred,
                            ),
                            multiOpToolbox: ChatMultiSelToolbox(
                              onDelete: () => logic.mergeDelete(),
                              onMergeForward: () => logic.mergeForward(),
                            ),
                            emojiView: ChatEmojiView(
                              onAddEmoji: logic.onAddEmoji,
                              onDeleteEmoji: logic.onDeleteEmoji,
                              onAddFavorite: () => logic.emojiManage(),
                              favoriteList: logic.cacheLogic.urlList,
                              onSelectedFavorite: logic.sendCustomEmoji,
                            ),
                            onSubmitted: (v) => logic.sendTextMsg(),
                            forceCloseToolboxSub: logic.forceCloseToolbox,
                            voiceRecordBar: bar,
                            quoteContent: logic.quoteContent.value,
                            onClearQuote: () => logic.setQuoteMsg(null),
                            multiMode: logic.multiSelMode.value,
                            focusNode: logic.focusNode,
                            inputFormatters: [
                              AtTextInputFormatter(logic.openAtList)
                            ],
                            isGroupMuted: logic.isGroupMuted.value,
                            muteEndTime: logic.muteEndTime.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            onCompleted: (sec, path) {
              logic.sendVoice(duration: sec, path: path);
            },
          ),
        ));
  }

  /// 自定义消息
  Widget? _buildCustomMessageView(
    BuildContext context,
    bool isReceivedMsg,
    int index,
    Message message,
    Map<String, String> allAtMap,
    double textScaleFactor,
    List<MatchPattern> patterns,
    Subject<MsgStreamEv<int>> msgSendProgressSubject,
    Subject<int> clickSubject,
  ) {
    var data = logic.parseCustomMessage(message);
    if (null != data) {
      var viewType = data['viewType'];
      if (viewType == CustomMessageType.call) {
        return _buildCallItemView(type: data['type'], content: data['content']);
      } else if (viewType == CustomMessageType.tag_message) {
        final url = data['url'];
        final duration = data['duration'];
        final text = data['text'];
        if (text != null) {
          return ChatAtText(
            text: text,
            textScaleFactor: textScaleFactor,
            allAtMap: allAtMap,
            patterns: patterns,
          );
        } else if (url != null) {
          return ChatVoiceView(
            index: index,
            clickStream: clickSubject.stream,
            isReceived: isReceivedMsg,
            soundPath: null,
            soundUrl: url,
            duration: duration,
          );
        }
      }
    }
    return null;
  }

  /// custom item view
  Widget? _buildCustomItemView(
    BuildContext context,
    int index,
    Message message,
  ) {
    final text = IMUtil.parseNotification(message);
    if (null != text) {
      return _buildNotificationTipsView(text);
    }
    return null;
  }

  Widget _buildNotificationTipsView(String text) => Container(
        alignment: Alignment.center,
        child: ChatAtText(
          text: text,
          textStyle: PageStyle.ts_999999_12sp,
          textAlign: TextAlign.center,
        ),
      );

  /// 通话item
  Widget _buildCallItemView({
    required String type,
    required String content,
  }) =>
      Row(
        children: [
          Image.asset(
            type == 'audio'
                ? ImageRes.ic_voiceCallMsg
                : ImageRes.ic_videoCallMsg,
            width: 20.h,
            height: 20.h,
          ),
          SizedBox(width: 6.w),
          Text(
            content,
            style: PageStyle.ts_333333_14sp,
          ),
        ],
      );

  /// 群公告item
  Widget _buildAnnouncementItemView(String content) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(ImageRes.ic_trumpet, width: 16.h, height: 16.h),
                SizedBox(width: 4.w),
                Text(
                  StrRes.groupAnnouncement,
                  style: PageStyle.ts_898989_13sp,
                )
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              content,
              style: PageStyle.ts_333333_13sp,
            ),
          ],
        ),
      );
}
