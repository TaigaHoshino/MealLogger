import 'package:meal_logger/constants/dinner_hours_type.dart';

import '../databases/database.dart';
import '../dtos/meal.dart' as dto;
import '../dtos/menu.dart' as dto;

class MenuRepository {
  final Database _database;
  MenuRepository(this._database);
  
  Future<void> addTodayMeal(List<dto.Meal> meals, DinnerHoursType type) async {
    await _database.addMealsToTodayMenu(meals, type);
  }

  Future<void> removeMealFromMenu(dto.Menu menu, dto.Meal meal) async {
    await _database.removeMealFromMenu(menu, meal);
  }

  Future<List<dto.Menu>> getMenus({DateTime? cookedDate}) async {
    return await _database.getMenus(cookedDate: cookedDate);
  }
}