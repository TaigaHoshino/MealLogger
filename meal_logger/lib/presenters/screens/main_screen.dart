import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_logger/presenters/screens/today_menu_screen.dart';

import 'meal_list_screen.dart';
import 'menu_log_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int _currentIndex = 0;
  final _screens = [
    const TodayMenuScreen(),
    MealListScreen(),
    const MenuLogScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('献立履歴'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: '今日の献立'),
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: '料理リスト'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '献立履歴')
        ],
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
      )
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}