import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/guest_home_controller.dart';
import '../../../controllers/main_controller.dart';
import '../../../theme/app_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../../host/events/widgets/countdown_timer_row.dart';
import '../../host/events/widgets/event_segmented_tabs.dart';
import '../../host/events/widgets/timeline_card.dart';
import '../widgets/guest_header.dart';

class GuestEventDetailView extends StatefulWidget {
  const GuestEventDetailView({super.key});

  @override
  State<GuestEventDetailView> createState() => _GuestEventDetailViewState();
}

class _GuestEventDetailViewState extends State<GuestEventDetailView> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final controller = Get.isRegistered<GuestHomeController>()
        ? Get.find<GuestHomeController>()
        : Get.put(GuestHomeController());

    final arg = Get.arguments;
    final String? argId = arg is GuestInvitationItem ? arg.id : null;

    return Obx(() {
      final GuestInvitationItem event =
          (argId != null ? controller.getById(argId) : null) ??
          (arg is GuestInvitationItem
              ? arg
              : controller.invitations.first);

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuestHeader(
                badgeText: 'GUEST PANEL',
                subtitle: 'Hosted by ${event.hostName}',
                title: event.title,
                showBackButton: true,
                extraContent: const CountdownTimerRow(
                  days: '24',
                  hours: '06',
                  minutes: '41',
                  seconds: '09',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Read-only Date & Timings row
                    Row(
                      children: [
                        Expanded(
                          child: _ReadOnlyInfoTile(
                            label: 'Event date',
                            value: event.fullDate,
                            icon: Icons.calendar_today_rounded,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ReadOnlyInfoTile(
                            label: 'Timings',
                            value: event.timings,
                            icon: Icons.access_time_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Read-only Venue card
                    _ReadOnlyInfoTile(
                      label: 'Venue',
                      value: event.venue,
                      icon: Icons.place_outlined,
                    ),
                    const SizedBox(height: 22),

                    // Segmented Tabs: Timeline | Photos | Venue
                    EventSegmentedTabs(
                      selectedIndex: _selectedTabIndex,
                      onTabSelected: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Tab Content Card
                    TimelineCard(activeTab: _selectedTabIndex),
                    const SizedBox(height: 22),

                    // RSVP Status Selector
                    Text(
                      'Your RSVP',
                      style: GoogleFonts.poppins(
                        color: theme.colorScheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _RsvpOptionButton(
                            label: 'Going',
                            isSelected:
                                event.rsvpStatus == GuestRsvpStatus.going,
                            activeColor: theme.colorScheme.primary,
                            onTap: () {
                              controller.updateRsvp(
                                event.id,
                                GuestRsvpStatus.going,
                              );
                              Get.snackbar(
                                'RSVP Updated',
                                'You marked yourself as Going to ${event.title}.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: theme.colorScheme.primary,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 2),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _RsvpOptionButton(
                            label: 'Can\'t make it',
                            isSelected:
                                event.rsvpStatus == GuestRsvpStatus.declined,
                            activeColor: customColors.textMuted,
                            onTap: () {
                              controller.updateRsvp(
                                event.id,
                                GuestRsvpStatus.declined,
                              );
                              Get.snackbar(
                                'RSVP Updated',
                                'You declined the ${event.title} invitation.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: theme.colorScheme.secondary,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 2),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Open Gift Registry action
                    CustomButton(
                      text: 'Open gift registry',
                      isOutlined: true,
                      onPressed: () {
                        if (Get.isRegistered<MainController>()) {
                          Get.find<MainController>().switchScreens(1);
                        }
                        Get.back();
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
    });
  }
}

class _ReadOnlyInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ReadOnlyInfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: customColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: customColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: customColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: theme.colorScheme.onSurface,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _RsvpOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const _RsvpOptionButton({
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = context.customColors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : customColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : customColors.inputBorder,
            width: 1.3,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : customColors.textMuted,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
