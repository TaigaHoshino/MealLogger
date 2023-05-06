import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/blocs/menu_bloc.dart';
import 'package:meal_logger/constants/dinner_hours_type.dart';
import 'package:meal_logger/dtos/meal.dart';
import 'package:meal_logger/presenters/components/meal_list_item_component.dart';

import '../../blocs/meal_bloc.dart';
import '../../states/loading_state.dart';

class SelectMealForMenuScreen extends StatefulWidget {
  final MealBloc _mealBloc = GetIt.I<MealBloc>();
  final MenuBloc _menuBloc = GetIt.I<MenuBloc>();
  List<Meal> _selectedMeals = [];
  final DinnerHoursType _type;

  SelectMealForMenuScreen(this._type ,{super.key});

  @override
  State<SelectMealForMenuScreen> createState() => _SelectMealForMenuScreenState();
}

class _SelectMealForMenuScreenState extends State<SelectMealForMenuScreen>{
  @override
  Widget build(BuildContext context) {
    widget._mealBloc.getMeals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('料理を選択'),
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);})),
      body: Column(
        children: [
          Expanded(
            child:
              StreamBuilder<LoadingState<List<Meal>>>(
                stream: widget._mealBloc.mealList,
                builder: (context, snapshot){
                  Widget component = const Text("");
                  if(!snapshot.hasData){
                    return component;
                  }

                  snapshot.data!.when(
                    loading: (List<Meal>? content) {
                      component = const Center(
                          child: CircularProgressIndicator()
                      );
                    },
                    completed: (List<Meal> content) {
                      component = ListView.builder(
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          final meal = content.elementAt(index);

                          return MealListItemComponent(
                            meal,
                            onTap: () {
                              if(!widget._selectedMeals.contains(meal)) {
                                widget._selectedMeals.add(meal);
                              }
                              else {
                                widget._selectedMeals.remove(meal);
                              }
                            },
                            selectedColor: Colors.lightBlue,
                            isSelected: widget._selectedMeals.contains(meal),
                          );
                        },
                      );
                    },
                    error: (Exception exception) {  }
                );

                return component;
              })
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                widget._menuBloc.addMealsToTodayMenu(widget._selectedMeals, widget._type);
              },
              child: const Text('追加する'),
            )
          )
        ],
      )

    );
  }

}