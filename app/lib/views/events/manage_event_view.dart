import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../auth/widgets/custom_button.dart';
import 'widgets/countdown_timer_row.dart';
import 'widgets/event_header.dart';
import 'widgets/event_input_field.dart';
import 'widgets/event_segmented_tabs.dart';
import 'widgets/timeline_card.dart';

class ManageEventView extends StatefulWidget {
  const ManageEventView({super.key});

  @override
  State<ManageEventView> createState() => _ManageEventViewState();
}

class _ManageEventViewState extends State<ManageEventView> {
  final _eventDateController = TextEditingController();
  final _timingsController = TextEditingController();
  final _locationController = TextEditingController();
  final _guestsController = TextEditingController();
  final _tablesController = TextEditingController();

  int _selectedTabIndex = 0;

  @override
  void dispose() {
    _eventDateController.dispose();
    _timingsController.dispose();
    _locationController.dispose();
    _guestsController.dispose();
    _tablesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Curved Header with Countdown Timer
            const EventHeader(
              badgeText: 'HOST PANEL',
              subtitle: '[Event name]',
              title: 'Manage event',
              extraContent: CountdownTimerRow(
                days: '24',
                hours: '06',
                minutes: '41',
                seconds: '09',
              ),
            ),

            // Form & Management Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event date and Timings Row (2 columns)
                  Row(
                    children: [
                      Expanded(
                        child: EventInputField(
                          label: 'Event date',
                          controller: _eventDateController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EventInputField(
                          label: 'Timings',
                          controller: _timingsController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Location (Full width)
                  EventInputField(
                    label: 'Location',
                    controller: _locationController,
                  ),
                  const SizedBox(height: 16),

                  // Guests and Tables Row (2 columns)
                  Row(
                    children: [
                      Expanded(
                        child: EventInputField(
                          label: 'Guests',
                          controller: _guestsController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EventInputField(
                          label: 'Tables',
                          controller: _tablesController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
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

                  // Tab Content Card (Activities timeline with purple bullets)
                  TimelineCard(activeTab: _selectedTabIndex),
                  const SizedBox(height: 24),

                  // Save changes button
                  CustomButton(
                    text: 'Save changes',
                    onPressed: () {
                      Get.snackbar(
                        'Changes Saved',
                        'Event details have been updated successfully!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: theme.colorScheme.primary,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                        duration: const Duration(seconds: 2),
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
