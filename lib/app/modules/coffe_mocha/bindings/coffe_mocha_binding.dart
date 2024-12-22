import 'package:get/get.dart';

import '../controllers/coffe_mocha_controller.dart';

class CoffeMochaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoffeMochaController>(
      () => CoffeMochaController(),
    );
  }
}
