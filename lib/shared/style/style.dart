import 'package:flutter/material.dart';

// main background-color: #3366FF;
// selected item-color: #D6E4FF; --- item-border: #3366FF;

ThemeData buildMainTheme() => ThemeData(
      colorSchemeSeed: const Color(0xFF2E5BE3),
      appBarTheme: const AppBarTheme(centerTitle: true),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color(0xFF2E5BE3),
          ),
        ),
      ),
      primaryTextTheme: const TextTheme(
        labelLarge: TextStyle(
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          color: Color(0xFF2E5BE3),
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      tabBarTheme: TabBarTheme(
        dividerHeight: 0,
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: const Color(0xff091A7A),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      useMaterial3: true,
    );
