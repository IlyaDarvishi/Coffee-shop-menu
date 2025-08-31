import 'package:flutter/material.dart';
import 'package:coffee_shop_menu/data/menu_data.dart';

/// ویجت انتخاب دسته‌بندی‌ها
class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String selectedCategoryId;

  const CategorySelector({
    super.key,
    required this.onCategorySelected,
    required this.selectedCategoryId,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = widget.selectedCategoryId == category.id;
          return GestureDetector(
            onTap: () {
              widget.onCategorySelected(category.id);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : colors.tertiary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Yekan',
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? colors.onPrimary : colors.onBackground,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
