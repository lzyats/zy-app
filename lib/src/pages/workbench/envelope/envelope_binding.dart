import 'package:get/get.dart';

import 'envelope_logic.dart';

class EnvelopeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnvelopeLogic());
  }
}
