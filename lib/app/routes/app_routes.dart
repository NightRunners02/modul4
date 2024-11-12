part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LANDING = _Paths.LANDING;
  static const REGISTER = _Paths.REGISTER;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE; // Tambahkan rute untuk profile

}

abstract class _Paths {
  _Paths._();
  static const LANDING = '/';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const PROFILE = '/profile'; // Path untuk profile

}
