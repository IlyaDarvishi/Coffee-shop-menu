import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop_menu/theme/theme_provider.dart';

/// appbar برنامه
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTitleTap;

  const CustomAppBar({super.key, required this.onTitleTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: GestureDetector(
              onTap: onTitleTap,
              child: Text(
                'Coffee Flutter',
                style: TextStyle(
                  fontFamily: 'shaded-larch',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
            ],
            toolbarHeight: kToolbarHeight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
