import 'package:get/get.dart';

import 'invitecode_logic.dart';

class InvitecodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvitecodeLogic());
  }
}
