import 'package:meal_logger/constants/dinner_hours_type.dart';
import 'package:meal_logger/repositories/menu_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../dtos/meal.dart';
import '../dtos/menu.dart';
import '../states/loading_state.dart';

class MenuBloc {
  final MenuRepository _menuRepository;

  final _addMealsToTodayMenuController = BehaviorSubject<LoadingState<void>>();

  final _menuListController = BehaviorSubject<LoadingState<List<Menu>>>.seeded(const LoadingState.completed([]));

  Stream<LoadingState<void>> get onAddMealToTodayMenuProgress => _addMealsToTodayMenuController.stream;

  Stream<LoadingState<List<Menu>>> get menuList => _menuListController.stream;

  MenuBloc(this._menuRepository);

  Future<void> addMealsToTodayMenu(List<Meal> meals, DinnerHoursType type) async {
    _addMealsToTodayMenuController.sink.add(const LoadingState.loading(null));

    try {
      await _menuRepository.addTodayMeal(meals, type);
      _addMealsToTodayMenuController.sink.add(const LoadingState.completed(null));
    }
    on Exception catch (e){
      print(e);
      _addMealsToTodayMenuController.sink.add(LoadingState.error(e));
    }
    catch (e) {
      print(e);
      _addMealsToTodayMenuController.sink.add(LoadingState.error(Exception('Unexpected error is occurred')));
    }
  }

  Future<void> getTodayMenus() async {
    _menuListController.sink.add(const LoadingState.loading(null));

    try {
      List<Menu> menus = await _menuRepository.getMenus(cookedDate: DateTime.now());
      _menuListController.sink.add(LoadingState.completed(menus));
    }
    on Exception catch (e){
      print(e);
      _menuListController.sink.add(LoadingState.error(e));
    }
    catch (e) {
      print(e);
      _menuListController.sink.add(LoadingState.error(Exception('Unexpected error is occurred')));
    }
  }
}