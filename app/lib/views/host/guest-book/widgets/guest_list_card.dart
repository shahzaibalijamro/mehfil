import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../theme/app_theme.dart';

enum GuestStatus {
  accepted('Accepted', Color(0xFFE2F5EA), Color(0xFF1E5B35)),
  pending('Pending', Color(0xFFFDF0D5), Color(0xFF8B5A16)),
  cancelled('Cancelled', Color(0xFFFDE5E5), Color(0xFF9E2A2B));

  final String label;
  final Color backgroundColor;
  final Color textColor;

  const GuestStatus(this.label, this.backgroundColor, this.textColor);
}

class GuestItem {
  final String id;
  final String name;
  final int partySize;
  final GuestStatus status;

  const GuestItem({
    this.id = '',
    required this.name,
    required this.partySize,
    required this.status,
  });

  GuestItem copyWith({
    String? id,
    String? name,
    int? partySize,
    GuestStatus? status,
  }) {
    return GuestItem(
      id: id ?? this.id,
      name: name ?? this.name,
      partySize: partySize ?? this.partySize,
      status: status ?? this.status,
    );
  }
}

class GuestListCard extends StatelessWidget {
  final GuestItem guest;

  const GuestListCard({
    super.key,
    required this.guest,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    final initial = guest.name.trim().isNotEmpty
        ? guest.name.trim()[0].toUpperCase()
        : 'G';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: customColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Avatar with Guest Initial
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFEADBFA), // Light purple avatar background
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: GoogleFonts.poppins(
                color: const Color(0xFF561A83),
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Guest Name and Party size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  guest.name,
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Party of ${guest.partySize}',
                  style: GoogleFonts.poppins(
                    color: customColors.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Status Badge Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: guest.status.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              guest.status.label,
              style: GoogleFonts.poppins(
                color: guest.status.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
