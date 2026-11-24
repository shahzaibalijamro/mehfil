import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/guest_book_controller.dart';
import '../../../theme/app_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../widgets/host_header.dart';
import 'widgets/guest_list_card.dart';
import 'widgets/guest_stat_card.dart';

class HostGuestBookScreen extends StatelessWidget {
  HostGuestBookScreen({super.key});

  final GuestBookController controller = Get.put(GuestBookController());

  void _openInviteGuestSheet(BuildContext context) {
    final customColors = context.customColors;
    final theme = Theme.of(context);

    // Reset form fields before opening
    controller.resetInviteForm();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          left: 22,
          right: 22,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        decoration: BoxDecoration(
          color: customColors.cardBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: customColors.inputBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Invite a Guest',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Guest Name',
              hint: 'e.g. Sarah Jenkins',
              controller: controller.nameController,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Party Size',
              hint: '1',
              keyboardType: TextInputType.number,
              controller: controller.partySizeController,
            ),
            const SizedBox(height: 22),
            CustomButton(
              text: 'Send Invitation',
              onPressed: () {
                final guestName = controller.nameController.text.trim();
                if (guestName.isNotEmpty) {
                  controller.addGuestFromForm();
                  Get.back(); // Closes bottom sheet
                  Get.snackbar(
                    'Invitation Sent',
                    'Invitation has been sent to $guestName!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: theme.colorScheme.primary,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2),
                  );
                }
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unified Reusable Header with "Invite guest" action button
            HostHeader(
              badgeText: 'HOST PANEL',
              title: 'Guest book',
              action: ElevatedButton(
                onPressed: () => _openInviteGuestSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDDA853),
                  foregroundColor: const Color(0xFF281703),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Invite guest',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF281703),
                  ),
                ),
              ),
            ),

            // Content Section below Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Stats Cards Row (Accepted, Pending, Cancelled)
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: GuestStatCard(
                            count: '${controller.acceptedCount}',
                            label: 'Accepted',
                            backgroundColor: const Color(0xFFE2F5EA),
                            textColor: const Color(0xFF1E5B35),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GuestStatCard(
                            count: '${controller.pendingCount}',
                            label: 'Pending',
                            backgroundColor: const Color(0xFFFDF0D5),
                            textColor: const Color(0xFF8B5A16),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GuestStatCard(
                            count: '${controller.cancelledCount}',
                            label: 'Cancelled',
                            backgroundColor: const Color(0xFFFDE5E5),
                            textColor: const Color(0xFF9E2A2B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 2. Filter Tabs (All | Accepted | Pending | Cancelled)
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: customColors.roleSwitchBackground,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: GuestFilter.values.map((filter) {
                          final isSelected =
                              controller.selectedFilter.value == filter;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => controller.setFilter(filter),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? customColors.cardBackground
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: customColors.cardShadow,
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  filter.name[0].toUpperCase() +
                                      filter.name.substring(1),
                                  style: GoogleFonts.poppins(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : customColors.textMuted,
                                    fontSize: 12.5,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 3. Guest List
                  Obx(
                    () {
                      final list = controller.filteredGuests;
                      if (list.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              'No guests in this category',
                              style: GoogleFonts.poppins(
                                color: customColors.textMuted,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: list.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          return GuestListCard(guest: list[index]);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
