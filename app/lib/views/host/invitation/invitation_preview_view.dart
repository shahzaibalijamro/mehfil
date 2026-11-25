import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_endpoints.dart';
import '../../../controllers/invitation_controller.dart';
import '../../auth/widgets/custom_button.dart';
import '../widgets/host_header.dart';
import 'widgets/invitation_card.dart';

class InvitationPreviewView extends StatelessWidget {
  const InvitationPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<InvitationController>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HostHeader(
              badgeText: 'HOST PANEL',
              title: 'Preview',
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
              child: Column(
                children: [
                  const LiveInvitationCard(),
                  const SizedBox(height: 16),
                  Obx(
                    () => Text(
                      controller.selectedTemplate.value?.name ?? '',
                      style: GoogleFonts.poppins(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Use this template',
                    onPressed: () => Get.toNamed(AppEndpoints.invitationEditor),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Choose another',
                    isOutlined: true,
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
