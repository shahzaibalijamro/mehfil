import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../theme/app_theme.dart';

class HostEventItem {
  final String title;
  final String venue;
  final String day;
  final String month;
  final Color badgeBackgroundColor;
  final Color badgeTextColor;
  final VoidCallback? onManage;

  const HostEventItem({
    required this.title,
    required this.venue,
    required this.day,
    required this.month,
    required this.badgeBackgroundColor,
    required this.badgeTextColor,
    this.onManage,
  });
}

class HostEventCard extends StatelessWidget {
  final HostEventItem event;

  const HostEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: customColors.cardShadow,
            blurRadius: 18,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Date badge
          Container(
            width: 54,
            height: 58,
            decoration: BoxDecoration(
              color: event.badgeBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.day,
                  style: GoogleFonts.poppins(
                    color: event.badgeTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                Text(
                  event.month.toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: event.badgeTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Title & Venue
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  event.venue,
                  style: GoogleFonts.poppins(
                    color: customColors.textMuted,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Manage Button
          ElevatedButton(
            onPressed: event.onManage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDDA853), // Warm golden ochre
              foregroundColor: const Color(0xFF281703),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              minimumSize: const Size(82, 38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Manage',
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF281703),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
