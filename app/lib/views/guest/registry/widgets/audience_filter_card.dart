import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudienceFilterCard extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isSelected;
  final VoidCallback onTap;

  const AudienceFilterCard({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark
        ? backgroundColor.withValues(alpha: isSelected ? 0.34 : 0.20)
        : backgroundColor;
    final labelColor = isDark ? Colors.white : textColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        height: 100,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? (isDark ? Colors.white : textColor)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            if (isSelected)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white : textColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 13,
                    color: isDark ? const Color(0xFF1E132D) : Colors.white,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: labelColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
