import 'package:coffee_shop_menu/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop_menu/theme/theme_provider.dart';

/// نقطه شروع برنامه
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Flutter',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MainScreen(),
    );
  }
}
