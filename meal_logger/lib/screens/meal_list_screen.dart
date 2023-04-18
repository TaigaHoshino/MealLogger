import 'package:flutter/material.dart';
import 'package:meal_logger/screens/meal_info_screen.dart';

import '../dtos/meal.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  @override
  Widget build(BuildContext context) {
    Meal meal = Meal();
    return Scaffold(
      appBar: AppBar(title: const Text('料理リスト'),
        actions: <Widget>[IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MealInfoScreen(meal)));},
          icon: const Icon(Icons.add))]),
      body: const Text('料理リスト')
    );
  }
}