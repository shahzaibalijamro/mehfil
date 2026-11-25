import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum GuestRsvpStatus { pending, going, declined }

class GuestInvitationItem {
  final String id;
  final String title;
  final String hostName;
  final String venue;
  final String day;
  final String month;
  final String fullDate;
  final String timings;
  final Color bannerColor;
  final Color dateTextColor;
  final GuestRsvpStatus rsvpStatus;

  const GuestInvitationItem({
    required this.id,
    required this.title,
    required this.hostName,
    required this.venue,
    required this.day,
    required this.month,
    required this.fullDate,
    required this.timings,
    required this.bannerColor,
    required this.dateTextColor,
    this.rsvpStatus = GuestRsvpStatus.pending,
  });

  GuestInvitationItem copyWith({GuestRsvpStatus? rsvpStatus}) {
    return GuestInvitationItem(
      id: id,
      title: title,
      hostName: hostName,
      venue: venue,
      day: day,
      month: month,
      fullDate: fullDate,
      timings: timings,
      bannerColor: bannerColor,
      dateTextColor: dateTextColor,
      rsvpStatus: rsvpStatus ?? this.rsvpStatus,
    );
  }
}

class GuestHomeController extends GetxController {
  final RxString guestName = '[Guest name]'.obs;

  final RxList<GuestInvitationItem> invitations = <GuestInvitationItem>[
    const GuestInvitationItem(
      id: 'inv-1',
      title: 'Wedding',
      hostName: '[Host name]',
      venue: '[Venue]',
      day: '12',
      month: 'DEC',
      fullDate: '12 December 2026',
      timings: '7:00 PM – 11:30 PM',
      bannerColor: Color(0xFFEBD9FA),
      dateTextColor: Color(0xFF561A83),
    ),
    const GuestInvitationItem(
      id: 'inv-2',
      title: 'Birthday',
      hostName: '[Host name]',
      venue: '[Venue]',
      day: '03',
      month: 'JAN',
      fullDate: '03 January 2027',
      timings: '6:00 PM – 10:00 PM',
      bannerColor: Color(0xFFFAEBBE),
      dateTextColor: Color(0xFF561A83),
    ),
  ].obs;

  GuestInvitationItem? getById(String id) =>
      invitations.firstWhereOrNull((item) => item.id == id);

  void updateRsvp(String id, GuestRsvpStatus status) {
    final index = invitations.indexWhere((item) => item.id == id);
    if (index != -1) {
      invitations[index] = invitations[index].copyWith(rsvpStatus: status);
      invitations.refresh();
    }
  }
}
