import 'package:app/constants/user_roles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:app/views/host/home/home_screen.dart';
import 'package:app/views/host/guest-book/guest_book_screen.dart';
import 'package:app/views/host/invitation/invitation_screen.dart';
import 'package:app/views/host/registry/registry_screen.dart';
import 'package:app/views/host/settings/settings_screen.dart';
import 'package:app/views/guest/home/home_screen.dart';
import 'package:app/views/guest/registry/registry_screen.dart';
import 'package:app/views/guest/settings/settings_screen.dart';

class NavigationTab {
  final Widget screen;
  final BottomNavigationBarItem barItem;

  const NavigationTab({required this.screen, required this.barItem});
}

class MainController extends GetxController {
  final Rx<UserRole> currentRole = UserRole.host.obs;
  final RxInt currentScreenIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is UserRole) {
      setRole(Get.arguments as UserRole);
    }
  }

  void setRole(UserRole role) {
    currentRole.value = role;
    currentScreenIndex.value = 0;
  }

  void switchScreens(int index) => currentScreenIndex.value = index;

  List<NavigationTab> get _hostTabs => [
    NavigationTab(
      screen: HostHomeScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.house),
        label: 'Home',
      ),
    ),
    NavigationTab(
      screen: HostGuestBookScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.users),
        label: 'Guest Book',
      ),
    ),
    NavigationTab(
      screen: HostInvitationScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.envelopeSimple),
        label: 'Invitation',
      ),
    ),
    NavigationTab(
      screen: HostRegistryScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.gift),
        label: 'Registry',
      ),
    ),
    NavigationTab(
      screen: HostSettingsScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.wrench),
        label: 'Settings',
      ),
    ),
  ];

  List<NavigationTab> get _guestTabs => const [
    NavigationTab(
      screen: GuestHomeScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.house),
        label: 'Home',
      ),
    ),
    NavigationTab(
      screen: GuestRegistryScreen(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.gift),
        label: 'Registry',
      ),
    ),
    NavigationTab(
      screen: GuestSettingsPage(),
      barItem: BottomNavigationBarItem(
        icon: Icon(PhosphorIconsBold.wrench),
        label: 'Settings',
      ),
    ),
  ];

  List<NavigationTab> get currentTabs =>
      currentRole.value == UserRole.host ? _hostTabs : _guestTabs;

  List<Widget> get screens => currentTabs.map((t) => t.screen).toList();
  List<BottomNavigationBarItem> get navBarItems =>
      currentTabs.map((t) => t.barItem).toList();
}
