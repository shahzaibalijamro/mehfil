import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

enum RegistryAudience {
  men('Men'),
  women('Women'),
  kids('Kids');

  final String label;
  const RegistryAudience(this.label);
}

enum RegistryCategory {
  accessories('Accessories'),
  watches('Watches'),
  rings('Rings'),
  shoes('Shoes');

  final String label;
  const RegistryCategory(this.label);
}

class RegistryGiftItem {
  final String id;
  final String name;
  final String brand;
  final RegistryAudience audience;
  final RegistryCategory category;
  final String productUrl;
  final IconData icon;

  const RegistryGiftItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.audience,
    required this.category,
    required this.productUrl,
    required this.icon,
  });
}

class GuestRegistryController extends GetxController {
  final Rxn<RegistryAudience> selectedAudience =
      Rxn<RegistryAudience>(RegistryAudience.men);
  final Rx<RegistryCategory> selectedCategory =
      Rx<RegistryCategory>(RegistryCategory.accessories);

  final List<RegistryGiftItem> items = const [
    // --- MEN ---
    RegistryGiftItem(
      id: 'm-acc-1',
      name: 'Leather Cardholder',
      brand: 'Montblanc',
      audience: RegistryAudience.men,
      category: RegistryCategory.accessories,
      productUrl: 'https://www.montblanc.com/en-us/collection/leather-goods',
      icon: PhosphorIconsBold.wallet,
    ),
    RegistryGiftItem(
      id: 'm-acc-2',
      name: 'Silk Tie & Pocket Square',
      brand: 'Hugo Boss',
      audience: RegistryAudience.men,
      category: RegistryCategory.accessories,
      productUrl: 'https://www.hugoboss.com/men-accessories/',
      icon: PhosphorIconsBold.bag,
    ),
    RegistryGiftItem(
      id: 'm-wat-1',
      name: 'PRX Powermatic 80',
      brand: 'Tissot',
      audience: RegistryAudience.men,
      category: RegistryCategory.watches,
      productUrl: 'https://www.tissotwatches.com/en-us/men.html',
      icon: PhosphorIconsBold.watch,
    ),
    RegistryGiftItem(
      id: 'm-wat-2',
      name: 'Presage Cocktail Time',
      brand: 'Seiko',
      audience: RegistryAudience.men,
      category: RegistryCategory.watches,
      productUrl: 'https://www.seikowatches.com/us-en/products/presage',
      icon: PhosphorIconsBold.watch,
    ),
    RegistryGiftItem(
      id: 'm-rng-1',
      name: 'Sterling Signet Ring',
      brand: 'David Yurman',
      audience: RegistryAudience.men,
      category: RegistryCategory.rings,
      productUrl: 'https://www.davidyurman.com/mens/rings.html',
      icon: PhosphorIconsBold.circle,
    ),
    RegistryGiftItem(
      id: 'm-rng-2',
      name: 'Brushed Titanium Band',
      brand: 'Tiffany & Co.',
      audience: RegistryAudience.men,
      category: RegistryCategory.rings,
      productUrl: 'https://www.tiffany.com/jewelry/shop/mens-rings/',
      icon: PhosphorIconsBold.circle,
    ),
    RegistryGiftItem(
      id: 'm-sho-1',
      name: 'Classic Penny Loafer',
      brand: 'Cole Haan',
      audience: RegistryAudience.men,
      category: RegistryCategory.shoes,
      productUrl: 'https://www.colehaan.com/mens-shoes',
      icon: PhosphorIconsBold.sneaker,
    ),
    RegistryGiftItem(
      id: 'm-sho-2',
      name: 'Oxford Dress Shoes',
      brand: 'Aldo',
      audience: RegistryAudience.men,
      category: RegistryCategory.shoes,
      productUrl: 'https://www.aldoshoes.com/us/en_US/men/footwear',
      icon: PhosphorIconsBold.sneaker,
    ),

    // --- WOMEN ---
    RegistryGiftItem(
      id: 'w-acc-1',
      name: 'Silk Square Scarf',
      brand: 'Kate Spade',
      audience: RegistryAudience.women,
      category: RegistryCategory.accessories,
      productUrl: 'https://www.katespade.com/shop/accessories',
      icon: PhosphorIconsBold.handbag,
    ),
    RegistryGiftItem(
      id: 'w-acc-2',
      name: 'Quilted Crossbody Clutch',
      brand: 'Coach',
      audience: RegistryAudience.women,
      category: RegistryCategory.accessories,
      productUrl: 'https://www.coach.com/shop/women/bags',
      icon: PhosphorIconsBold.handbag,
    ),
    RegistryGiftItem(
      id: 'w-wat-1',
      name: 'Petite Melrose Watch',
      brand: 'Daniel Wellington',
      audience: RegistryAudience.women,
      category: RegistryCategory.watches,
      productUrl: 'https://www.danielwellington.com/us/womens-watches/',
      icon: PhosphorIconsBold.watch,
    ),
    RegistryGiftItem(
      id: 'w-wat-2',
      name: 'Mother of Pearl Dial',
      brand: 'Citizen',
      audience: RegistryAudience.women,
      category: RegistryCategory.watches,
      productUrl: 'https://www.citizenwatch.com/us/en/collection/womens/',
      icon: PhosphorIconsBold.watch,
    ),
    RegistryGiftItem(
      id: 'w-rng-1',
      name: 'Sparkling Halo Ring',
      brand: 'Pandora',
      audience: RegistryAudience.women,
      category: RegistryCategory.rings,
      productUrl: 'https://us.pandora.net/en/rings/',
      icon: PhosphorIconsBold.sketchLogo,
    ),
    RegistryGiftItem(
      id: 'w-rng-2',
      name: 'Crystal Eternity Band',
      brand: 'Swarovski',
      audience: RegistryAudience.women,
      category: RegistryCategory.rings,
      productUrl: 'https://www.swarovski.com/en-US/c-0104/Categories/Jewelry/Rings/',
      icon: PhosphorIconsBold.sketchLogo,
    ),
    RegistryGiftItem(
      id: 'w-sho-1',
      name: 'Satin Slingback Heels',
      brand: 'Steve Madden',
      audience: RegistryAudience.women,
      category: RegistryCategory.shoes,
      productUrl: 'https://www.stevemadden.com/collections/womens-heels',
      icon: PhosphorIconsBold.sneaker,
    ),
    RegistryGiftItem(
      id: 'w-sho-2',
      name: 'Embellished Ballet Flats',
      brand: 'Tory Burch',
      audience: RegistryAudience.women,
      category: RegistryCategory.shoes,
      productUrl: 'https://www.toryburch.com/en-us/shoes/flats/',
      icon: PhosphorIconsBold.sneaker,
    ),

    // --- KIDS ---
    RegistryGiftItem(
      id: 'k-acc-1',
      name: 'Mini Bow Tie & Belt Set',
      brand: 'Ralph Lauren',
      audience: RegistryAudience.kids,
      category: RegistryCategory.accessories,
      productUrl: 'https://www.ralphlauren.com/kids-accessories',
      icon: PhosphorIconsBold.gift,
    ),
    RegistryGiftItem(
      id: 'k-acc-2',
      name: 'Pastel Party Backpack',
      brand: 'Gap Kids',
      audience: RegistryAudience.kids,
      category: RegistryCategory.accessories,
      productUrl: 'https://www.gap.com/browse/division.do?cid=6170',
      icon: PhosphorIconsBold.backpack,
    ),
    RegistryGiftItem(
      id: 'k-wat-1',
      name: 'Colorblock Analog Watch',
      brand: 'Flik Flak',
      audience: RegistryAudience.kids,
      category: RegistryCategory.watches,
      productUrl: 'https://www.flikflak.com/en-us/',
      icon: PhosphorIconsBold.watch,
    ),
    RegistryGiftItem(
      id: 'k-wat-2',
      name: 'Digital Sport Watch',
      brand: 'Casio',
      audience: RegistryAudience.kids,
      category: RegistryCategory.watches,
      productUrl: 'https://www.casio.com/us/watches/casio/',
      icon: PhosphorIconsBold.watch,
    ),
    RegistryGiftItem(
      id: 'k-rng-1',
      name: 'Adjustable Heart Ring',
      brand: 'Claire\'s',
      audience: RegistryAudience.kids,
      category: RegistryCategory.rings,
      productUrl: 'https://www.claires.com/us/jewelry/rings/',
      icon: PhosphorIconsBold.star,
    ),
    RegistryGiftItem(
      id: 'k-rng-2',
      name: 'Enamel Star Ring Set',
      brand: 'Carter\'s',
      audience: RegistryAudience.kids,
      category: RegistryCategory.rings,
      productUrl: 'https://www.carters.com/carters-kid-girl-accessories',
      icon: PhosphorIconsBold.star,
    ),
    RegistryGiftItem(
      id: 'k-sho-1',
      name: 'Velcro Court Sneakers',
      brand: 'Nike Kids',
      audience: RegistryAudience.kids,
      category: RegistryCategory.shoes,
      productUrl: 'https://www.nike.com/w/kids-shoes-v4dhzy7ok',
      icon: PhosphorIconsBold.sneaker,
    ),
    RegistryGiftItem(
      id: 'k-sho-2',
      name: 'Patent Celebration Loafers',
      brand: 'Zara Kids',
      audience: RegistryAudience.kids,
      category: RegistryCategory.shoes,
      productUrl: 'https://www.zara.com/us/en/kids-shoes-l1608.html',
      icon: PhosphorIconsBold.sneaker,
    ),
  ];

  List<RegistryGiftItem> get filteredItems {
    final audience = selectedAudience.value;
    final category = selectedCategory.value;

    return items.where((item) {
      final matchesAudience = audience == null || item.audience == audience;
      final matchesCategory = item.category == category;
      return matchesAudience && matchesCategory;
    }).toList();
  }

  void toggleAudience(RegistryAudience audience) {
    if (selectedAudience.value == audience) {
      selectedAudience.value = null;
    } else {
      selectedAudience.value = audience;
    }
  }

  void selectCategory(RegistryCategory category) {
    selectedCategory.value = category;
  }

  Future<void> openProductUrl(String rawUrl) async {
    final uri = Uri.tryParse(rawUrl);
    if (uri == null) {
      _showLaunchError('Invalid product link.');
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        _showLaunchError('Could not open product page in browser.');
      }
    } catch (_) {
      _showLaunchError('Could not open product page in browser.');
    }
  }

  void _showLaunchError(String message) {
    Get.snackbar(
      'Unable to Open Link',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
