import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/guest_registry_controller.dart';
import '../../../../theme/app_theme.dart';

class RegistryCategoryTabs extends StatelessWidget {
  final RegistryCategory selectedCategory;
  final ValueChanged<RegistryCategory> onCategorySelected;

  const RegistryCategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;
    final isDark = theme.brightness == Brightness.dark;

    final containerColor = isDark
        ? const Color(0xFF251838)
        : const Color(0xFFEFE8F6);

    return Container(
      width: double.infinity,
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: RegistryCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          return Expanded(
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? customColors.cardBackground
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: customColors.cardShadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    category.label,
                    style: GoogleFonts.poppins(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : customColors.textMuted,
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
