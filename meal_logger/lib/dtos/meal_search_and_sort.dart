import 'package:meal_logger/constants/sort_order.dart';

import '../constants/meal_sort_target.dart';

class MealSearchAndSort {
  final Map<MealSortTarget, SortOrder> sortTargetToOrder = {};
  final List<String> keywordsForTitle = [];

  void setSortTarget(MealSortTarget type, SortOrder order) {
    sortTargetToOrder[type] = order;
  }

  void removeSortTarget(MealSortTarget type) {
    sortTargetToOrder.remove(type);
  }
}