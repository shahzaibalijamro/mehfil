// import 'package:flutter/material.dart';

// class GuestSettingsScreen extends StatelessWidget {
//   const GuestSettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [Center(child: CircleAvatar(child: Text("Guset")))],
//       ),
//     );
//   }
// }

import 'package:app/constants/app_colors.dart';
import 'package:app/constants/app_endpoints.dart';
import 'package:app/views/guest/widgets/guest_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'app_colors.dart';

class GuestSettingsPage extends StatefulWidget {
  const GuestSettingsPage({super.key});

  @override
  State<GuestSettingsPage> createState() => _GuestSettingsPageState();
}

class _GuestSettingsPageState extends State<GuestSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(
    text: 'Guest User',
  );

  final TextEditingController emailController = TextEditingController(
    text: 'guest@example.com',
  );

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  String? selectedGender = 'Male';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        dobController.text = '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  void logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add your logout logic here.
              Get.offAllNamed(AppEndpoints.guestSignin);
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          GuestHeader(
            badgeText: 'GUEST PANEL',
            subtitle: 'Settings',
            title: 'Account settings',
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
              child: Column(
                children: [
                  _buildProfile(),

                  const SizedBox(height: 28),

                  _buildProfileForm(),

                  const SizedBox(height: 25),

                  _buildLogoutButton(),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HEADER
  // PROFILE AVATAR
  Widget _buildProfile() {
    return Column(
      children: [
        Container(
          height: 145,
          width: 145,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF0E3F8),
            border: Border.all(color: Colors.white, width: 6),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.person, size: 95, color: AppColors.primary),
        ),

        const SizedBox(height: 12),

        const Text(
          'Guest User',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.headerBackground,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Manage your profile information',
          style: TextStyle(fontSize: 14, color: AppColors.textMuted),
        ),
      ],
    );
  }

  // PROFILE FORM
  Widget _buildProfileForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Update your personal details below.',
              style: TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),

            const SizedBox(height: 22),

            _buildLabel('Full Name'),
            _buildTextField(
              controller: nameController,
              hint: 'Enter your full name',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 18),

            _buildLabel('Email Address'),
            _buildTextField(
              controller: emailController,
              hint: 'Enter your email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 18),

            _buildLabel('Phone Number'),
            _buildTextField(
              controller: phoneController,
              hint: 'Enter your phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 18),

            _buildLabel('Date of Birth'),
            TextFormField(
              controller: dobController,
              readOnly: true,
              onTap: selectDate,
              decoration: _inputDecoration(
                hint: 'Select your date of birth',
                icon: Icons.calendar_month_outlined,
                suffix: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textMuted,
                ),
              ),
            ),

            const SizedBox(height: 18),

            _buildLabel('Gender'),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: _inputDecoration(
                hint: 'Select gender',
                icon: Icons.people_outline,
              ),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
                DropdownMenuItem(
                  value: 'Prefer not to say',
                  child: Text('Prefer not to say'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add your update profile API logic here.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile details validated successfully'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIELD LABEL
  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  // TEXT FIELD
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(hint: hint, icon: icon),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  // INPUT DECORATION
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppColors.textPlaceholder,
        fontSize: 13,
      ),
      prefixIcon: Icon(icon, color: AppColors.primary, size: 21),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.inputFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.inputBorderFocused,
          width: 1.5,
        ),
      ),
    );
  }

  // LOGOUT BUTTON
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: logout,
        icon: const Icon(Icons.logout, size: 24),
        label: const Text(
          'Log Out',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: AppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 15,
            offset: Offset(0, -3),
          ),
        ],
      ),
    );
  }
}
