import 'package:app/constants/user_roles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_endpoints.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/role_switch_button.dart';

class GuestSigninView extends StatefulWidget {
  const GuestSigninView({super.key});

  @override
  State<GuestSigninView> createState() => _GuestSigninViewState();
}

class _GuestSigninViewState extends State<GuestSigninView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return AuthScaffold(
      badgeText: 'GUEST PANEL',
      subtitle: 'Join and experience events.',
      title: 'Guest signin',
      headerHeight: 150,
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Email',
            hint: 'name@email.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: _emailController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Password',
            hint: '••••••••',
            isPassword: true,
            textInputAction: TextInputAction.next,
            controller: _passwordController,
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
            text: 'Sign in',
            onPressed: () {
              Get.snackbar(
                'Guest Signed In',
                'Welcome to Guest Panel!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: theme.colorScheme.primary,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
              );
              Future.delayed(const Duration(milliseconds: 600), () {
                Get.offAllNamed(
                  AppEndpoints.mainScreen,
                  arguments: UserRole.guest,
                );
              });
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
