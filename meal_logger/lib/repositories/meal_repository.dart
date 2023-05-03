import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../databases/database.dart';
import '../dtos/meal.dart' as dto;
import 'package:path/path.dart';

class MealRepository {
  final _database = Database();

  static const _mealPictureDirName = 'picture_meal';

  Future<dto.Meal> saveMeal(dto.Meal meal, {File? newMealImage}) async {
    String? savedPathInAppDoc;
    if(newMealImage != null) {
      savedPathInAppDoc = '/$_mealPictureDirName/${basename(newMealImage.path)}';
      final savedPath = (await getApplicationDocumentsDirectory()).path + savedPathInAppDoc;
      newMealImage.copy(savedPath);
      if(meal.imagePathInAppDoc.isNotEmpty) {
        await _deleteFile(meal.imagePathInAppDoc);
      }
    }
    int id = await _database.saveMeal(meal, imagePathInAppDoc: savedPathInAppDoc);
    return (await _database.getMeals(ids: [id])).first;
  }

  Future<List<dto.Meal>> getMeals() async {
    final meals = await _database.getMeals();
    for(final meal in meals) {
      if(meal.imagePathInAppDoc.isNotEmpty) {
        meal.imageFullPath = (await getApplicationDocumentsDirectory()).path + meal.imagePathInAppDoc;
      }
    }

    return meals;
  }

  void deleteMeal() {

  }

  Future<void> _deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();

    print('delete file success. filePath: $filePath');
  }
}