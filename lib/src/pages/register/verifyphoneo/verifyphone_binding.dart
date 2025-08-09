import 'package:get/get.dart';

import 'verifyphone_logic.dart';

class VerifyPhoneoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyPhoneoLogic());
  }
}
