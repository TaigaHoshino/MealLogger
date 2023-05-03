import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/screens/meal_info_screen.dart';

import '../blocs/app_bloc.dart';
import '../dtos/meal.dart';
import '../states/loading_state.dart';

class MealListScreen extends StatefulWidget {
  final AppBloc appBloc = GetIt.I<AppBloc>();

  MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  @override
  void initState() {
    super.initState();
    widget.appBloc.getMeals();
  }

  @override
  Widget build(BuildContext context) {
    Meal mealInit = Meal();

    return Scaffold(
      appBar: AppBar(title: const Text('料理リスト'),
        actions: <Widget>[
          IconButton(onPressed: (){
              transitionToMealInfoScreen(mealInit);
            },
          icon: const Icon(Icons.add))]),
      body: StreamBuilder<LoadingState<List<Meal>>>(
        stream: widget.appBloc.mealList,
        builder: (context, snapshot){
          Widget widget = const Text("");
          if(!snapshot.hasData){
            return widget;
          }

          snapshot.data!.when(
            loading: (_) => {},
            completed: (content) => {
              widget = ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  final meal = content.elementAt(index);
                  return ListTile(
                    title: Text(meal.name),
                    onTap: (){
                      transitionToMealInfoScreen(meal);
                  },);
                },
              )
            },
            error: (_) => {}
          );

          return widget;
        }
      )
    );
  }

  void transitionToMealInfoScreen(Meal meal) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MealInfoScreen(meal)))
        .then((value) async => await widget.appBloc.getMeals());
  }
}