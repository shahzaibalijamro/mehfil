import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_endpoints.dart';
import '../../../controllers/invitation_controller.dart';
import '../../../theme/app_theme.dart';
import '../widgets/host_header.dart';
import 'widgets/invitation_card.dart';

class HostInvitationScreen extends StatelessWidget {
  HostInvitationScreen({super.key});

  final InvitationController controller = Get.put(InvitationController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HostHeader(
              badgeText: 'HOST PANEL',
              subtitle: 'Pick a design for your event',
              title: 'Invitations',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chips
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.categories.map((category) {
                          final isSelected =
                              controller.selectedCategory.value == category;
                          return GestureDetector(
                            onTap: () => controller.setCategory(category),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : customColors.cardBackground,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : customColors.inputBorder,
                                ),
                              ),
                              child: Text(
                                category,
                                style: GoogleFonts.poppins(
                                  color: isSelected
                                      ? Colors.white
                                      : customColors.textMuted,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Template grid
                  Obx(
                    () => GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.64,
                      children: controller.filteredTemplates.map((t) {
                        final d = controller.defaults[t.category]!;
                        return GestureDetector(
                          onTap: () {
                            controller.selectTemplate(t);
                            Get.toNamed(AppEndpoints.invitationPreview);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InvitationCard(
                                bgColor: t.color,
                                textColor: const Color(0xFF2D0F4E),
                                fontFamily: 'Great Vibes',
                                intro: d[0],
                                name1: d[1],
                                name2: d[2],
                                showDetails: false,
                                small: true,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                t.name,
                                style: GoogleFonts.poppins(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
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
