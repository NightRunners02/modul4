import 'app/modules/connection/bindings/connection_binding.dart';

class DependencyInjection {
  static void init() {
ConnectionBinding().dependencies();
}
}