import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_shop_menu/models/menu_item.dart';

class ItemsSlider extends StatefulWidget {
  final double maxWidth;
  final List<MenuItem> items;

  const ItemsSlider({super.key, required this.maxWidth, required this.items});

  @override
  State<ItemsSlider> createState() => _ItemsSliderState();
}

class _ItemsSliderState extends State<ItemsSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final List<MenuItem> items = widget.items;

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final viewportFraction = widget.maxWidth > 600 ? 0.6 : 0.95;
    final sliderHeight = widget.maxWidth > 600 ? widget.maxWidth * 0.25 : 200.0;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: items.length,
          itemBuilder: (context, index, realIndex) {
            final item = items[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: colors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(item.image, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.onBackground.withOpacity(0.7),
                            Colors.transparent,
                            colors.onBackground.withOpacity(0.2),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          color: colors.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: sliderHeight,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: viewportFraction,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? colors.primary
                    : colors.onBackground.withOpacity(0.5),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
