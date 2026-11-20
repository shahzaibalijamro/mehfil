import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_endpoints.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/otp_input_row.dart';

class HostOtpView extends StatelessWidget {
  const HostOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return AuthScaffold(
      badgeText: 'HOST PANEL',
      subtitle: 'Enter the 6-digit code we sent you.',
      title: 'Verify your login',
      headerHeight: 150,
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
                backgroundColor: theme.colorScheme.primary,
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
                  color: customColors.textMuted,
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
                    backgroundColor: theme.colorScheme.secondary,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                  );
                },
                child: Text(
                  'Resend code',
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.primary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.colorScheme.primary,
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
            color: customColors.textMuted,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
