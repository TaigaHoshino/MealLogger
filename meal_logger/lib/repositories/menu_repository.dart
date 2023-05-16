import 'package:meal_logger/constants/dinner_hours_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_preference_keys.dart';
import '../databases/database.dart';
import '../dtos/meal.dart' as dto;
import '../dtos/menu.dart' as dto;

class MenuRepository {
  final Database _database;
  late DateTime _lastDeterminingMenuDate;
  MenuRepository(this._database);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final datetimeStr = prefs.getString(SharedPreferenceKeys.lastDeterminingMenuDate.key);
    if(datetimeStr == null) {
      _lastDeterminingMenuDate = DateTime.now();
      await prefs.setString(SharedPreferenceKeys.lastDeterminingMenuDate.key, _lastDeterminingMenuDate.toString());
    }
    else {
      _lastDeterminingMenuDate = DateTime.parse(datetimeStr);
    }
  }
  
  Future<void> addTodayMeal(List<dto.Meal> meals, DinnerHoursType type) async {
    await _database.addMealsToTodayMenu(meals, type);
  }

  Future<void> removeMealFromMenu(dto.Menu menu, dto.Meal meal) async {
    await _database.removeMealFromMenu(menu, meal);
  }

  Future<List<dto.Menu>> getMenus({DateTime? cookedDate}) async {
    return await _database.getMenus(cookedDate: cookedDate);
  }

  Future<bool> determineMenuIfDateIsChanged() async {
    DateTime now = DateTime.now();

    if(now.difference(
      DateTime(_lastDeterminingMenuDate.year,
               _lastDeterminingMenuDate.month,
               _lastDeterminingMenuDate.day)).inDays <= 0) {
      return false;
    }

    List<dto.Menu> undeterminedMenus =
      await _database.getMenus(from: _lastDeterminingMenuDate.add(const Duration(days: 1)));

    for(final menu in undeterminedMenus) {
      for(final meal in menu.meals) {
        meal.lastCookedDate = menu.cookedDate;
        await _database.saveMeal(meal);
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferenceKeys.lastDeterminingMenuDate.key, now.toString());

    _lastDeterminingMenuDate = now;

    return true;
  }
}