import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../databases/database.dart';
import '../dtos/meal.dart' as dto;
import 'package:path/path.dart';

class MealRepository {
  final Database _database;

  static const _mealPictureDirName = 'picture_meal';

  MealRepository(this._database);

  Future<dto.Meal> saveMeal(dto.Meal meal, {File? newMealImage}) async {
    String? savedPathInAppDoc;
    if(newMealImage != null) {
      savedPathInAppDoc = '/$_mealPictureDirName/${basename(newMealImage.path)}';
      final savedPath = (await getApplicationDocumentsDirectory()).path + savedPathInAppDoc;
      await Directory(dirname(savedPath)).create(recursive: true);
      if(meal.imageFullPath.isNotEmpty) {
        await _deleteFile(meal.imageFullPath);
      }
      await newMealImage.copy(savedPath);
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

  Future<void> deleteMeal(dto.Meal meal) async {
    await _database.deleteMeal(meal);
    if(meal.imageFullPath.isNotEmpty) {
      await _deleteFile(meal.imageFullPath);
    }
  }

  Future<void> _deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();

    print('delete file success. filePath: $filePath');
  }
}