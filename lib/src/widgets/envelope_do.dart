import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';
import 'package:openim_enterprise_chat/src/common/apis.dart';
import 'package:openim_enterprise_chat/src/core/controller/im_controller.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:openim_enterprise_chat/src/widgets/avatar_view.dart';

class RedPacket extends StatefulWidget {
  const RedPacket({
    Key? key,
    required this.rlid,
    required this.rrid,
    required this.uname,
    required this.uface,
    required this.extension,
  }) : super(key: key);
  final String rlid;
  final String rrid;
  final String uname;
  final String uface;
  final String extension;

  @override
  State<RedPacket> createState() => _RedPacketState();
}

class _RedPacketState extends State<RedPacket> with TickerProviderStateMixin {
  late RedPacketController controller =
      RedPacketController(tickerProvider: this);
  final imLogic = Get.find<IMController>();

  final ring = 'assets/audio/red.mp3';
  final audioPlayer = AudioPlayer(
    handleInterruptions: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => clickGold(widget.rlid, widget.rrid),
      child: CustomPaint(
        size: Size(1.sw, 1.sh),
        painter: RedPacketPainter(),
        child: buildChild(),
      ),
    );
  }

  /// 播放提示音
  void _playSound() async {
    if (!audioPlayer.playerState.playing) {
      audioPlayer.setAsset(ring);
      audioPlayer.setLoopMode(LoopMode.off);
      audioPlayer.setVolume(1.0);
      audioPlayer.play();
    }
  }

  /// 提交红包信息
  void clickGold(String rlid, String rrid) async {
    _playSound();
    await LoadingView.singleton.wrap(asyncFunction: () async {
      var info = await Apis.doenvelope(rlid, rrid);
      //判断要不要更新用户信息

      var update = info['update'];

      if (update) {
        ExInfoCertificate exinfo = ExInfoCertificate.fromJson(info['ex']);
        var ex = jsonEncode(exinfo);
        //更新当前用户信息
        await OpenIM.iMManager.userManager
            .setSelfInfo(ex: ex)
            .then((value) => imLogic.userInfo.update((val) {
                  val?.ex = ex;
                  val?.exinfo = exinfo;
                }));
      }
    });
    try {} catch (e) {
      //print('login e: $e');
      return;
    }
    Navigator.pop(context, {'lid': widget.rlid});
  }

  Container buildChild() {
    return Container(
      padding: EdgeInsets.only(top: 0.3.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: AvatarView(
                    size: 32.h,
                    url: widget.uface,
                    enabledPreview: true,
                  )),
              SizedBox(
                width: 5.w,
              ),
              Text(
                widget.uname + "发出的红包",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFFF8E7CB),
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 15.w,
          ),
          Text(
            widget.extension,
            style: TextStyle(fontSize: 18.sp, color: Color(0xFFF8E7CB)),
          )
        ],
      ),
    );
  }
}

class RedPacketPainter extends CustomPainter {
  RedPacketPainter() : super();

  /// 画笔
  late final Paint _paint = Paint()..isAntiAlias = true;

  /// 路径
  final Path path = Path();

  /// 红包的高度：1.2倍的屏幕宽度
  late double height = 1.2.sw;

  /// 上半部分贝塞尔曲线的结束点
  late double topBezierEnd = (1.sh - height) / 2 + height / 8 * 7;

  /// 上半部分贝塞尔曲线的起点
  late double topBezierStart = topBezierEnd - 0.2.sw;

  /// 下半部分贝塞尔曲线的起点
  late double bottomBezierStart = topBezierEnd - 0.4.sw;

  /// 金币中心点，后续通过path计算
  Offset goldCenter = Offset.zero;

  /// 横向的中心点
  final double centerWidth = 0.5.sw;

  /// 红包在整个界面的left
  late double left = 0.1.sw;

  /// 红包在整个界面的right
  late double right = 0.9.sw;

  /// 红包在整个界面的top
  late double top = (1.sh - height) / 2;

  /// 红包在整个界面的bottom
  late double bottom = (1.sh - height) / 2 + height;

  @override
  void paint(Canvas canvas, Size size) {
    drawTop(canvas);
    drawBottom(canvas);
    drawGold(canvas);
    drawOpenText(canvas);
  }

