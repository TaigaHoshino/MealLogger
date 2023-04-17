import 'package:meal_logger/dtos/meal.dart';

import '../constants/dinner_hours_type.dart';

class Menu {
  int? id;
  DateTime cookedDate;
  List<Meal> meals = [];
  DinnerHoursType dinnerHoursType;

  // idを指定しない場合、新規追加になる
  Menu(this.cookedDate, this.meals, this.dinnerHoursType, {this.id});
}