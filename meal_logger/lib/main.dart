import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/blocs/app_bloc.dart';
import 'package:meal_logger/presenters/screens/main_screen.dart';
import 'package:meal_logger/repositories/meal_repository.dart';

void main() {
  GetIt.I.registerSingleton(AppBloc(MealRepository()));
  runApp(const MealLoggerApp());
}

class MealLoggerApp extends StatelessWidget {
  const MealLoggerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '献立履歴',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}


