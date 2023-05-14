import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/dtos/meal_search_and_sort.dart';
import 'package:meal_logger/presenters/components/meal_list_item_component.dart';
import 'package:meal_logger/presenters/components/meal_search_and_sort_component.dart';

import '../../blocs/meal_bloc.dart';
import '../../dtos/meal.dart';
import '../../states/loading_state.dart';
import '../builders/popupmenu_button_builder.dart';
import 'meal_info_screen.dart';

class MealListScreen extends StatefulWidget {
  final MealBloc _mealBloc = GetIt.I<MealBloc>();

  MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  final _mealSearchAndSort = MealSearchAndSort();

  @override
  void initState() {
    super.initState();
    widget._mealBloc.getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('料理リスト'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (builder) {
                  return MealSearchAndSortComponent(_mealSearchAndSort);
                });
            },
            icon: const Icon(Icons.search)
          ),
          IconButton(
            onPressed: (){
              transitionToMealInfoScreen(Meal());
            },
            icon: const Icon(Icons.add)
          ),
        ]),
      body: StreamBuilder<LoadingState<List<Meal>>>(
        stream: widget._mealBloc.mealList,
        builder: (context, snapshot){
          Widget component = const Text("");
          if(!snapshot.hasData){
            return component;
          }

          snapshot.data!.when(
            loading: (_) => {
              component = const Center(
                child: CircularProgressIndicator()
              )
            },
            completed: (content) => {
              component = ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  final meal = content.elementAt(index);

                  final popupMenuButtonBuilder = PopupMenuButtonBuilder();
                  popupMenuButtonBuilder.addMenu(
                    const Text('削除'),
                        () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("料理の削除"),
                            content: Text("\"${meal.name}\"を削除します。この操作は取り消せませんが、よろしいですか？"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('キャンセル'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text('削除'),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await widget._mealBloc.deleteMeal(meal);
                                  widget._mealBloc.getMeals();
                                },
                              )
                            ]
                          );
                        }
                      );
                    });

                  return MealListItemComponent(
                      meal,
                      onTap: () => transitionToMealInfoScreen(meal),
                      trailingWidget: popupMenuButtonBuilder.build(),
                  );
                },
              )
            },
            error: (_) => {}
          );

          return component;
        }
      )
    );
  }

  void transitionToMealInfoScreen(Meal meal) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MealInfoScreen(meal, editMode: true)))
        .then((value) async => await widget._mealBloc.getMeals());
  }
}