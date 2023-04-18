import 'package:get/get.dart';
import 'package:tricycle/views/home/driver/BookingList.dart';
import 'package:tricycle/views/home/driver/bookingStatus.dart';
import 'package:tricycle/views/home/driver/driverHome.dart';
import 'package:tricycle/views/home/driver/wallet.dart';
import 'package:tricycle/views/home/users/bookingStatus.dart';
import 'package:tricycle/views/home/users/decideRoute.dart';
import 'package:tricycle/views/home/users/history.dart';
import 'package:tricycle/views/home/users/home.dart';
import 'package:tricycle/views/home/users/kekeDetails.dart';
import 'package:tricycle/views/home/users/userProfile.dart';
import 'package:tricycle/views/home/users/wallet.dart';
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
  // Driver Pages
  static String driverHomePage = '/driverHomePage';
  static String bookingList = '/bookingList';
  static String driverBookingStatus = '/driverBookingStatus';
  static String driverWallet = '/driverWallet';
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
    page: () => Wrapper(),
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
  GetPage(
    name: Routes.bookingList,
    page: () => Bookings(),
  ),
  GetPage(
    name: Routes.driverBookingStatus,
    page: () => DriverBookingStatusPage(),
  ),
  GetPage(
    name: Routes.driverWallet,
    page: () => DriverWallet(),
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
