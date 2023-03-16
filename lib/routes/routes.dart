import 'package:get/get.dart';
import 'package:tricycle/views/auth/signIn.dart';
import 'package:tricycle/views/auth/signUp.dart';
import 'package:tricycle/views/wrapper.dart';
import '../views/splashScreen.dart';

class Routes {
  static String splash = '/';
  static String signIn = '/signIn';
  static String signUp = '/signUp';
  static String wrapper = '/wrapper';
}

bool isLogin = true;

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const Splash(),
  ),
  // GetPage(
  //   name: Routes.signIn,
  //   page: () => SignIn(onClickedSignUp: () => true),
  // ),
  GetPage(
    name: Routes.wrapper,
    page: () => const Wrapper(),
  ),
  // GetPage(
  //   name: Routes.signUp,
  //   page: () => SignUp(onClickedSignIn: () => true),
  //   transition: Transition.leftToRight,
  // ),
];
