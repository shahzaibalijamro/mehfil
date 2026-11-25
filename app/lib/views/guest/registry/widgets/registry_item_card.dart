import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/guest_registry_controller.dart';
import '../../../../theme/app_theme.dart';

class RegistryItemCard extends StatelessWidget {
  final RegistryGiftItem item;
  final VoidCallback onShopPressed;

  const RegistryItemCard({
    super.key,
    required this.item,
    required this.onShopPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: customColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product preview box
          Container(
            width: double.infinity,
            height: 96,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF2C1D42)
                  : const Color(0xFFEDE4F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                item.icon,
                size: 34,
                color: theme.colorScheme.primary.withValues(alpha: 0.78),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Item Name
          Text(
            item.name,
            style: GoogleFonts.poppins(
              color: theme.colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),

          // Brand Name
          Text(
            item.brand,
            style: GoogleFonts.poppins(
              color: customColors.textMuted,
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          // Shop at brand URL launcher button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: onShopPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE4B956),
                foregroundColor: const Color(0xFF281703),
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Shop at brand',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF281703),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
