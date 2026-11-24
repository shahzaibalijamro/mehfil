import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_endpoints.dart';
import '../../../theme/app_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../widgets/host_header.dart';
import 'widgets/host_event_card.dart';

class HostHomeScreen extends StatelessWidget {
  HostHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    // Sample events matching the design image
    final List<HostEventItem> events = [
      HostEventItem(
        title: 'Wedding',
        venue: '[Venue]',
        day: '12',
        month: 'DEC',
        badgeBackgroundColor: const Color(0xFFEDE4F7), // Soft purple
        badgeTextColor: const Color(0xFF561A83),
        onManage: () => Get.toNamed(AppEndpoints.manageEvent),
      ),
      HostEventItem(
        title: 'Birthday',
        venue: '[Venue]',
        day: '03',
        month: 'JAN',
        badgeBackgroundColor: const Color(0xFFFBEFD6), // Soft warm peach
        badgeTextColor: const Color(0xFF561A83),
        onManage: () => Get.toNamed(AppEndpoints.manageEvent),
      ),
      HostEventItem(
        title: 'Baby shower',
        venue: '[Venue]',
        day: '20',
        month: 'FEB',
        badgeBackgroundColor: const Color(0xFFE0F4E8), // Soft mint green
        badgeTextColor: const Color(0xFF386641),
        onManage: () => Get.toNamed(AppEndpoints.manageEvent),
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unified Reusable Host Header
            HostHeader(
              badgeText: 'HOST PANEL',
              subtitle: 'Welcome back',
              title: '[Host name]',
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: "Your events" & "3 upcoming"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your events',
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${events.length} upcoming',
                        style: GoogleFonts.poppins(
                          color: customColors.textMuted,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Event Cards List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: events.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return HostEventCard(event: events[index]);
                    },
                  ),
                  const SizedBox(height: 22),

                  // "+ Add new event" Button
                  CustomButton(
                    text: '+ Add new event',
                    onPressed: () {
                      Get.toNamed(AppEndpoints.createEvent);
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
