import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class TimelineCard extends StatelessWidget {
  final int activeTab;

  const TimelineCard({
    super.key,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: customColors.cardShadow,
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _buildContent(context, theme, customColors),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ThemeData theme,
    AppCustomColors customColors,
  ) {
    switch (activeTab) {
      case 1:
        // Photos Tab View
        return Column(
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 44,
              color: theme.colorScheme.primary.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 10),
            Text(
              'Event Gallery',
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'No photos uploaded yet. Tap below to capture or add memories.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: customColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      case 2:
        // Venue Tab View
        return Column(
          children: [
            Icon(
              Icons.place_outlined,
              size: 44,
              color: theme.colorScheme.primary.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 10),
            Text(
              'Venue Information',
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Hall A, Grand Plaza Hotel & Resorts\n123 Celebration Boulevard',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: customColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      case 0:
      default:
        // Timeline Tab View (as shown in image)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivityItem(
              theme: theme,
              customColors: customColors,
              activity: '[Activity]',
              time: '[Time]',
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              theme: theme,
              customColors: customColors,
              activity: '[Activity]',
              time: '[Time]',
            ),
          ],
        );
    }
  }

  Widget _buildActivityItem({
    required ThemeData theme,
    required AppCustomColors customColors,
    required String activity,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity,
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              time,
              style: GoogleFonts.poppins(
                color: customColors.textMuted,
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
