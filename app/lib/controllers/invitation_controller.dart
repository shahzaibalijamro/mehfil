import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitationTemplate {
  final String name;
  final String category;
  final Color color;

  const InvitationTemplate({
    required this.name,
    required this.category,
    required this.color,
  });
}

class InvitationController extends GetxController {
  final List<String> categories = [
    'Wedding',
    'Birthday',
    'Baby shower',
    'Ceremony',
    'Anniversary',
  ];

  // category -> [intro line, name 1, name 2]
  final Map<String, List<String>> defaults = {
    'Wedding': ['Together with their families', '[Bride]', '[Groom]'],
    'Birthday': ['You are invited to celebrate', '[Name]', ''],
    'Baby shower': ['Join us to welcome', '[Baby name]', ''],
    'Ceremony': ['You are cordially invited to', '[Ceremony name]', ''],
    'Anniversary': ['Celebrating the anniversary of', '[Name 1]', '[Name 2]'],
  };

  final List<InvitationTemplate> templates = const [
    InvitationTemplate(
      name: 'Elegant Minimalism',
      category: 'Wedding',
      color: Color(0xFFFBF6EE),
    ),
    InvitationTemplate(
      name: 'Blush Romance',
      category: 'Wedding',
      color: Color(0xFFFBE4EC),
    ),
    InvitationTemplate(
      name: 'Golden Glow',
      category: 'Birthday',
      color: Color(0xFFFFF1B8),
    ),
    InvitationTemplate(
      name: 'Sky Party',
      category: 'Birthday',
      color: Color(0xFFE3EEFB),
    ),
    InvitationTemplate(
      name: 'Fresh Mint',
      category: 'Baby shower',
      color: Color(0xFFDDF3E4),
    ),
    InvitationTemplate(
      name: 'Soft Blush',
      category: 'Baby shower',
      color: Color(0xFFFBE4EC),
    ),
    InvitationTemplate(
      name: 'Classic Cream',
      category: 'Ceremony',
      color: Color(0xFFFBF6EE),
    ),
    InvitationTemplate(
      name: 'Calm Sky',
      category: 'Ceremony',
      color: Color(0xFFE3EEFB),
    ),
    InvitationTemplate(
      name: 'Golden Years',
      category: 'Anniversary',
      color: Color(0xFFFFF1B8),
    ),
    InvitationTemplate(
      name: 'Rose Evening',
      category: 'Anniversary',
      color: Color(0xFFFBE4EC),
    ),
  ];

  final List<Color> backgroundOptions = const [
    Color(0xFFFBF6EE),
    Color(0xFFFFF1B8),
    Color(0xFFDDF3E4),
    Color(0xFFFBE4EC),
    Color(0xFFE3EEFB),
  ];

  final List<Color> textColorOptions = const [
    Color(0xFF2D0F4E),
    Color(0xFF201C26),
    Color(0xFFC9A24B),
    Color(0xFF7A1F47),
    Color(0xFF17407A),
    Color(0xFF1E5B35),
    Color(0xFFFFFFFF),
  ];

  final List<String> fonts = [
    'Great Vibes',
    'Playfair Display',
    'Poppins',
    'Roboto Mono',
  ];

  final RxString selectedCategory = 'Wedding'.obs;

  List<InvitationTemplate> get filteredTemplates =>
      templates.where((t) => t.category == selectedCategory.value).toList();

  final Rxn<InvitationTemplate> selectedTemplate = Rxn<InvitationTemplate>();
  final Rx<Color> bgColor = const Color(0xFFFBF6EE).obs;
  final Rx<Color> textColor = const Color(0xFF2D0F4E).obs;
  final RxString fontFamily = 'Great Vibes'.obs;
  final RxString intro = ''.obs;
  final RxString name1 = ''.obs;
  final RxString name2 = ''.obs;
  final RxString dateTime = '[Date] · [Time]'.obs;
  final RxString venue = '[Venue]'.obs;
  final RxBool showDetails = true.obs;

  @override
  void onInit() {
    super.onInit();
    selectTemplate(templates.first);
  }

  void setCategory(String category) => selectedCategory.value = category;

  void selectTemplate(InvitationTemplate t) {
    final d = defaults[t.category]!;
    selectedTemplate.value = t;
    bgColor.value = t.color;
    textColor.value = const Color(0xFF2D0F4E);
    fontFamily.value = 'Great Vibes';
    intro.value = d[0];
    name1.value = d[1];
    name2.value = d[2];
    dateTime.value = '[Date] · [Time]';
    venue.value = '[Venue]';
    showDetails.value = true;
  }
}
