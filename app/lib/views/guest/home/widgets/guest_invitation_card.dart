import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/guest_home_controller.dart';
import '../../../../theme/app_theme.dart';
import '../../../auth/widgets/custom_button.dart';

class GuestInvitationCard extends StatelessWidget {
  final GuestInvitationItem invitation;
  final VoidCallback onViewEvent;

  const GuestInvitationCard({
    super.key,
    required this.invitation,
    required this.onViewEvent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: customColors.cardShadow,
            blurRadius: 18,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top pastel banner with date badge
          Container(
            width: double.infinity,
            height: 108,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? invitation.bannerColor.withValues(alpha: 0.24)
                  : invitation.bannerColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            alignment: Alignment.topLeft,
            child: Container(
              width: 58,
              height: 62,
              decoration: BoxDecoration(
                color: customColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    invitation.day,
                    style: GoogleFonts.poppins(
                      color: isDark
                          ? theme.colorScheme.onSurface
                          : invitation.dateTextColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    invitation.month.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: isDark
                          ? customColors.textMuted
                          : invitation.dateTextColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details & View Event Action
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invitation.title,
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Hosted by ${invitation.hostName} · ${invitation.venue}',
                  style: GoogleFonts.poppins(
                    color: customColors.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'View event',
                  height: 46,
                  onPressed: onViewEvent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
