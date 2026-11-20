import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_endpoints.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/otp_input_row.dart';

class HostOtpView extends StatelessWidget {
  const HostOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      badgeText: 'HOST PANEL',
      subtitle: 'Enter the 6-digit code we sent you.',
      title: 'Verify your login',
      headerHeight: 235,
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          const OtpInputRow(length: 6),
          const SizedBox(height: 22),
          CustomButton(
            text: 'Verify',
            onPressed: () {
              Get.snackbar(
                'Success',
                'Verification complete! Returning to login...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
              Future.delayed(const Duration(milliseconds: 1200), () {
                Get.offAllNamed(AppEndpoints.hostLogin);
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't get it? ",
                style: GoogleFonts.poppins(
                  color: AppColors.textMuted,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Code Resent',
                    'A new 6-digit verification code has been sent.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.primaryDark,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                  );
                },
                child: Text(
                  'Resend code',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
      footerContent: Center(
        child: Text(
          'Your account opens only after verification.',
          style: GoogleFonts.poppins(
            color: AppColors.textMuted,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
