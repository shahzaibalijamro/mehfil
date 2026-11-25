import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/host/guest-book/widgets/guest_list_card.dart';
import '../views/host/guest-book/widgets/seating_models.dart';

enum GuestFilter { all, accepted, pending, cancelled }

enum GuestBookTab { guestList, seating }

class GuestBookController extends GetxController {
  // Navigation tab (Guest List vs Seating)
  final Rx<GuestBookTab> selectedTab = GuestBookTab.guestList.obs;

  // Guest list filters
  final Rx<GuestFilter> selectedFilter = GuestFilter.all.obs;

  // Text controllers for inviting a guest
  final TextEditingController nameController = TextEditingController();
  final TextEditingController partySizeController =
      TextEditingController(text: '1');

  // Text & selection controllers for Adding/Editing a table
  final TextEditingController tableNameController = TextEditingController();
  final TextEditingController seatCapacityController =
      TextEditingController(text: '8');
  final Rx<TableShape> selectedTableShape = TableShape.round.obs;

  // Text & selection controllers for Batch Table Setup
  final TextEditingController batchTableCountController =
      TextEditingController(text: '4');
  final TextEditingController batchCapacityController =
      TextEditingController(text: '8');
  final Rx<TableShape> batchTableShape = TableShape.round.obs;

  // Reactive guests list with realistic initial seed
  final RxList<GuestItem> guests = <GuestItem>[
    const GuestItem(
      id: 'g-1',
      name: 'Sarah Jenkins',
      partySize: 4,
      status: GuestStatus.accepted,
    ),
    const GuestItem(
      id: 'g-2',
      name: 'Michael Chang',
      partySize: 2,
      status: GuestStatus.accepted,
    ),
    const GuestItem(
      id: 'g-3',
      name: 'Emma Watson',
      partySize: 3,
      status: GuestStatus.accepted,
    ),
    const GuestItem(
      id: 'g-4',
      name: 'Tariq Mahmood',
      partySize: 2,
      status: GuestStatus.accepted,
    ),
    const GuestItem(
      id: 'g-5',
      name: 'Robert Fox',
      partySize: 5,
      status: GuestStatus.pending,
    ),
    const GuestItem(
      id: 'g-6',
      name: 'Sophia Miller',
      partySize: 2,
      status: GuestStatus.cancelled,
    ),
  ].obs;

  // Reactive seating tables list with realistic initial seed
  final RxList<SeatingTable> tables = <SeatingTable>[
    SeatingTable(
      id: 't-1',
      name: 'Table 1 - VIP',
      shape: TableShape.round,
      seatCapacity: 8,
      assignedGuestIds: ['g-1'], // Sarah Jenkins (4 seats occupied)
    ),
    SeatingTable(
      id: 't-2',
      name: 'Table 2 - Family',
      shape: TableShape.rectangular,
      seatCapacity: 6,
      assignedGuestIds: ['g-2'], // Michael Chang (2 seats occupied)
    ),
    SeatingTable(
      id: 't-3',
      name: 'Table 3',
      shape: TableShape.round,
      seatCapacity: 8,
      assignedGuestIds: [], // Empty table
    ),
  ].obs;

  // --- Computed Metrics for Guest List ---
  int get acceptedCount =>
      guests.where((g) => g.status == GuestStatus.accepted).length;

  int get pendingCount =>
      guests.where((g) => g.status == GuestStatus.pending).length;

  int get cancelledCount =>
      guests.where((g) => g.status == GuestStatus.cancelled).length;

  List<GuestItem> get filteredGuests {
    switch (selectedFilter.value) {
      case GuestFilter.accepted:
        return guests.where((g) => g.status == GuestStatus.accepted).toList();
      case GuestFilter.pending:
        return guests.where((g) => g.status == GuestStatus.pending).toList();
      case GuestFilter.cancelled:
        return guests.where((g) => g.status == GuestStatus.cancelled).toList();
      case GuestFilter.all:
      default:
        return guests.toList();
    }
  }

  // --- Computed Metrics for Seating ---
  int get totalTables => tables.length;

  int get totalCapacity => tables.fold(0, (sum, t) => sum + t.seatCapacity);

  int get totalOccupiedSeats =>
      tables.fold(0, (sum, t) => sum + getTableOccupiedSeats(t));

  int getTableOccupiedSeats(SeatingTable table) {
    int total = 0;
    for (final guestId in table.assignedGuestIds) {
      final guest = guests.firstWhereOrNull((g) => g.id == guestId);
      if (guest != null) {
        total += guest.partySize;
      }
    }
    return total;
  }

  int getTableAvailableSeats(SeatingTable table) {
    return (table.seatCapacity - getTableOccupiedSeats(table)).clamp(0, 999);
  }

