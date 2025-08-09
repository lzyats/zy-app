import 'package:get/get.dart';

import 'my_addr_logic.dart';

class MyAddrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAddrLogic());
  }
}
