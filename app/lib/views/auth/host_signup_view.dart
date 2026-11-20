import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_endpoints.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class HostSignupView extends StatelessWidget {
  HostSignupView({super.key});
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return AuthScaffold(
      badgeText: 'HOST PANEL',
      subtitle: 'Plan and manage your events.',
      title: 'Create account',
      headerHeight: 150,
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Full name',
            hint: 'Your full name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: fullNameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Email',
            hint: 'name@email.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: emailController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Password',
            hint: '••••••••',
            isPassword: true,
            textInputAction: TextInputAction.next,
            controller: passwordController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Confirm password',
            hint: '••••••••',
            isPassword: true,
            textInputAction: TextInputAction.done,
            controller: confirmPasswordController,
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
              color: customColors.textMuted,
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
