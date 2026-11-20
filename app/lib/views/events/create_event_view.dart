import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_endpoints.dart';
import '../../theme/app_theme.dart';
import '../auth/widgets/custom_button.dart';
import 'widgets/event_header.dart';
import 'widgets/event_input_field.dart';
import 'widgets/map_pin_card.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _hostNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _totalGuestsController = TextEditingController();
  final _guestsPerTableController = TextEditingController();

  String _selectedFunctionType = 'Wedding';
  final List<String> _functionTypes = [
    'Wedding',
    'Birthday',
    'Corporate Event',
    'Engagement',
    'Anniversary',
    'Other',
  ];

  @override
  void dispose() {
    _hostNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _totalGuestsController.dispose();
    _guestsPerTableController.dispose();
    super.dispose();
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
            // Top Curved Header
            const EventHeader(
              badgeText: 'HOST PANEL',
              title: 'Create new event',
            ),

            // Form Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Host full name
                  EventInputField(
                    label: 'Host full name',
                    controller: _hostNameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),

                  // Email address
                  EventInputField(
                    label: 'Email address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Phone number
                  EventInputField(
                    label: 'Phone number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Day, Month, Year Row (3 columns)
                  Row(
                    children: [
                      Expanded(
                        child: EventInputField(
                          label: 'Day',
                          controller: _dayController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EventInputField(
                          label: 'Month',
                          controller: _monthController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EventInputField(
                          label: 'Year',
                          controller: _yearController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Total guests, Guests per table Row (2 columns)
                  Row(
                    children: [
                      Expanded(
                        child: EventInputField(
                          label: 'Total guests',
                          controller: _totalGuestsController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EventInputField(
                          label: 'Guests per table',
                          controller: _guestsPerTableController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Function type dropdown
                  Text(
                    'Function type',
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: customColors.inputFill,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: customColors.inputBorder,
                        width: 1.2,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFunctionType,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: theme.colorScheme.onSurface,
                          size: 24,
                        ),
                        isExpanded: true,
                        dropdownColor: customColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                        ),
                        items: _functionTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedFunctionType = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pin live location on Google Map card
                  MapPinCard(
                    onTap: () {
                      Get.snackbar(
                        'Location Pinned',
                        'Live location pinned successfully on Google Map!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFF285E34),
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                        duration: const Duration(seconds: 2),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Create event button
                  CustomButton(
                    text: 'Create event',
                    onPressed: () {
                      Get.snackbar(
                        'Event Created',
                        'Event details saved successfully!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: theme.colorScheme.primary,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                        duration: const Duration(seconds: 2),
                      );
                      Future.delayed(const Duration(milliseconds: 700), () {
                        Get.toNamed(AppEndpoints.manageEvent);
                      });
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
