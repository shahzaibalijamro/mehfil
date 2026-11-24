import 'package:app/constants/app_colors.dart';
import 'package:app/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          top: false,
          child: controller.screens[controller.currentScreenIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentScreenIndex.value,
          backgroundColor: AppColors.textWhite,

          onTap: controller.switchScreens,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            color: AppColors.textMuted,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
          items: controller.navBarItems,
        ),
      ),
    );
  }
}
