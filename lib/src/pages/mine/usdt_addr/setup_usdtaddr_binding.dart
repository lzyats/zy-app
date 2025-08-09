import 'package:get/get.dart';

import 'setup_usdtaddr_logic.dart';

class SetupUsdtAddrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetupUsdtAddrLogic());
  }
}
