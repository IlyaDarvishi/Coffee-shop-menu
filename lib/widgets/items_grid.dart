import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:coffee_shop_menu/models/menu_item.dart';

/// ویجت لیست آیتم‌های منو با قابلیت چرخش کارت
class ItemsGrid extends StatelessWidget {
  final List<MenuItem> items;
  final double maxWidth;
  const ItemsGrid({super.key, required this.items, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'هیچ آیتمی یافت نشد.',
          style: TextStyle(
            fontFamily: 'Yekan',
            fontSize: 16,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
      );
    }

    final idealItemWidth = 200.0;
    final crossAxisCount = max(2, (maxWidth / idealItemWidth).floor());
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _MenuItemCard(item: items[index]);
      },
    );
  }
}

/// ویجتی برای نمایش یک کارت منو با انیمیشن فلیپ
class _MenuItemCard extends StatefulWidget {
  final MenuItem item;
  const _MenuItemCard({required this.item});

  @override
  State<_MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<_MenuItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// شروع انیمیشن فلیپ کارت
  void _flipCard() {
    _timer?.cancel();
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
      _timer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          _controller.reverse();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          final frontSide = Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(widget.item.image, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yekan',
                          fontSize: 16,
                          color: colors.onSurface,
                        ),
                      ),
                      Text(
                        "${widget.item.price.toStringAsFixed(0)} ت",
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          color: colors.onSurface.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          final backSide = Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(pi),
            child: Container(
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.item.name,
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colors.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.description,
                    style: TextStyle(
                      color: colors.onSecondary.withOpacity(0.7),
                      fontFamily: 'Yekan',
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: (angle < pi / 2) ? frontSide : backSide,
          );
        },
      ),
    );
  }
}
