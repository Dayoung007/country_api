import 'package:country_api/home_page.dart';
import 'package:flutter/material.dart';

bool isDark = false;

void main() => runApp(const CountryApp());

class CountryApp extends StatefulWidget {
  const CountryApp({super.key});

  @override
  State<CountryApp> createState() => _CountryAppState();
}

class _CountryAppState extends State<CountryApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness:
            isDark ? Brightness.dark : Brightness.light);

    return MaterialApp(
      theme: themeData,
      home: HomePage(),
    );
  }
}
