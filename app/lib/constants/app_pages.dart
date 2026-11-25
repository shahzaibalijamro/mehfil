import 'package:app/views/main_screen.dart';
import 'package:get/get.dart';

import 'app_endpoints.dart';
import '../views/auth/host_login_view.dart';
import '../views/auth/host_signup_view.dart';
import '../views/auth/host_otp_view.dart';
import '../views/auth/guest_signin_view.dart';
import '../views/host/events/create_event_view.dart';
import '../views/host/events/manage_event_view.dart';
import '../views/host/invitation/invitation_preview_view.dart';
import '../views/host/invitation/invitation_editor_view.dart';
import '../views/host/invitation/invitation_edit_text_view.dart';
import '../views/host/invitation/invitation_style_view.dart';
import '../views/host/invitation/invitation_send_view.dart';

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
      page: () => HostSignupView(),
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
    GetPage(
      name: AppEndpoints.createEvent,
      page: () => const CreateEventView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.manageEvent,
      page: () => const ManageEventView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: AppEndpoints.mainScreen, page: () => MainScreen()),

    GetPage(
      name: AppEndpoints.invitationPreview,
      page: () => const InvitationPreviewView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.invitationEditor,
      page: () => const InvitationEditorView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.invitationEditText,
      page: () => const InvitationEditTextView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.invitationStyle,
      page: () => const InvitationStyleView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppEndpoints.invitationSend,
      page: () => const InvitationSendView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
