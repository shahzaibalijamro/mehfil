import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_endpoints.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class HostSignupView extends StatelessWidget {
  const HostSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      badgeText: 'HOST PANEL',
      subtitle: 'Plan and manage your events.',
      title: 'Create account',
      headerHeight: 235,
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            label: 'Full name',
            hint: 'Your full name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'Confirm password',
            hint: '••••••••',
            isPassword: true,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Sign up',
            onPressed: () {
              Get.toNamed(AppEndpoints.hostOtp);
            },
          ),
        ],
      ),
      footerContent: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: GoogleFonts.poppins(
              color: AppColors.textMuted,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppEndpoints.hostLogin);
            },
            child: Text(
              'Log in',
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
