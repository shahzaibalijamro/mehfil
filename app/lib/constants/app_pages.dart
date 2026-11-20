import 'package:get/get.dart';
import 'app_endpoints.dart';
import '../views/auth/host_login_view.dart';
import '../views/auth/host_signup_view.dart';
import '../views/auth/host_otp_view.dart';
import '../views/auth/guest_signin_view.dart';

class AppPages {
  AppPages._();

  static const String initial = AppEndpoints.hostLogin;

  static final List<GetPage> routes = [
    GetPage(
      name: AppEndpoints.hostLogin,
      page: () => const HostLoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppEndpoints.hostSignup,
      page: () => const HostSignupView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.hostOtp,
      page: () => const HostOtpView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.guestSignin,
      page: () => const GuestSigninView(),
      transition: Transition.fadeIn,
    ),
  ];
}
