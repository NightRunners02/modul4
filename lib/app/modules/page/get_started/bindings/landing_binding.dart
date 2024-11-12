import 'package:get/get.dart';
import 'package:tes/app/modules/page/get_started/controllers/landing_controller.dart'; // Import your new page

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(() => LandingController());
  }
}