  List<GuestItem> getGuestsForTable(SeatingTable table) {
    final List<GuestItem> list = [];
    for (final guestId in table.assignedGuestIds) {
      final guest = guests.firstWhereOrNull((g) => g.id == guestId);
      if (guest != null) {
        list.add(guest);
      }
    }
    return list;
  }

  List<GuestItem> get unseatedAcceptedGuests {
    final assignedIds = <String>{};
    for (final table in tables) {
      assignedIds.addAll(table.assignedGuestIds);
    }
    return guests
        .where(
          (g) =>
              g.status == GuestStatus.accepted && !assignedIds.contains(g.id),
        )
        .toList();
  }

  int get unseatedAcceptedGuestsCount => unseatedAcceptedGuests.length;

  bool canGuestFit(SeatingTable table, GuestItem guest) {
    return getTableAvailableSeats(table) >= guest.partySize;
  }

  // --- Action Methods ---
  void setTab(GuestBookTab tab) {
    selectedTab.value = tab;
  }

  void setFilter(GuestFilter filter) {
    selectedFilter.value = filter;
  }

  void resetInviteForm() {
    nameController.clear();
    partySizeController.text = '1';
  }

  void addGuestFromForm() {
    final name = nameController.text.trim();
    final party = int.tryParse(partySizeController.text.trim()) ?? 1;

    if (name.isNotEmpty) {
      guests.insert(
        0,
        GuestItem(
          id: 'g-${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          partySize: party,
          status: GuestStatus.pending,
        ),
      );
      resetInviteForm();
    }
  }

  void resetTableForm([SeatingTable? existing]) {
    if (existing != null) {
      tableNameController.text = existing.name;
      seatCapacityController.text = existing.seatCapacity.toString();
      selectedTableShape.value = existing.shape;
    } else {
      final nextNumber = tables.length + 1;
      tableNameController.text = 'Table $nextNumber';
      seatCapacityController.text = '8';
      selectedTableShape.value = TableShape.round;
    }
  }

  void resetBatchForm() {
    batchTableCountController.text = '4';
    batchCapacityController.text = '8';
    batchTableShape.value = TableShape.round;
  }

  void addTable({
    required String name,
    required int capacity,
    required TableShape shape,
  }) {
    final table = SeatingTable(
      id: 't-${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim().isEmpty ? 'Table ${tables.length + 1}' : name.trim(),
      seatCapacity: capacity > 0 ? capacity : 8,
      shape: shape,
    );
    tables.add(table);
  }

  void updateTable(
    String tableId, {
    required String name,
    required int capacity,
    required TableShape shape,
  }) {
    final index = tables.indexWhere((t) => t.id == tableId);
    if (index != -1) {
      final old = tables[index];
      tables[index] = old.copyWith(
        name: name.trim().isEmpty ? old.name : name.trim(),
        seatCapacity: capacity > 0 ? capacity : old.seatCapacity,
        shape: shape,
      );
      tables.refresh();
    }
  }

  void deleteTable(String tableId) {
    tables.removeWhere((t) => t.id == tableId);
  }

  void batchAddTables({
    required int count,
    required int capacity,
    required TableShape shape,
  }) {
    final startNum = tables.length + 1;
    final int safeCount = count.clamp(1, 30);
    final int safeCapacity = capacity.clamp(2, 20);

    for (int i = 0; i < safeCount; i++) {
      final num = startNum + i;
      tables.add(
        SeatingTable(
          id: 't-${DateTime.now().millisecondsSinceEpoch}-$i',
          name: 'Table $num',
          shape: shape,
          seatCapacity: safeCapacity,
        ),
      );
    }
  }

  bool assignGuestToTable(String tableId, String guestId) {
    final tableIndex = tables.indexWhere((t) => t.id == tableId);
    if (tableIndex == -1) return false;

    final table = tables[tableIndex];
    final guest = guests.firstWhereOrNull((g) => g.id == guestId);
    if (guest == null) return false;

    if (!canGuestFit(table, guest)) {
      return false;
    }

    if (!table.assignedGuestIds.contains(guestId)) {
      table.assignedGuestIds.add(guestId);
      tables.refresh();
      return true;
    }
    return false;
  }

  void unassignGuestFromTable(String tableId, String guestId) {
    final tableIndex = tables.indexWhere((t) => t.id == tableId);
    if (tableIndex != -1) {
      tables[tableIndex].assignedGuestIds.remove(guestId);
      tables.refresh();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    partySizeController.dispose();
    tableNameController.dispose();
    seatCapacityController.dispose();
    batchTableCountController.dispose();
    batchCapacityController.dispose();
    super.onClose();
  }
}
