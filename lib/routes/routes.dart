import 'package:get/get.dart';

import '../views/splashScreen.dart';

class Routes {
  static String splash = '/';
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const Splash(),
  ),
];
