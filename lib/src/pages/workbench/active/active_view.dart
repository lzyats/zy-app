import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ActivePage extends StatefulWidget {
  final String? url;
  final String? title;

  const ActivePage({Key? key, this.url, this.title}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<ActivePage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        domStorageEnabled: true,
        geolocationEnabled: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Column(
      children: <Widget>[
        SizedBox(
          height: 35.h,
        ),
        //this._flag ? _getMoreWidget() : Text(widget.title!),
        Expanded(
          // 官方代码
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest:
                    //URLRequest(url: Uri.parse('http://8.134.87.69:88/t.html')),
                    URLRequest(url: Uri.parse(widget.url!)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                  webViewController!.addJavaScriptHandler(
                      handlerName: 'handlerUpfile',
                      callback: (args) async {
                        var binfo = onTapAlbum();
                        print('---------aa' + binfo.toString());
                        return binfo;
                      });
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunch(url)) {
                      // Launch the App
                      await launch(
                        url,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = this.url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
              progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container(),
            ],
          ),
        )
      ],
    )));
  }

  /// 打开相册
  static Future<String> onTapAlbum() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      //type: FileType.image,
      //allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      //sendFile(filePath: result.files[0].path!, fileName: result.files[0].name);
      var info = await Apis.minioupfile(
          path: result.files[0].path!, name: result.files[0].name);
      print('---------bb' + info);
      return info;
    } else {
      return '';
    }
  }

  /// 发送文件
  void sendFile({required String filePath, required String fileName}) async {
    var apiUrl = "http://47.242.63.216:9527/v1/user/setAvatar";
    print('-------img-' + filePath + '---' + fileName);
    //参数
    Map<String, dynamic> map = Map();
    dio.FormData formData = dio.FormData.fromMap(map);
    //print('-------img-' + jsonEncode(message));
    //return message.toString();
  }
}
