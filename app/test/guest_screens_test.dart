import 'package:app/constants/app_pages.dart';
import 'package:app/controllers/guest_home_controller.dart';
import 'package:app/controllers/guest_registry_controller.dart';
import 'package:app/controllers/theme_controller.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/views/guest/home/home_screen.dart';
import 'package:app/views/guest/registry/registry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Widget _wrapWithGetMaterialApp(Widget child) {
  return GetMaterialApp(
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    getPages: AppPages.routes,
    home: child,
  );
}

void main() {
  setUp(() {
    Get.testMode = true;
    Get.put(ThemeController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('GuestHomeScreen renders invitations and opens GuestEventDetailView',
      (tester) async {
    await tester.pumpWidget(_wrapWithGetMaterialApp(const GuestHomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('GUEST PANEL'), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('[Guest name]'), findsOneWidget);
    expect(find.text('Your invitations'), findsOneWidget);
    expect(find.text('Wedding'), findsOneWidget);
    expect(find.text('Birthday'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('DEC'), findsOneWidget);
    expect(find.text('03'), findsOneWidget);
    expect(find.text('JAN'), findsOneWidget);
    expect(find.text('View event'), findsNWidgets(2));

    await tester.tap(find.text('View event').first);
    await tester.pumpAndSettle();

    expect(find.text('Your RSVP'), findsOneWidget);
    expect(find.text('Open gift registry'), findsOneWidget);
    expect(Get.find<GuestHomeController>().invitations.length, 2);
  });

  testWidgets(
      'GuestRegistryScreen filters by Men/Women/Kids and category tabs, and launches URL',
      (tester) async {
    final List<MethodCall> urlLauncherCalls = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/url_launcher'),
      (call) async {
        urlLauncherCalls.add(call);
        if (call.method == 'canLaunch') return true;
        if (call.method == 'launch' || call.method == 'launchUrl') return true;
        return null;
      },
    );

    await tester.pumpWidget(
      _wrapWithGetMaterialApp(const GuestRegistryScreen()),
    );
    await tester.pumpAndSettle();

    // Default: Men + Accessories
    expect(find.text('Gift registry'), findsOneWidget);
    expect(find.text('Leather Cardholder'), findsOneWidget);
    expect(find.text('Silk Tie & Pocket Square'), findsOneWidget);
    expect(find.text('Silk Square Scarf'), findsNothing);

    // Tap Women -> Women's Accessories
    await tester.tap(find.text('Women'));
    await tester.pumpAndSettle();
    expect(find.text('Silk Square Scarf'), findsOneWidget);
    expect(find.text('Quilted Crossbody Clutch'), findsOneWidget);
    expect(find.text('Leather Cardholder'), findsNothing);

    // Tap Watches -> Women's Watches
    await tester.tap(find.text('Watches'));
    await tester.pumpAndSettle();
    expect(find.text('Petite Melrose Watch'), findsOneWidget);
    expect(find.text('Mother of Pearl Dial'), findsOneWidget);

    // Tap Kids -> Kids' Watches
    await tester.tap(find.text('Kids'));
    await tester.pumpAndSettle();
    expect(find.text('Colorblock Analog Watch'), findsOneWidget);
    expect(find.text('Digital Sport Watch'), findsOneWidget);

    // Tap Kids again to toggle off -> All Watches (6 items)
    await tester.tap(find.text('Kids'));
    await tester.pumpAndSettle();
    final registryController = Get.find<GuestRegistryController>();
    expect(registryController.selectedAudience.value, isNull);
    expect(registryController.filteredItems.length, 6);

    // Tap Shop at brand -> triggers url_launcher
    await tester.tap(find.text('Shop at brand').first);
    await tester.pumpAndSettle();
    expect(urlLauncherCalls, isNotEmpty);
  });
}
