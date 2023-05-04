import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/presenters/components/meal_list_item_component.dart';

import '../../blocs/app_bloc.dart';
import '../../dtos/meal.dart';
import '../../states/loading_state.dart';
import '../builders/popupmenu_button_builder.dart';
import 'meal_info_screen.dart';

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
          IconButton(
            onPressed: (){
              transitionToMealInfoScreen(mealInit);
            },
            icon: const Icon(Icons.add))]),
      body: StreamBuilder<LoadingState<List<Meal>>>(
        stream: widget.appBloc.mealList,
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
                                  await widget.appBloc.deleteMeal(meal);
                                  widget.appBloc.getMeals();
                                },
                              )
                            ]
                          );
                        }
                      );
                    });

                  return GestureDetector(
                    child: MealListItemComponent(
                      meal,
                      onTap: () => transitionToMealInfoScreen(meal),
                      popupMenuButton: popupMenuButtonBuilder.build(),
                    ),
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => MealInfoScreen(meal)))
        .then((value) async => await widget.appBloc.getMeals());
  }
}