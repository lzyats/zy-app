import 'package:get/get.dart';

import 'my_posttg_logic.dart';

class MyposttgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyposttgLogic());
  }
}
