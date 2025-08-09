import 'package:get/get.dart';

import 'usdt_do_logic.dart';

class SetUsdtdoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetUsdtdoLogic());
  }
}
