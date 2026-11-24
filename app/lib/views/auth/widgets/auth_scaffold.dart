import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/theme_controller.dart';
import '../../../theme/app_theme.dart';

class AuthScaffold extends StatelessWidget {
  final String badgeText;
  final String subtitle;
  final String title;
  final Widget cardContent;
  final Widget? footerContent;
  final double headerHeight;

  AuthScaffold({
    super.key,
    required this.badgeText,
    required this.subtitle,
    required this.title,
    required this.cardContent,
    this.footerContent,
    this.headerHeight = 150,
  });

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // Top Section with Decorative Graphic & Theme Toggle
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Header Background Container with rounded bottom corners
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: headerHeight + topPadding,
                    color: customColors.headerBackground,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Top-right decorative circular accent
                        Positioned(
                          top: -24,
                          right: -32,
                          child: IgnorePointer(
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: customColors.headerCircle.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top Row: Badge on left, Theme Toggle on right (above decorative circle)
                Positioned(
                  top: topPadding + 14,
                  left: 22,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: customColors.badgeBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          badgeText.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: customColors.badgeText,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            themeController.isDarkMode
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          tooltip: themeController.isDarkMode
                              ? 'Switch to Light Theme'
                              : 'Switch to Dark Theme',
                          onPressed: themeController.toggleTheme,
                        ),
                      ),
                    ],
                  ),
                ),

                // Header Content: Title and Subtitle
                Positioned(
                  top: topPadding + 48,
                  left: 22,
                  right: 22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Floating Card placed overlapping the bottom of header
                Padding(
                  padding: EdgeInsets.only(
                    top: headerHeight + topPadding - 24,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: customColors.cardBackground,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: customColors.cardShadow,
                          blurRadius: 28,
                          offset: const Offset(0, 10),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: cardContent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Optional Footer Content below the card
            if (footerContent != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: footerContent!,
              ),
              const SizedBox(height: 28),
            ] else
              const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
