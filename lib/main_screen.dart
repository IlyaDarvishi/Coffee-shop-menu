import 'package:coffee_shop_menu/widgets/category_selector.dart';
import 'package:coffee_shop_menu/widgets/items_slider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop_menu/widgets/search_box.dart';
import 'package:coffee_shop_menu/data/menu_data.dart';
import 'package:coffee_shop_menu/models/menu_item.dart';
import 'package:coffee_shop_menu/widgets/items_grid.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop_menu/theme/theme_provider.dart';
import 'package:coffee_shop_menu/widgets/address_widget.dart';
import 'package:collection/collection.dart';
import 'package:coffee_shop_menu/widgets/custom_app_bar.dart';

/// صفحه اصلی برنامه
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// متغیرهای مربوط به جستجو و فیلتر
  String query = "";
  String selectedCategoryId = "c0";
  late List<MenuItem> _shuffledMenuItems;
  late List<MenuItem> _filteredItems;

  /// کنترلر اسکرول برای مدیریت اسکرولینگ
  final ScrollController _scrollController = ScrollController();

  /// GlobalKey برای دسترسی به ویجت آدرس
  final GlobalKey _addressKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _shuffledMenuItems = List.from(menuItems)..shuffle();
    _filteredItems = _shuffledMenuItems;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// اسکرول به سمت ویجت آدرس
  void _scrollToAddress() {
    final context = _addressKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  /// فیلتر کردن آیتم‌ها بر اساس جستجو و دسته‌بندی انتخاب شده
  void _filterItems() {
    final searchWords = query
        .toLowerCase()
        .split(' ')
        .where((word) => word.isNotEmpty);

    if (query.isEmpty && selectedCategoryId == "c0") {
      _filteredItems = _shuffledMenuItems;
    } else {
      _filteredItems = menuItems.where((item) {
        final isCategoryMatch =
            selectedCategoryId == "c0" || item.categoryId == selectedCategoryId;
        final itemText = '${item.name} ${item.description}'.toLowerCase();
        final isSearchMatch = searchWords.every(
          (word) => itemText.contains(word),
        );
        return isCategoryMatch && isSearchMatch;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// آیتم‌های ویژه برای اسلایدر
    final sliderItems = [
      menuItems.firstWhereOrNull((item) => item.id == "c7_m6"),
      menuItems.firstWhereOrNull((item) => item.id == "c3_m3"),
      menuItems.firstWhereOrNull((item) => item.id == "c1_m3"),
    ].whereNotNull().toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(onTitleTap: _scrollToAddress),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBox(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          if (query.isNotEmpty) {
                            selectedCategoryId = 'c0';
                          }
                          _filterItems();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return ItemsSlider(
                          items: sliderItems,
                          maxWidth: constraints.maxWidth,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    CategorySelector(
                      selectedCategoryId: selectedCategoryId,
                      onCategorySelected: (id) {
                        setState(() {
                          selectedCategoryId = id;
                          _filterItems();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return ItemsGrid(
                          items: _filteredItems,
                          maxWidth: constraints.maxWidth,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    RepaintBoundary(
                      key: _addressKey,
                      child: const AddressWidget(),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'طراحی و توسعه ایلیا درویشی',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.6),
                          fontSize: 12,
                          fontFamily: 'Yekan',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
