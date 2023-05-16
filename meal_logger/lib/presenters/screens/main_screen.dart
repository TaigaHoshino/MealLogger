import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/blocs/menu_bloc.dart';
import 'package:meal_logger/presenters/screens/today_menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/shared_preference_keys.dart';
import 'meal_list_screen.dart';
import 'menu_log_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver{

  Timer? _timer;
  final _menuBloc = GetIt.I<MenuBloc>();

  int _currentIndex = 0;
  final _screens = [
    TodayMenuScreen(),
    MealListScreen(),
    const MenuLogScreen()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _menuBloc.onDetermineMenuIfDateIsChangedProgress.listen(
      (event) {
        event.when(
          loading: (content) => null,
          completed: (content) async {
            if(content){
              await _menuBloc.getTodayMenus();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text("日付が変わりました"),
                      content: const Text("日付が変わったため、献立を更新しました"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ]
                  );
                }
              );
            }
          },
          error: (exception) {});
      });

    _timer = _createDateChangeMonitoringLooper();
    _menuBloc.determineMenuIfDateIsChanged();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state == AppLifecycleState.resumed) {
      _timer = _createDateChangeMonitoringLooper();
    }
    else {
      _timer?.cancel();
    }
  }

  Timer _createDateChangeMonitoringLooper() {
    return Timer.periodic(const Duration(seconds: 60), (timer) async {
        await _menuBloc.determineMenuIfDateIsChanged();
      });
  }
}