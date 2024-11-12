import 'package:get/get.dart';



import 'package:tes/app/modules/page/get_started/bindings/landing_binding.dart'; // Import your new page
import 'package:tes/app/modules/page/get_started/views/landing_view.dart'; // Import your new page
import 'package:tes/app/modules/page/register/bindings/register_binding.dart'; // Import your new page
import 'package:tes/app/modules/page/register/views/register_view.dart'; // Import your new page
import 'package:tes/app/modules/page/login/bindings/login_binding.dart'; // Import your new page
import 'package:tes/app/modules/page/home/bindings/home_binding.dart'; // Import your new page
import 'package:tes/app/modules/page/home/views/home_view.dart'; // Import your new page
import 'package:tes/app/modules/page/profile/bindings/profile_binding.dart'; // Import your new page
import 'package:tes/app/modules/page/profile/views/profile_view.dart'; // Import your new page
import 'package:tes/app/modules/page/login/views/login_view.dart'; // Import your new page








part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.LANDING,
      page: () => LandingPage(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
