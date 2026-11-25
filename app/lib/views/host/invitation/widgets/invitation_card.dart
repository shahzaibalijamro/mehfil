import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/invitation_controller.dart';

class InvitationCard extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String fontFamily;
  final String intro;
  final String name1;
  final String name2;
  final String dateTime;
  final String venue;
  final bool showDetails;
  final bool small;
  final VoidCallback? onTap;

  const InvitationCard({
    super.key,
    required this.bgColor,
    required this.textColor,
    required this.fontFamily,
    required this.intro,
    required this.name1,
    this.name2 = '',
    this.dateTime = '',
    this.venue = '',
    this.showDetails = true,
    this.small = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final nameStyle = GoogleFonts.getFont(
      fontFamily,
      fontSize: small ? 18 : 34,
      color: textColor,
    );
    final labelStyle = GoogleFonts.poppins(
      fontSize: small ? 6 : 10,
      letterSpacing: 1.2,
      color: textColor,
    );

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          padding: EdgeInsets.all(small ? 5 : 9),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22201040),
                blurRadius: 16,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: small ? 6 : 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC9A24B), width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (intro.isNotEmpty)
                    Text(
                      intro.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: labelStyle,
                    ),
                  SizedBox(height: small ? 4 : 10),
                  Text(name1, textAlign: TextAlign.center, style: nameStyle),
                  if (name2.isNotEmpty) ...[
                    Text('&', style: labelStyle),
                    Text(name2, textAlign: TextAlign.center, style: nameStyle),
                  ],
                  if (showDetails) ...[
                    SizedBox(height: small ? 6 : 16),
                    Text(
                      dateTime.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: labelStyle,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      venue.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: labelStyle,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// controller prr latest values show krta hy
class LiveInvitationCard extends StatelessWidget {
  final bool small;
  final VoidCallback? onTap;

  const LiveInvitationCard({super.key, this.small = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<InvitationController>();

    return Obx(
      () => InvitationCard(
        bgColor: c.bgColor.value,
        textColor: c.textColor.value,
        fontFamily: c.fontFamily.value,
        intro: c.intro.value,
        name1: c.name1.value,
        name2: c.name2.value,
        dateTime: c.dateTime.value,
        venue: c.venue.value,
        showDetails: c.showDetails.value,
        small: small,
        onTap: onTap,
      ),
    );
  }
}
