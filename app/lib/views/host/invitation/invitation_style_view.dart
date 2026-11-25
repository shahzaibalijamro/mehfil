import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/invitation_controller.dart';
import '../../../theme/app_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../widgets/host_header.dart';
import 'widgets/invitation_card.dart';

class InvitationStyleView extends StatelessWidget {
  const InvitationStyleView({super.key});

  Widget _title(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _colorCircle(
    BuildContext context,
    Color color,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : context.customColors.inputBorder,
            width: selected ? 3 : 1.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final c = Get.find<InvitationController>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HostHeader(
              badgeText: 'HOST PANEL',
              title: 'Style',
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                children: [
                  const SizedBox(
                    width: 200,
                    child: LiveInvitationCard(small: true),
                  ),

                  // Background color
                  _title(context, 'Background'),
                  Obx(() {
                    final selected = c.bgColor.value;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: c.backgroundOptions.map((color) {
                        return _colorCircle(
                          context,
                          color,
                          selected == color,
                          () => c.bgColor.value = color,
                        );
                      }).toList(),
                    );
                  }),

                  _title(context, 'Text color'),
                  Obx(() {
                    final selected = c.textColor.value;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: c.textColorOptions.map((color) {
                        return _colorCircle(
                          context,
                          color,
                          selected == color,
                          () => c.textColor.value = color,
                        );
                      }).toList(),
                    );
                  }),

                  // Font
                  _title(context, 'Font style'),
                  Obx(() {
                    final selected = c.fontFamily.value;
                    return Row(
                      children: c.fonts.map((font) {
                        final isSelected = selected == font;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => c.fontFamily.value = font,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: customColors.cardBackground,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : customColors.inputBorder,
                                  width: isSelected ? 2 : 1.2,
                                ),
                              ),
                              child: Text(
                                'Aa',
                                style: GoogleFonts.getFont(
                                  font,
                                  fontSize: 22,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),

                  const SizedBox(height: 10),
                  Obx(
                    () => SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Show date & venue',
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: c.showDetails.value,
                      onChanged: (value) => c.showDetails.value = value,
                    ),
                  ),
                  const SizedBox(height: 14),
                  CustomButton(text: 'Done', onPressed: () => Get.back()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
