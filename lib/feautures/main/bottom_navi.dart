import 'package:deula/core/di/service_locator.dart';
import 'package:deula/feautures/add_meal/presentation/screens/add_screen.dart';
import 'package:deula/feautures/home/presentation/screens/home_screen.dart';
import 'package:deula/feautures/water/presentation/water_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      AddMealScreen(),
      const WaterScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12.sp,
        unselectedFontSize: 11.sp,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: tr("nav_home"), // Home tab label
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: tr("add_meal"), // Add Meal tab label
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_drink),
            label: tr("hydrate"), // Water tab label
          ),
        ],
      ),
    );
  }
}
