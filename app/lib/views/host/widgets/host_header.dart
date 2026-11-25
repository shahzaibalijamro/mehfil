import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/theme_controller.dart';
import '../../../theme/app_theme.dart';

class HostHeader extends StatelessWidget {
  final String badgeText;
  final String? subtitle;
  final String title;
  final Widget? action;
  final Widget? extraContent;
  final bool showBackButton;

  HostHeader({
    super.key,
    this.badgeText = 'HOST PANEL',
    this.subtitle,
    required this.title,
    this.action,
    this.extraContent,
    this.showBackButton = false,
  });

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final customColors = context.customColors;
    final topPadding = MediaQuery.of(context).padding.top;
    final canPop = showBackButton && Navigator.canPop(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(36),
        bottomRight: Radius.circular(36),
      ),
      child: Container(
        width: double.infinity,
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
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: customColors.headerCircle.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),

            // Header Content
            Padding(
              padding: EdgeInsets.fromLTRB(
                22,
                topPadding + 14,
                22,
                extraContent != null ? 18 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Row: Back Button (optional) + Badge + Theme Toggle
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
                  const SizedBox(height: 14),

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

                  // Title and Optional Action Button (e.g. "Invite guest")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (action != null) ...[
                        const SizedBox(width: 12),
                        action!,
                      ],
                    ],
                  ),

                  // Optional Extra Content (e.g. countdown timer, filter chips)
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
