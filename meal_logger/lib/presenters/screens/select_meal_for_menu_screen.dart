import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/blocs/menu_bloc.dart';
import 'package:meal_logger/constants/dinner_hours_type.dart';
import 'package:meal_logger/dtos/meal.dart';
import 'package:meal_logger/presenters/components/meal_list_item_component.dart';

import '../../blocs/meal_bloc.dart';
import '../../dtos/menu.dart';
import '../../states/loading_state.dart';

class SelectMealForMenuScreen extends StatefulWidget {
  final MealBloc _mealBloc = GetIt.I<MealBloc>();
  final MenuBloc _menuBloc = GetIt.I<MenuBloc>();
  final Menu? _menu;
  final List<Meal> _selectedMeals = [];
  final DinnerHoursType _type;

  SelectMealForMenuScreen(this._menu ,this._type ,{super.key});

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
                      List<int> addedMealInMenuIds = [];

                      for(final meal in widget._menu?.meals ?? []) {
                        addedMealInMenuIds.add(meal.id);
                      }

                      component = ListView.builder(
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          final meal = content.elementAt(index);

                          return SizedBox(
                            width: double.infinity,
                            height: 90,
                            child: Stack(
                              children: [
                                Center(
                                  child: MealListItemComponent(
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
                                  )
                                ),
                                widget._menu == null || !addedMealInMenuIds.contains(meal.id) ? Container()
                                    : Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.black.withOpacity(0.2),
                                  child: Center(
                                      child:
                                      Text('追加済み',
                                        textScaleFactor: 2.5,
                                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                                      )
                                  ),
                                )
                              ],
                            )
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
              onPressed: () async {
                await widget._menuBloc.addMealsToTodayMenu(widget._selectedMeals, widget._type);
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text('追加する'),
            )
          )
        ],
      )

    );
  }

}