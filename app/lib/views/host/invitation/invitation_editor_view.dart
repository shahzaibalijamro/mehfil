import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_endpoints.dart';
import '../../../theme/app_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../widgets/host_header.dart';
import 'widgets/invitation_card.dart';

class InvitationEditorView extends StatelessWidget {
  const InvitationEditorView({super.key});

  Widget _tool(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Expanded(
      child: GestureDetector(
        onTap: () => Get.toNamed(route),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: customColors.cardBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: customColors.inputBorder),
          ),
          child: Column(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: customColors.textMuted,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HostHeader(
              badgeText: 'HOST PANEL',
              title: 'Edit card',
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                children: [
                  Text(
                    'Tap the card to edit its text',
                    style: GoogleFonts.poppins(
                      color: customColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiveInvitationCard(
                    onTap: () => Get.toNamed(AppEndpoints.invitationEditText),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _tool(
                        context,
                        Icons.text_fields_rounded,
                        'Text',
                        AppEndpoints.invitationEditText,
                      ),
                      _tool(
                        context,
                        Icons.font_download_outlined,
                        'Font',
                        AppEndpoints.invitationStyle,
                      ),
                      _tool(
                        context,
                        Icons.palette_outlined,
                        'Color',
                        AppEndpoints.invitationStyle,
                      ),
                      _tool(
                        context,
                        Icons.format_color_fill_rounded,
                        'Background',
                        AppEndpoints.invitationStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Next',
                    onPressed: () => Get.toNamed(AppEndpoints.invitationSend),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
