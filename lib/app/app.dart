import 'package:flutter/material.dart';
import 'package:weather/presentation/home_screen.dart';
import 'package:weather/presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      home: const HomeScreen(),
    );
  }
}
