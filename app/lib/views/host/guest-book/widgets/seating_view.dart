import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/guest_book_controller.dart';
import '../../../../theme/app_theme.dart';
import 'guest_stat_card.dart';
import 'seating_sheets.dart';
import 'seating_table_card.dart';

class SeatingView extends StatelessWidget {
  final GuestBookController controller;

  const SeatingView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Stats Cards Row (Tables, Seats Filled, Unseated)
        Obx(
          () => Row(
            children: [
              Expanded(
                child: GuestStatCard(
                  count: '${controller.totalTables}',
                  label: 'Tables',
                  backgroundColor: const Color(0xFFEDE4F7),
                  textColor: const Color(0xFF561A83),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GuestStatCard(
                  count:
                      '${controller.totalOccupiedSeats}/${controller.totalCapacity}',
                  label: 'Seats filled',
                  backgroundColor: const Color(0xFFE2F5EA),
                  textColor: const Color(0xFF1E5B35),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GuestStatCard(
                  count: '${controller.unseatedAcceptedGuestsCount}',
                  label: 'Unseated',
                  backgroundColor: const Color(0xFFFDF0D5),
                  textColor: const Color(0xFF8B5A16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2. Quick Setup Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.12),
                theme.colorScheme.primary.withValues(alpha: 0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Seating Setup',
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Batch generate tables for your venue layout in seconds',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                        color: customColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => SeatingSheets.showBatchSetupSheet(
                  context,
                  controller,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Batch Setup',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Section Title with Add Table shortcut
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Event Tables',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            TextButton.icon(
              onPressed: () => SeatingSheets.showAddOrEditTableSheet(
                context,
                controller,
              ),
              icon: const Icon(Icons.add_rounded, size: 16),
              label: Text(
                'Add Table',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // 4. Tables List
        Obx(() {
          final tables = controller.tables;
          if (tables.isEmpty) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: customColors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: customColors.inputBorder),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.table_restaurant_outlined,
                    size: 48,
                    color: customColors.textMuted,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No tables added yet',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Add individual tables or use Quick Setup to generate multiple tables at once.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: customColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => SeatingSheets.showAddOrEditTableSheet(
                      context,
                      controller,
                    ),
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Table'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: tables.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final table = tables[index];
              final occupied = controller.getTableOccupiedSeats(table);
              final guests = controller.getGuestsForTable(table);

              return SeatingTableCard(
                table: table,
                occupiedSeats: occupied,
                assignedGuests: guests,
                onAssignGuest: () => SeatingSheets.showAssignGuestSheet(
                  context,
                  controller,
                  table,
                ),
                onUnassignGuest: (guest) {
                  controller.unassignGuestFromTable(table.id, guest.id);
                  Get.snackbar(
                    'Guest Unseated',
                    '${guest.name} removed from ${table.name}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: theme.colorScheme.primary,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2),
                  );
                },
                onEditTable: () => SeatingSheets.showAddOrEditTableSheet(
                  context,
                  controller,
                  table,
                ),
                onDeleteTable: () => SeatingSheets.showDeleteConfirmation(
                  context,
                  controller,
                  table,
                ),
              );
            },
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }
}
