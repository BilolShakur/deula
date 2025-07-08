import 'package:deula/feautures/add_meal/presentation/screens/add_screen.dart';
import 'package:deula/feautures/home/presentation/screens/home_screen.dart';
import 'package:deula/feautures/water/presentation/water_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final screens = [
    const HomeScreen(key: ValueKey("home")),
    const AddMealScreen(key: ValueKey("add")),
    const WaterScreen(key: ValueKey("water")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: screens[_currentIndex],
      ),
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
            label: tr("nav_home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: tr("add_meal"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_drink),
            label: tr("hydrate"),
          ),
        ],
      ),
    );
  }
}
