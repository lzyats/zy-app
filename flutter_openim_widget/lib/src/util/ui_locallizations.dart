import 'package:flutter/material.dart';

class UILocalizations {
  UILocalizations._();

  static void set(Locale? locale) {
    _locale = locale ?? const Locale('zh');
  }

  static String _value({required String key}) =>
      _localizedValues[_locale.languageCode]![key] ?? key;

  static Locale _locale = const Locale('zh');

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'top': 'Stick to Top',
      'envelope': 'A red envelope',
      'cancelTop': 'Remove from Top',
      'remove': 'Delete',
      'markRead': 'Mark as Read',
      "album": "Album",
      "camera": "Camera",
      "videoCall": "Video Call",
      "picture": "Picture",
      "video": "Video",
      "voice": "Voice",
      "location": "Location",
      "file": "File",
      "carte": "Contact Card",
      "voiceInput": "Voice Input",
      'haveRead': 'Have read',
      'groupHaveRead': '%s people have read',
      'unread': 'Unread',
      'groupUnread': '%s unread',
      'allRead': 'All read',
      'copy': 'Copy',
      "delete": "Delete",
      "forward": "Forward",
      "reply": "Quote",
      "revoke": "Revoke",
      "multiChoice": "Choice",
      "translation": "Translate",
      "download": "Download",
      "pressSpeak": "Hold to Talk",
      "releaseSend": "Release to send",
      "releaseCancel": "Release to cancel",
      "soundToWord": "Convert",
      "converting": "Converting...",
      "cancelVoiceSend": "Cancel",
      "confirmVoiceSend": "Send Voice",
      "convertFailTips": "Unable to recognize words",
      "confirm": "Confirm",
      "you": "You",
      "revokeAMsg": "revoke a message",
      "picLoadError": "Image failed to load",
      "fileSize": "File size: %s",
      "fileUnavailable": "The file has expired or has been cleaned up",
      "send": 'Send',
      "unsupportedMessage": '[Message types not supported]',
      "add": 'Add',
      "youMuted": 'You have been muted',
      "groupMuted": 'Enable group mute',
      "envelope1": "Identical Amount",
      "envelope2": "Exclusive Amount",
      "envelope3": "Random Amount",
      "envelope4": "Money in red envelopes",
      "envelope5": "Bonus amount",
      "envelope6": "The number of red packets",
      "envelope7": "I wish you are lucky",
      "envelope8": "Please enter the amount of red envelopes!",
      "envelope9": "Please enter the correct number of red envelopes!",
      "envelope10":
          "The number is greater than the group of the total number of red envelopes!",
      "envelope11": "Send To",
      "envelope12": "Please select a recipient!",
      "envelope13": "Account balance is insufficient!",
      "envelope14": "Recipient",
      "envelope15": "Please select a recipient",
    },
    'zh': {
      'top': '置顶',
      'envelope': '红包',
      'cancelTop': '取消置顶',
      'remove': '移除',
      'markRead': '标记为已读',
      "album": "相册",
      "camera": "拍摄",
      "videoCall": "视频通话",
      "picture": "图片",
      "video": "视频",
      "voice": "语音",
      "location": "位置",
      "file": "文件",
      "carte": "名片",
      "voiceInput": "语音输入",
      'haveRead': '已读',
      'groupHaveRead': '%s人已读',
      'unread': '未读',
      'groupUnread': '%s人未读',
      'allRead': '全部已读',
      'copy': '复制',
      "delete": "删除",
      "forward": "转发",
      "reply": "回复",
      "revoke": "撤回",
      "multiChoice": "多选",
      "translation": "翻译",
      "download": "下载",
      "pressSpeak": "按住说话",
      "releaseSend": "松开发送",
      "releaseCancel": "松开取消",
      "soundToWord": "转文字",
      "converting": "转换中...",
      "cancelVoiceSend": "取消",
      "confirm": "确认",
      "confirmVoiceSend": "发送原语音",
      "convertFailTipsconfirm": "未识别到文字",
      "": "确定",
      "you": "你",
      "revokeAMsg": "撤回了一条消息",
      "picLoadError": "图片加载失败",
      "fileSize": "文件大小：%s",
      "fileUnavailable": "文件已过期或已被清理",
      "send": '发送',
      "unsupportedMessage": '[暂不支持的消息类型]',
      "add": '添加',
      "youMuted": '你已被禁言',
      "groupMuted": '已开启群禁言',
      "envelope1": "普通红包",
      "envelope2": "专属红包",
      "envelope3": "拼手气红包",
      "envelope4": "塞钱进红包",
      "envelope5": "红包金额",
      "envelope6": "红包个数",
      "envelope7": "恭喜发财，大吉大利",
      "envelope8": "请输入红包金额!",
      "envelope9": "请输入正确的红包个数!",
      "envelope10": "红包个数大于群总人数!",
      "envelope11": "发给谁",
      "envelope12": "请选择接收人!",
      "envelope13": "账户余额不足!",
      "envelope14": "发给谁",
      "envelope15": "请选择接收人",
    },
  };

  static String get top => _value(key: 'top');

  static String get cancelTop => _value(key: 'cancelTop');

  static String get remove => _value(key: 'remove');

  static String get markRead => _value(key: 'markRead');

  static String get album => _value(key: 'album');

  static String get camera => _value(key: 'camera');

  static String get videoCall => _value(key: 'videoCall');

  static String get picture => _value(key: 'picture');

  static String get video => _value(key: 'video');

  static String get voice => _value(key: 'voice');

  static String get location => _value(key: 'location');

  static String get file => _value(key: 'file');

  static String get carte => _value(key: 'carte');

  static String get voiceInput => _value(key: 'voiceInput');

  static String get haveRead => _value(key: 'haveRead');

  static String get unread => _value(key: 'unread');

  static String get groupHaveRead => _value(key: 'groupHaveRead');

  static String get groupUnread => _value(key: 'groupUnread');

  static String get allRead => _value(key: 'allRead');

  static String get copy => _value(key: 'copy');

  static String get delete => _value(key: 'delete');

  static String get forward => _value(key: 'forward');

  static String get reply => _value(key: 'reply');

  static String get revoke => _value(key: 'revoke');

  static String get multiChoice => _value(key: 'multiChoice');

  static String get translation => _value(key: 'translation');

  static String get download => _value(key: 'download');

  static String get pressSpeak => _value(key: 'pressSpeak');

  static String get releaseSend => _value(key: 'releaseSend');

  static String get releaseCancel => _value(key: 'releaseCancel');

  static String get soundToWord => _value(key: 'soundToWord');

  static String get converting => _value(key: 'converting');

  static String get cancelVoiceSend => _value(key: 'cancelVoiceSend');

  static String get confirmVoiceSend => _value(key: 'confirmVoiceSend');

  static String get convertFailTips => _value(key: 'convertFailTips');

  static String get confirm => _value(key: 'confirm');

  static String get you => _value(key: 'you');

  static String get revokeAMsg => _value(key: 'revokeAMsg');

  static String get picLoadError => _value(key: 'picLoadError');

  static String get fileSize => _value(key: 'fileSize');

  static String get fileUnavailable => _value(key: 'fileUnavailable');

  static String get acceptFriendHint => _value(key: 'acceptFriendHint');

  static String get addFriendHint => _value(key: 'addFriendHint');

  static String get send => _value(key: 'send');

  static String get unsupportedMessage => _value(key: 'unsupportedMessage');

  static String get youMuted => _value(key: 'youMuted');

  static String get groupMuted => _value(key: 'groupMuted');

  static String get add => _value(key: 'add');

  static String get envelope => _value(key: 'envelope');

  static String get envelope1 => _value(key: 'envelope1');

  static String get envelope2 => _value(key: 'envelope2');

  static String get envelope3 => _value(key: 'envelope3');

  static String get envelope4 => _value(key: 'envelope4');

  static String get envelope5 => _value(key: 'envelope5');

  static String get envelope6 => _value(key: 'envelope6');

  static String get envelope7 => _value(key: 'envelope7');

  static String get envelope8 => _value(key: 'envelope8');

  static String get envelope9 => _value(key: 'envelope9');

  static String get envelope10 => _value(key: 'envelope10');

  static String get envelope11 => _value(key: 'envelope11');

  static String get envelope12 => _value(key: 'envelope12');

  static String get envelope13 => _value(key: 'envelope13');

  static String get envelope14 => _value(key: 'envelope14');

  static String get envelope15 => _value(key: 'envelope15');
}
