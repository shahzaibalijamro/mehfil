import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/guest_book_controller.dart';
import '../../../../theme/app_theme.dart';
import '../../../auth/widgets/custom_button.dart';
import '../../../auth/widgets/custom_text_field.dart';
import 'guest_list_card.dart';
import 'seating_models.dart';

class SeatingSheets {
  SeatingSheets._();

  static void showAddOrEditTableSheet(
    BuildContext context,
    GuestBookController controller, [
    SeatingTable? tableToEdit,
  ]) {
    final customColors = context.customColors;
    final theme = Theme.of(context);
    final isEditing = tableToEdit != null;

    controller.resetTableForm(tableToEdit);

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
        child: SingleChildScrollView(
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
                isEditing ? 'Edit Table' : 'Add New Table',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isEditing
                    ? 'Update table details and seat capacity'
                    : 'Set up a new table for your event seating layout',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: customColors.textMuted,
                ),
              ),
              const SizedBox(height: 18),

              // Table Name
              CustomTextField(
                label: 'Table Name / Number',
                hint: 'e.g. Table 1 or VIP Family',
                controller: controller.tableNameController,
              ),
              const SizedBox(height: 16),

              // Table Shape Selector
              Text(
                'Table Shape',
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: TableShape.values.map((shape) {
                    final isSelected =
                        controller.selectedTableShape.value == shape;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            controller.selectedTableShape.value = shape,
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: EdgeInsets.only(
                            right: shape == TableShape.round ? 10 : 0,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.08,
                                  )
                                : customColors.roleSwitchBackground,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : customColors.inputBorder,
                              width: isSelected ? 1.8 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                shape.icon,
                                size: 18,
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : customColors.textMuted,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                shape.label,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : customColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Seat Capacity Field
              CustomTextField(
                label: 'Number of Seats',
                hint: '8',
                keyboardType: TextInputType.number,
                controller: controller.seatCapacityController,
              ),
              const SizedBox(height: 8),

              // Quick presets (4, 6, 8, 10, 12)
              Row(
                children: [4, 6, 8, 10, 12].map((capacity) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => controller.seatCapacityController.text =
                          capacity.toString(),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: customColors.roleSwitchBackground,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: customColors.inputBorder),
                        ),
                        child: Text(
                          '$capacity seats',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: customColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Submit Button
              CustomButton(
                text: isEditing ? 'Save Changes' : 'Create Table',
                onPressed: () {
                  final name = controller.tableNameController.text.trim();
                  final cap = int.tryParse(
                        controller.seatCapacityController.text.trim(),
                      ) ??
                      8;

                  if (isEditing) {
                    controller.updateTable(
                      tableToEdit.id,
                      name: name,
                      capacity: cap,
                      shape: controller.selectedTableShape.value,
                    );
                    Get.back();
                    Get.snackbar(
                      'Table Updated',
                      'Changes to $name have been saved.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: theme.colorScheme.primary,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    controller.addTable(
                      name: name,
                      capacity: cap,
                      shape: controller.selectedTableShape.value,
                    );
                    Get.back();
                    Get.snackbar(
                      'Table Created',
                      '$name has been added to seating.',
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
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static void showBatchSetupSheet(
    BuildContext context,
    GuestBookController controller,
  ) {
    final customColors = context.customColors;
    final theme = Theme.of(context);

    controller.resetBatchForm();

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
        child: SingleChildScrollView(
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
                'Quick Seating Setup',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Batch generate multiple tables for your venue layout in one tap',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: customColors.textMuted,
                ),
              ),
              const SizedBox(height: 18),

              CustomTextField(
                label: 'Number of Tables to Create',
                hint: '4',
                keyboardType: TextInputType.number,
                controller: controller.batchTableCountController,
              ),
              const SizedBox(height: 14),

              CustomTextField(
                label: 'Seats per Table',
                hint: '8',
                keyboardType: TextInputType.number,
                controller: controller.batchCapacityController,
              ),
              const SizedBox(height: 14),

              Text(
                'Table Shape',
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: TableShape.values.map((shape) {
                    final isSelected =
                        controller.batchTableShape.value == shape;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.batchTableShape.value = shape,
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: EdgeInsets.only(
                            right: shape == TableShape.round ? 10 : 0,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.08,
                                  )
                                : customColors.roleSwitchBackground,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : customColors.inputBorder,
                              width: isSelected ? 1.8 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                shape.icon,
                                size: 18,
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : customColors.textMuted,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                shape.label,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : customColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Generate Tables',
                onPressed: () {
                  final count = int.tryParse(
                        controller.batchTableCountController.text.trim(),
                      ) ??
                      4;
                  final cap = int.tryParse(
                        controller.batchCapacityController.text.trim(),
                      ) ??
                      8;

                  controller.batchAddTables(
                    count: count,
                    capacity: cap,
                    shape: controller.batchTableShape.value,
                  );
                  Get.back();
                  Get.snackbar(
                    'Tables Generated',
                    '$count tables created successfully!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: theme.colorScheme.primary,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static void showAssignGuestSheet(
    BuildContext context,
    GuestBookController controller,
    SeatingTable table,
  ) {
    final customColors = context.customColors;
    final theme = Theme.of(context);
    final availableSeats = controller.getTableAvailableSeats(table);

    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assign to ${table.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '$availableSeats seats remaining open',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: customColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE4F7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${table.shape.label} • cap ${table.seatCapacity}',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF561A83),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: customColors.inputBorder, height: 1),
            const SizedBox(height: 12),

            // List of Unseated Accepted Guests
            Expanded(
              child: Obx(() {
                final unseated = controller.unseatedAcceptedGuests;
                if (unseated.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 44,
                            color: customColors.textMuted,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'All accepted guests are seated!',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Invite more guests from the Guest List tab.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: customColors.textMuted,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: unseated.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final guest = unseated[index];
                    final canFit = controller.canGuestFit(table, guest);
                    final initial = guest.name.trim().isNotEmpty
                        ? guest.name.trim()[0].toUpperCase()
                        : 'G';

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: canFit
                            ? () {
                                final success = controller.assignGuestToTable(
                                  table.id,
                                  guest.id,
                                );
                                if (success) {
                                  Get.back();
                                  Get.snackbar(
                                    'Guest Assigned',
                                    '${guest.name} (${guest.partySize} seats) seated at ${table.name}',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        theme.colorScheme.primary,
                                    colorText: Colors.white,
                                    margin: const EdgeInsets.all(16),
                                    duration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: canFit
                                ? customColors.roleSwitchBackground
                                : customColors.roleSwitchBackground.withValues(
                                    alpha: 0.4,
                                  ),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: customColors.inputBorder.withValues(
                                alpha: canFit ? 0.7 : 0.3,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: canFit
                                      ? const Color(0xFFEADBFA)
                                      : customColors.inputBorder,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  initial,
                                  style: GoogleFonts.poppins(
                                    color: canFit
                                        ? const Color(0xFF561A83)
                                        : customColors.textMuted,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      guest.name,
                                      style: GoogleFonts.poppins(
                                        color: canFit
                                            ? theme.colorScheme.onSurface
                                            : customColors.textMuted,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      guest.partySize == 1
                                          ? 'Party of 1 (1 seat)'
                                          : 'Party of ${guest.partySize} (${guest.partySize} seats)',
                                      style: GoogleFonts.poppins(
                                        color: customColors.textMuted,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (canFit) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Seat',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFDE5E5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Needs ${guest.partySize} seats',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF9E2A2B),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static void showDeleteConfirmation(
    BuildContext context,
    GuestBookController controller,
    SeatingTable table,
  ) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    Get.dialog(
      AlertDialog(
        backgroundColor: customColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Delete ${table.name}?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: theme.colorScheme.onSurface,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this table? Any guests currently seated at this table will become unseated.',
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            color: customColors.textMuted,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: customColors.textMuted,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteTable(table.id);
              Get.back();
              Get.snackbar(
                'Table Deleted',
                '${table.name} has been removed.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: theme.colorScheme.primary,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9E2A2B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
