import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapPinCard extends StatelessWidget {
  final VoidCallback onTap;

  const MapPinCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF1B2D21) : const Color(0xFFE9F3EB);
    final gridLineColor = isDark
        ? const Color(0xFF26402E).withValues(alpha: 0.6)
        : const Color(0xFFD2E6D5).withValues(alpha: 0.85);
    final borderColor = isDark ? const Color(0xFF284831) : const Color(0xFFCCE4D1);
    final contentColor = isDark ? const Color(0xFF8FE19D) : const Color(0xFF1F4D25);

    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CustomPaint(
          painter: _GridPatternPainter(gridColor: gridLineColor),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: contentColor,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Pin live location on Google Map',
                      style: GoogleFonts.poppins(
                        color: contentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  final Color gridColor;

  _GridPatternPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    const double step = 16.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPatternPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor;
  }
}
