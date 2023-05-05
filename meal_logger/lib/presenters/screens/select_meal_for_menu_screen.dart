import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/dtos/meal.dart';
import 'package:meal_logger/presenters/components/meal_list_item_component.dart';

import '../../blocs/app_bloc.dart';
import '../../states/loading_state.dart';

class SelectMealForMenuScreen extends StatefulWidget {
  final AppBloc appBloc = GetIt.I<AppBloc>();

  SelectMealForMenuScreen({super.key});

  @override
  State<SelectMealForMenuScreen> createState() => _SelectMealForMenuScreenState();
}

class _SelectMealForMenuScreenState extends State<SelectMealForMenuScreen>{
  @override
  Widget build(BuildContext context) {
    widget.appBloc.getMeals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('料理を選択'),
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);})),
      body: Column(
        children: [
          Expanded(
            child:
              StreamBuilder<LoadingState<List<Meal>>>(
                stream: widget.appBloc.mealList,
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
                            onTap: () {},
                            selectedColor: Colors.lightBlue,
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
                  minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {

                },
                child: Text('追加する'),
              )
          )
        ],
      )

    );
  }

}