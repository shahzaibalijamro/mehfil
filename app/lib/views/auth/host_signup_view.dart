import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_endpoints.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class HostSignupView extends StatefulWidget {
  const HostSignupView({super.key});

  @override
  State<HostSignupView> createState() => _HostSignupViewState();
}

class _HostSignupViewState extends State<HostSignupView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
            controller: _fullNameController,
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Confirm password',
            hint: '••••••••',
            isPassword: true,
            textInputAction: TextInputAction.done,
            controller: _confirmPasswordController,
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
