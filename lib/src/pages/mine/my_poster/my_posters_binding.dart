import 'package:get/get.dart';

import 'my_posters_logic.dart';

class MypostersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MypostersLogic());
  }
}
