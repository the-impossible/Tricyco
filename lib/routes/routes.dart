import 'package:get/get.dart';
import '../views/signIn.dart';
import '../views/signUp.dart';
import '../views/splashScreen.dart';

class Routes {
  static String splash = '/';
  static String signIn = '/signIn';
  static String signUp = '/signUp';
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const Splash(),
  ),
  GetPage(
    name: Routes.signIn,
    page: () => const SignIn(),
  ),
  GetPage(
    name: Routes.signUp,
    page: () => const SignUp(),
  ),
];
