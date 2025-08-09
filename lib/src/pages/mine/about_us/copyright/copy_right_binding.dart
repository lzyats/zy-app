import 'package:get/get.dart';

import 'copy_right_logic.dart';

class CopyRightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CopyRightLogic());
  }
}