  void drawTop(Canvas canvas) {
    path.reset();
    _paint.color = Color.fromARGB(255, 244, 96, 96);
    path.addRRect(RRect.fromLTRBAndCorners(left, top, right, topBezierStart,
        topLeft: const Radius.circular(5), topRight: const Radius.circular(5)));
    var bezierPath = getTopBezierPath();
    path.addPath(bezierPath, Offset.zero);

    path.close();

    canvas.drawShadow(path, Colors.redAccent, 2, true);
    canvas.drawPath(path, _paint);
  }

  Path getTopBezierPath() {
    Path bezierPath = Path();
    bezierPath.moveTo(left, topBezierStart);
    bezierPath.quadraticBezierTo(
        centerWidth, topBezierEnd, right, topBezierStart);
    var pms = bezierPath.computeMetrics();
    var pm = pms.first;
    goldCenter = pm.getTangentForOffset(pm.length / 2)?.position ?? Offset.zero;
    return bezierPath;
  }

  void drawBottom(Canvas canvas) {
    path.reset();
    path.moveTo(left, bottomBezierStart);
    path.quadraticBezierTo(centerWidth, topBezierEnd, right, bottomBezierStart);

    path.lineTo(right, topBezierEnd);
    path.lineTo(left, topBezierEnd);

    path.addRRect(RRect.fromLTRBAndCorners(left, topBezierEnd, right, bottom,
        bottomLeft: const Radius.circular(5),
        bottomRight: const Radius.circular(5)));
    _paint.color = Colors.redAccent;
    path.close();

    canvas.drawShadow(path, Colors.redAccent, 2, true);

    canvas.drawPath(path, _paint);
  }

  void drawGold(Canvas canvas) {
    Path path = Path();

    canvas.save();
    canvas.translate(0.5.sw, goldCenter.dy);

    _paint.style = PaintingStyle.fill;
    path.addOval(Rect.fromLTRB(-40.w, -40.w, 40.w, 40.w));

    _paint.color = const Color(0xFFE5CDA8);
    canvas.drawPath(path, _paint);

    _paint.color = const Color(0xFFFCE5BF);
    canvas.drawPath(path, _paint);

    canvas.restore();
  }

  void drawOpenText(Canvas canvas) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: "開",
            style: TextStyle(
                fontSize: 34.sp,
                color: Colors.black87,
                height: 1.0,
                fontWeight: FontWeight.w400)),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        textWidthBasis: TextWidthBasis.longestLine,
        textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false, applyHeightToLastDescent: false))
      ..layout();

    canvas.save();
    canvas.translate(0.5.sw, goldCenter.dy);
    textPainter.paint(
        canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();
  }

  void drawGoldCenterRect(Path path, Path path3, Canvas canvas) {
    var pms1 = path.computeMetrics();
    var pms2 = path3.computeMetrics();

    var pathMetric1 = pms1.first;
    var pathMetric2 = pms2.first;
    var length = pathMetric1.length;
    Path centerPath = Path();
    for (int i = 0; i < length; i++) {
      var position1 = pathMetric1.getTangentForOffset(i.toDouble())?.position;
      var position2 = pathMetric2.getTangentForOffset(i.toDouble())?.position;
      if (position1 == null || position2 == null) {
        continue;
      }
      centerPath.moveTo(position1.dx, position1.dy);
      centerPath.lineTo(position2.dx, position2.dy);
    }

    Paint centerPaint = Paint()
      ..color = const Color(0xFFE5CDA8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(centerPath, centerPaint);
  }

  @override
  bool shouldRepaint(RedPacketPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RedPacketPainter oldDelegate) => true;
}

class RedPacketController {
  Path? goldPath;
  bool showOpenText = true;
  final TickerProviderStateMixin tickerProvider;
  late AnimationController angleController;
  late Animation<double> angleCtrl;

  RedPacketController({required this.tickerProvider}) {
    initAnimation();
  }

  bool checkClickGold(Offset point) {
    return goldPath?.contains(point) == true;
  }

  static void showToast(String msg) {
    if (msg.trim().isNotEmpty) EasyLoading.showToast(msg);
  }

  clickGold(TapUpDetails details, String rlid, String rrid) async {
    try {
      await LoadingView.singleton.wrap(asyncFunction: () async {
        var info = await Apis.doenvelope(rlid, rrid);
      });
    } catch (e) {
      //print('login e: $e');
      return;
    }
  }

  void initAnimation() {
    angleController = AnimationController(
        duration: const Duration(seconds: 3), vsync: tickerProvider)
      ..repeat(reverse: true);
    angleCtrl = angleController.drive(Tween(begin: 1.0, end: 0.0));
  }

  void dispose() {
    angleController.dispose();

    //timer?.cancel();
  }

  /// ...
}
