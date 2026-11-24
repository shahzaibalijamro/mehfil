import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/host/guest-book/widgets/guest_list_card.dart';

enum GuestFilter { all, accepted, pending, cancelled }

class GuestBookController extends GetxController {
  final Rx<GuestFilter> selectedFilter = GuestFilter.all.obs;

  // Text controllers managed by GetX
  final TextEditingController nameController = TextEditingController();
  final TextEditingController partySizeController =
      TextEditingController(text: '1');

  final RxList<GuestItem> guests = <GuestItem>[
    const GuestItem(
      name: '[Guest name]',
      partySize: 4,
      status: GuestStatus.accepted,
    ),
    const GuestItem(
      name: '[Guest name]',
      partySize: 5,
      status: GuestStatus.pending,
    ),
    const GuestItem(
      name: '[Guest name]',
      partySize: 2,
      status: GuestStatus.cancelled,
    ),
  ].obs;

  // Computed metrics
  int get acceptedCount =>
      guests.where((g) => g.status == GuestStatus.accepted).length;

  int get pendingCount =>
      guests.where((g) => g.status == GuestStatus.pending).length;

  int get cancelledCount =>
      guests.where((g) => g.status == GuestStatus.cancelled).length;

  // Filtered guest list
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
          name: name,
          partySize: party,
          status: GuestStatus.pending,
        ),
      );
      resetInviteForm();
    }
  }

  // GetX automatically calls onClose when the controller is destroyed
  @override
  void onClose() {
    nameController.dispose();
    partySizeController.dispose();
    super.onClose();
  }
}
