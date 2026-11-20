import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownTimerRow extends StatelessWidget {
  final String days;
  final String hours;
  final String minutes;
  final String seconds;

  const CountdownTimerRow({
    super.key,
    this.days = '24',
    this.hours = '06',
    this.minutes = '41',
    this.seconds = '09',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTimerCard(value: days, label: 'Days'),
        const SizedBox(width: 10),
        _buildTimerCard(value: hours, label: 'Hours'),
        const SizedBox(width: 10),
        _buildTimerCard(value: minutes, label: 'Min'),
        const SizedBox(width: 10),
        _buildTimerCard(value: seconds, label: 'Sec'),
      ],
    );
  }

  Widget _buildTimerCard({required String value, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
