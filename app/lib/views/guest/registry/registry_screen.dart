import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/guest_registry_controller.dart';
import '../widgets/guest_header.dart';
import 'widgets/audience_filter_card.dart';
import 'widgets/registry_category_tabs.dart';
import 'widgets/registry_item_card.dart';

class GuestRegistryScreen extends StatelessWidget {
  const GuestRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.isRegistered<GuestRegistryController>()
        ? Get.find<GuestRegistryController>()
        : Get.put(GuestRegistryController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GuestHeader(
              badgeText: 'GUEST PANEL',
              subtitle: 'Find a gift',
              title: 'Gift registry',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Audience filter boxes: Men | Women | Kids
                  Obx(() {
                    final selected = controller.selectedAudience.value;
                    return Row(
                      children: [
                        Expanded(
                          child: AudienceFilterCard(
                            label: 'Men',
                            backgroundColor: const Color(0xFFDFEEFC),
                            textColor: const Color(0xFF1A437A),
                            isSelected: selected == RegistryAudience.men,
                            onTap: () =>
                                controller.toggleAudience(RegistryAudience.men),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AudienceFilterCard(
                            label: 'Women',
                            backgroundColor: const Color(0xFFFCE2EB),
                            textColor: const Color(0xFF8C1D46),
                            isSelected: selected == RegistryAudience.women,
                            onTap: () => controller.toggleAudience(
                              RegistryAudience.women,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AudienceFilterCard(
                            label: 'Kids',
                            backgroundColor: const Color(0xFFDCF6E4),
                            textColor: const Color(0xFF1B5E32),
                            isSelected: selected == RegistryAudience.kids,
                            onTap: () => controller.toggleAudience(
                              RegistryAudience.kids,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),

                  // Category segmented tabs: Accessories | Watches | Rings | Shoes
                  Obx(
                    () => RegistryCategoryTabs(
                      selectedCategory: controller.selectedCategory.value,
                      onCategorySelected: controller.selectCategory,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 2-column Filtered Gift Items Grid
                  Obx(() {
                    final items = controller.filteredItems;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            mainAxisExtent: 224,
                          ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return RegistryItemCard(
                          item: item,
                          onShopPressed: () =>
                              controller.openProductUrl(item.productUrl),
                        );
                      },
                    );
                  }),
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
