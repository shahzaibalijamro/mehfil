import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/invitation_controller.dart';
import '../../auth/widgets/custom_button.dart';
import '../../auth/widgets/custom_text_field.dart';
import '../widgets/host_header.dart';
import 'widgets/invitation_card.dart';

class InvitationEditTextView extends StatefulWidget {
  const InvitationEditTextView({super.key});

  @override
  State<InvitationEditTextView> createState() => _InvitationEditTextViewState();
}

class _InvitationEditTextViewState extends State<InvitationEditTextView> {
  final controller = Get.find<InvitationController>();

  late final _introController = TextEditingController(
    text: controller.intro.value,
  );
  late final _name1Controller = TextEditingController(
    text: controller.name1.value,
  );
  late final _name2Controller = TextEditingController(
    text: controller.name2.value,
  );
  late final _dateTimeController = TextEditingController(
    text: controller.dateTime.value,
  );
  late final _venueController = TextEditingController(
    text: controller.venue.value,
  );

  @override
  void initState() {
    super.initState();
    // Whatever the host types shows on the card straight away
    _introController.addListener(
      () => controller.intro.value = _introController.text,
    );
    _name1Controller.addListener(
      () => controller.name1.value = _name1Controller.text,
    );
    _name2Controller.addListener(
      () => controller.name2.value = _name2Controller.text,
    );
    _dateTimeController.addListener(
      () => controller.dateTime.value = _dateTimeController.text,
    );
    _venueController.addListener(
      () => controller.venue.value = _venueController.text,
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _name1Controller.dispose();
    _name2Controller.dispose();
    _dateTimeController.dispose();
    _venueController.dispose();
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
          children: [
            HostHeader(
              badgeText: 'HOST PANEL',
              title: 'Edit text',
              showBackButton: true,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    width: 200,
                    child: LiveInvitationCard(small: true),
                  ),
                  const SizedBox(height: 22),
                  CustomTextField(
                    label: 'Intro line',
                    hint: 'Together with their families',
                    controller: _introController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Name',
                    hint: 'Main name',
                    controller: _name1Controller,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Second name (optional)',
                    hint: 'Leave empty to hide',
                    controller: _name2Controller,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Date & time',
                    hint: '12 Dec 2026 · 7:00 PM',
                    controller: _dateTimeController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Venue',
                    hint: 'Venue name and city',
                    controller: _venueController,
                  ),
                  const SizedBox(height: 22),
                  CustomButton(text: 'Done', onPressed: () => Get.back()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
