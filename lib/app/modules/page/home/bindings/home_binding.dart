import 'package:get/get.dart';
import 'package:tes/app/modules/page/home/controllers/home_controller.dart'; // Import your new page

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => HomeController()); // Lazy initialization of HomeController
  }
}
