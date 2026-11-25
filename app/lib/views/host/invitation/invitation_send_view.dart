import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/app_endpoints.dart';
import '../../auth/widgets/custom_button.dart';
import '../widgets/host_header.dart';
import 'widgets/invitation_card.dart';

class InvitationSendView extends StatefulWidget {
  const InvitationSendView({super.key});

  @override
  State<InvitationSendView> createState() => _InvitationSendViewState();
}

class _InvitationSendViewState extends State<InvitationSendView> {
  // card ki picture leta hy
  final GlobalKey _cardKey = GlobalKey();

  Future<void> _shareCard() async {
    try {
      final boundary =
          _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) return;

      await Share.shareXFiles(
        [
          XFile.fromData(
            data.buffer.asUint8List(),
            mimeType: 'image/png',
            name: 'invitation.png',
          ),
        ],
        fileNameOverrides: ['invitation.png'],
        text: 'You are invited!',
      );
    } catch (e) {
      Get.snackbar(
        'Could not share',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
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
              title: 'Send invitation',
              showBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: _cardKey,
                    child: const LiveInvitationCard(),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: 'Share invitation', onPressed: _shareCard),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Edit again',
                    isOutlined: true,
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Back to templates',
                    isOutlined: true,
                    onPressed: () => Get.until(
                      (route) => route.settings.name == AppEndpoints.mainScreen,
                    ),
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
