import 'package:get/get.dart';
import 'package:tes/app/modules/page/login/controllers/login_controller.dart'; // Import your new page

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
