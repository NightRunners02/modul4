import 'package:get/get.dart';
import 'package:tes/app/modules/page/register/controllers/register_controller.dart'; // Import your new page

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
