import 'package:get/get.dart';
import 'package:tricycle/views/auth/signIn.dart';
import 'package:tricycle/views/auth/signUp.dart';
import 'package:tricycle/views/home/bookingStatus.dart';
import 'package:tricycle/views/home/decideRoute.dart';
import 'package:tricycle/views/home/driver/driverHome.dart';
import 'package:tricycle/views/home/history.dart';
import 'package:tricycle/views/home/home.dart';
import 'package:tricycle/views/home/kekeDetails.dart';
import 'package:tricycle/views/home/userProfile.dart';
import 'package:tricycle/views/home/wallet.dart';
import 'package:tricycle/views/wrapper.dart';
import '../views/splashScreen.dart';

class Routes {
  static String splash = '/';
  static String signIn = '/signIn';
  static String signUp = '/signUp';
  static String wrapper = '/wrapper';
  static String kekeDetails = '/kekeDetails';
  static String decideRoute = '/decideRoute';
  static String bookingStatus = '/bookingStatus';
  static String history = '/history';
  static String userProfile = '/userProfile';
  static String home = '/home';
  static String wallet = '/wallet';
  static String driverHomePage = '/driverHomePage';
}

bool isLogin = true;

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const Splash(),
  ),
  GetPage(
    name: Routes.kekeDetails,
    page: () => KekeDetailsPage(),
  ),
  GetPage(
    name: Routes.wrapper,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: Routes.decideRoute,
    page: () => DecideRoutePage(),
  ),
  GetPage(
    name: Routes.bookingStatus,
    page: () => BookingStatusPage(),
  ),
  GetPage(
    name: Routes.history,
    page: () => HistoryPage(),
  ),
  GetPage(
    name: Routes.userProfile,
    page: () => UserProfilePage(),
  ),
  GetPage(
    name: Routes.home,
    page: () => HomePage(),
  ),
  GetPage(
    name: Routes.wallet,
    page: () => WalletPage(),
  ),
  GetPage(
    name: Routes.driverHomePage,
    page: () => DriverHomePage(),
  ),
  // GetPage(
  //   name: Routes.signUp,
  //   page: () => SignUp(onClickedSignIn: () => true),
  //   transition: Transition.leftToRight,
  // ),
  // GetPage(
  //   name: Routes.signIn,
  //   page: () => SignIn(onClickedSignUp: () => true),
  // ),
];
