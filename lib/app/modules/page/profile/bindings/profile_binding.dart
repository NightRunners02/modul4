import 'package:get/get.dart';
import 'package:tes/app/modules/page/profile/controllers/profile_controller.dart'; // Import your new page

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
