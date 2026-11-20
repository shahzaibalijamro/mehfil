import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_endpoints.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/role_switch_button.dart';

class GuestSigninView extends StatelessWidget {
  const GuestSigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      badgeText: 'GUEST PANEL',
      subtitle: 'Join and experience events.',
      title: 'Guest signin',
      headerHeight: 235,
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
                  backgroundColor: AppColors.primaryDark,
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
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Sign in',
            onPressed: () {
              Get.snackbar(
                'Guest Signed In',
                'Welcome to Guest Panel!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
              );
            },
          ),
          const SizedBox(height: 16),
          RoleSwitchButton(
            text: 'Switch to Host Login',
            onPressed: () {
              Get.toNamed(AppEndpoints.hostLogin);
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
              color: AppColors.textMuted,
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
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
