import 'dart:io';

import 'package:meal_logger/repositories/meal_repository.dart';
import 'package:meal_logger/states/loading_state.dart';
import 'package:rxdart/rxdart.dart';

import '../dtos/meal.dart';

class MealBloc {
  final MealRepository _mealRepository;

  final _mealSaveProgressController = BehaviorSubject<LoadingState<Meal>>();

  final _mealListController = BehaviorSubject<LoadingState<List<Meal>>>.seeded(const LoadingState.completed([]));

  Stream<LoadingState<Meal>> get onMealSaveProgress => _mealSaveProgressController.stream;

  Stream<LoadingState<List<Meal>>> get mealList => _mealListController.stream;

  MealBloc(this._mealRepository);

  Future<void> saveMeal(Meal meal, {File? newMealImage}) async {
    _mealSaveProgressController.sink.add(const LoadingState.loading(null));

    try {
      final result = await _mealRepository.saveMeal(meal, newMealImage: newMealImage);
      _mealSaveProgressController.sink.add(LoadingState.completed(result));
    }
    on Exception catch (e){
      print(e);
      _mealSaveProgressController.sink.add(LoadingState.error(e));
    }
    catch (e) {
      print(e);
      _mealSaveProgressController.sink.add(LoadingState.error(Exception('Unexpected error is occurred')));
    }
  }

  Future<void> getMeals() async {
    _mealListController.sink.add(const LoadingState.loading(null));

    try {
      final results = await _mealRepository.getMeals();
      _mealListController.sink.add(LoadingState.completed(results));
    }
    on Exception catch (e){
      print(e);
      _mealListController.sink.add(LoadingState.error(e));
    }
    catch (e) {
      print(e);
      _mealSaveProgressController.sink.add(LoadingState.error(Exception('Unexpected error is occurred')));
    }
  }

  Future<void> deleteMeal(Meal meal) async {
    await _mealRepository.deleteMeal(meal);
  }
}