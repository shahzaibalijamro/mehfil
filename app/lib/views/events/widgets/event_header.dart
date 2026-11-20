import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/theme_controller.dart';
import '../../../theme/app_theme.dart';

class EventHeader extends StatelessWidget {
  final String badgeText;
  final String? subtitle;
  final String title;
  final Widget? extraContent;
  final bool showBackButton;
  final double? height;

  const EventHeader({
    super.key,
    this.badgeText = 'HOST PANEL',
    this.subtitle,
    required this.title,
    this.extraContent,
    this.showBackButton = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = context.customColors;
    final themeController = Get.find<ThemeController>();
    final topPadding = MediaQuery.of(context).padding.top;
    final canPop = showBackButton && Navigator.canPop(context);

    // Standard header height is 150 (+ topPadding for safe area), or 240 when extraContent (countdown timer) is present
    final effectiveHeight =
        (height ?? (extraContent != null ? 240.0 : 150.0)) + topPadding;
    const double shapeSize = 140.0;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(36),
        bottomRight: Radius.circular(36),
      ),
      child: Container(
        width: double.infinity,
        height: effectiveHeight,
        color: customColors.headerBackground,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. Decorative circular accent shape in top-right (rendered BEHIND content and toggle)
            Positioned(
              top: -24,
              right: -32,
              child: IgnorePointer(
                child: Container(
                  width: shapeSize,
                  height: shapeSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: customColors.headerCircle.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),

            // 2. Foreground Header Content (Theme Toggle, Badge, Title, extraContent) - rendered ABOVE the shape
            Padding(
              padding: EdgeInsets.fromLTRB(
                22,
                topPadding + 14,
                22,
                extraContent != null ? 18 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top row: Back button (if available) + Badge + Theme Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (canPop) ...[
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 10),
                          ],
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
                        ],
                      ),
                      // Theme Toggle Action Button (placed in front of the decorative shape)
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
                  SizedBox(height: extraContent != null ? 12 : 14),

                  // Optional Subtitle (e.g. "[Event name]")
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    Text(
                      subtitle!,
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],

                  // Title (e.g. "Create new event" or "Manage event")
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),

                  // Extra content (e.g. Countdown timer)
                  if (extraContent != null) ...[
                    const SizedBox(height: 14),
                    extraContent!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
