import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_colors.dart';

class AuthScaffold extends StatelessWidget {
  final String badgeText;
  final String subtitle;
  final String title;
  final Widget cardContent;
  final Widget? footerContent;
  final double headerHeight;

  const AuthScaffold({
    super.key,
    required this.badgeText,
    required this.subtitle,
    required this.title,
    required this.cardContent,
    this.footerContent,
    this.headerHeight = 240,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // Top Purple Section with Decorative Graphic
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Deep Purple Background Container with rounded bottom corners
                Container(
                  width: double.infinity,
                  height: headerHeight + topPadding,
                  decoration: const BoxDecoration(
                    color: AppColors.headerBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                ),

                // Top-right decorative circular accent matching the design
                Positioned(
                  top: -20,
                  right: -30,
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.headerCircle,
                    ),
                  ),
                ),

                // Header Content (Badge, Subtitle, Title)
                Positioned(
                  top: topPadding + 16,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          badgeText.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: AppColors.badgeText,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Subtitle
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          color: AppColors.textSubtitle,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Main Title
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: AppColors.textWhite,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating White Card placed overlapping the bottom of purple header
                Padding(
                  padding: EdgeInsets.only(
                    top: headerHeight + topPadding - 45,
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
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.cardShadow,
                          blurRadius: 28,
                          offset: Offset(0, 10),
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
