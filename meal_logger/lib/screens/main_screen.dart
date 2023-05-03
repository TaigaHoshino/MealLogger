import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_logger/screens/meal_list_screen.dart';
import 'package:meal_logger/screens/menu_log_screen.dart';
import 'package:meal_logger/screens/today_menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int _currentIndex = 0;
  final _pageWidgets = [
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
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: '今日の献立'),
            BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: '料理リスト'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: '献立履歴')
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(builder: (context) {
            return CupertinoPageScaffold(
              child: _pageWidgets[index]
            );
          });
        },
      )
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}