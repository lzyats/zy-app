import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/utils/http_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sp_util/sp_util.dart';

class Config {
  //初始化全局信息
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    cachePath = (await getApplicationDocumentsDirectory()).path;
    await SpUtil.getInstance();
    await Hive.initFlutter(cachePath);
    // await SpeechToTextUtil.instance.initSpeech();
    HttpUtil.init();
    runApp();
    // 设置屏幕方向
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // 状态栏透明（Android）
    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

    //FlutterBugly.init(androidAppId: "4103e474e9", iOSAppId: "28849b1ca6");
  }

  static late String cachePath;

  static const UI_W = 375.0;
  static const UI_H = 812.0;

  /// 秘钥
  static const secret = 'tuoyun';

  /// ip
  //static const defaultIp = "125.88.215.135"; //43.128.5.63"; //121.37.25.71
  static const defaultIp = "mimapi.91im.vip"; //43.128.5.63"; //8.218.66.88
  //static const defaultIp = "8.218.66.88"; //43.128.5.63"; //8.218.66.88
  static const defaultIp1 = "mimapi.91im.vip";

  /// 服务器IP
  static String serverIp() {
    var ip;
    var server = DataPersistence.getServerConfig();
    if (null != server) {
      ip = server['serverIP'];
      print('缓存serverIP: $ip');
    }
    return ip ?? defaultIp;
  }

  /// IM sdk api地址
  static String imApiUrl() {
    var url;
    var server = DataPersistence.getServerConfig();
    if (null != server) {
      url = server['apiUrl'];
      print('缓存apiUrl: $url');
    }
    return url ?? 'http://$defaultIp:10000';
  }

  /// IM ws 地址
  static String imWsUrl() {
    var url;
    var server = DataPersistence.getServerConfig();
    if (null != server) {
      url = server['wsUrl'];
      print('缓存wsUrl: $url');
    }
    return url ?? 'ws://$defaultIp:17778';
  }

  /// work业务 地址
  static String workUrl() {
    var url;
    var server = DataPersistence.getServerConfig();
    if (null != server) {
      url = server['workUrl'];
      print('缓存workUrl: $url');
    }
    return url ?? 'http://$defaultIp';
  }

  /// work业务 地址
  static String imgUrl() {
    return 'http://$defaultIp1:8899';
  }

  /// 音视频通话地址
  static String callUrl() {
    var url;
    var server = DataPersistence.getServerConfig();
    if (null != server) {
      url = server['callUrl'];
      print('缓存callUrl: $url');
    }
    return url ?? 'http://$defaultIp:7880';
  }
}
