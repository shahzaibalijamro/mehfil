import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_endpoints.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/role_switch_button.dart';

class HostLoginView extends StatelessWidget {
  const HostLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return AuthScaffold(
      badgeText: 'HOST PANEL',
      subtitle: 'Plan and manage your events.',
      title: 'Log in',
      headerHeight: 150,
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            label: 'Email',
            hint: 'name@email.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'Password',
            hint: '••••••••',
            isPassword: true,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.snackbar(
                  'Password Reset',
                  'Password reset instructions sent to your email.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: theme.colorScheme.secondary,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot password?',
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Log in',
            onPressed: () {
              Get.snackbar(
                'Host Logged In',
                'Welcome back to Host Panel!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: theme.colorScheme.primary,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
              Future.delayed(const Duration(milliseconds: 600), () {
                Get.toNamed(AppEndpoints.createEvent);
              });
            },
          ),
          const SizedBox(height: 16),
          RoleSwitchButton(
            text: 'Switch to Guest Signin',
            onPressed: () {
              Get.toNamed(AppEndpoints.guestSignin);
            },
          ),
        ],
      ),
      footerContent: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: GoogleFonts.poppins(
              color: customColors.textMuted,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppEndpoints.hostSignup);
            },
            child: Text(
              'Sign up',
              style: GoogleFonts.poppins(
                color: theme.colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
