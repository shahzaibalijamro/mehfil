import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../theme/app_theme.dart';
import 'guest_list_card.dart';
import 'seating_models.dart';

class SeatingTableCard extends StatelessWidget {
  final SeatingTable table;
  final int occupiedSeats;
  final List<GuestItem> assignedGuests;
  final VoidCallback onAssignGuest;
  final ValueChanged<GuestItem> onUnassignGuest;
  final VoidCallback onEditTable;
  final VoidCallback onDeleteTable;

  const SeatingTableCard({
    super.key,
    required this.table,
    required this.occupiedSeats,
    required this.assignedGuests,
    required this.onAssignGuest,
    required this.onUnassignGuest,
    required this.onEditTable,
    required this.onDeleteTable,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final availableSeats = (table.seatCapacity - occupiedSeats).clamp(0, 999);
    final isFull = availableSeats == 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: customColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Table Shape Badge + Name + Status Pill + More Menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Shape indicator badge
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE4F7),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(
                  table.shape == TableShape.round
                      ? Icons.circle_outlined
                      : Icons.crop_square_rounded,
                  color: const Color(0xFF561A83),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Table Name & Shape Label
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      table.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${table.shape.label} Table • ${table.seatCapacity} seats',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: customColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Capacity status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isFull
                      ? const Color(0xFFFDE5E5)
                      : const Color(0xFFE2F5EA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isFull ? 'Full' : '$availableSeats open',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: isFull
                        ? const Color(0xFF9E2A2B)
                        : const Color(0xFF1E5B35),
                  ),
                ),
              ),
              const SizedBox(width: 4),

              // Menu Options: Edit / Delete
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: customColors.textMuted,
                  size: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: customColors.cardBackground,
                onSelected: (action) {
                  if (action == 'edit') onEditTable();
                  if (action == 'delete') onDeleteTable();
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Edit Table',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                          color: Color(0xFF9E2A2B),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Delete Table',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF9E2A2B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 2. Visual Seat Indicators & Occupancy Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seats Filled',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: customColors.textMuted,
                ),
              ),
              Text(
                '$occupiedSeats / ${table.seatCapacity}',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Visual seat dots
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(table.seatCapacity, (index) {
              final isOccupied = index < occupiedSeats;
              return Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: table.shape == TableShape.round
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  borderRadius: table.shape == TableShape.round
                      ? null
                      : BorderRadius.circular(4),
                  color: isOccupied
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  border: Border.all(
                    color: isOccupied
                        ? theme.colorScheme.primary
                        : customColors.inputBorder,
                    width: 1.6,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),

          // 3. Assigned Guests Chips
          if (assignedGuests.isNotEmpty) ...[
            Text(
              'Seated Guests',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: customColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: assignedGuests.map((guest) {
                final initial = guest.name.trim().isNotEmpty
                    ? guest.name.trim()[0].toUpperCase()
                    : 'G';

                return Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 6,
                    bottom: 6,
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    color: customColors.roleSwitchBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: customColors.inputBorder.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEADBFA),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          initial,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF561A83),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            guest.name,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            guest.partySize == 1
                                ? '1 seat'
                                : '${guest.partySize} seats',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: customColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () => onUnassignGuest(guest),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.close_rounded,
                            size: 15,
                            color: customColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
          ] else ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: customColors.roleSwitchBackground.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: customColors.inputBorder.withValues(alpha: 0.5),
                  style: BorderStyle.solid,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'No guests assigned yet',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: customColors.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],

          // 4. Action Button: Assign Guest (or Full indicator)
          SizedBox(
            width: double.infinity,
            height: 42,
            child: isFull
                ? Container(
                    decoration: BoxDecoration(
                      color: customColors.roleSwitchBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Table is completely full',
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: customColors.textMuted,
                      ),
                    ),
                  )
                : OutlinedButton.icon(
                    onPressed: onAssignGuest,
                    icon: Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text(
                      'Assign Guest ($availableSeats open)',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(
                        color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
