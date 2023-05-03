import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import '../dtos/meal.dart' as dto;
import '../dtos/meal_ref_url.dart' as dto;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Menus extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dinnerHoursType => integer()();
  DateTimeColumn get cookedDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Meals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(""))();
  DateTimeColumn get lastCookedDate => dateTime().nullable()();
  TextColumn get imagePathInAppDoc => text().withDefault(const Constant(""))();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get deleteFlag => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InclusionInMenu')
class InclusionsInMenu extends Table {
  IntColumn get menuId => integer().references(Menus, #id)();
  IntColumn get mealId => integer().references(Meals, #id)();

  @override
  Set<Column> get primaryKey => {menuId, mealId};
}

class MealRefUrls extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mealId => integer().references(Meals, #id)();
  TextColumn get url => text().withDefault(const Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Menus, Meals, InclusionsInMenu, MealRefUrls])
class Database extends _$Database {
  Database():super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> saveMeal(dto.Meal meal, {String? imagePathInAppDoc}) async {

    final mealCompanion = MealsCompanion(
      id: meal.id != null ? Value(meal.id!) : const Value.absent(),
      name: Value(meal.name),
      imagePathInAppDoc: imagePathInAppDoc != null ? Value(imagePathInAppDoc!) : const Value.absent(),
      lastCookedDate: Value(meal.lastCookedDate),
      createdAt: meal.id == null ? Value(DateTime.now()) : const Value.absent()
    );

    int mealId = 0;
    // 新規追加
    if(meal.id == null) {
      mealId = await into(meals).insert(mealCompanion);
    }
    // 更新
    else {
      mealId = mealCompanion.id.value;
      await (update(meals)..where((tbl) => tbl.id.equals(mealId))).write(mealCompanion);
    }

    if(meal.refUrls.isNotEmpty) {
      List<int> refUrlIds = [];

      for(final refUrl in meal.refUrls) {
        int refUrlId = 0;
        final mealRefUrlCompanion = MealRefUrlsCompanion(
            id: refUrl.id != null ? Value(refUrl.id!) : const Value.absent(),
            mealId: Value(mealId),
            url: Value(refUrl.url)
        );

        if(refUrl.id == null) {
          refUrlId = await into(mealRefUrls).insert(mealRefUrlCompanion);
        }
        else {
          refUrlId = mealRefUrlCompanion.id.value;
          await (update(mealRefUrls)..where((tbl) => tbl.id.equals(refUrlId))).write(mealRefUrlCompanion);
        }

        refUrlIds.add(refUrlId);
      }

      await (delete(mealRefUrls)..where((tbl) => tbl.id.isNotIn(refUrlIds))).go();
    }

    return mealId;
  }

  Future<List<dto.Meal>> getMeals({List<int>? ids}) async {
    final query = select(meals).join(
      [
       leftOuterJoin(
         mealRefUrls,
         mealRefUrls.mealId.equalsExp(meals.id)),
      ]
    );

    if(ids != null && ids.isNotEmpty) {
      query.where(meals.id.isIn(ids));
    }

    List<dto.Meal> mealList = [];

    final idToMealEntities = <int, Meal>{};
    final idToRefUrls = <int, List<dto.MealRefUrl>>{};

    for(final mealEntity in await query.map((row) => row.readTable(meals)).get()) {
      idToMealEntities.putIfAbsent(mealEntity.id, () => mealEntity);
    }

    for(final refUrl in await query.map((row) => row.readTableOrNull(mealRefUrls)).get()) {
      if(refUrl == null) {
        continue;
      }
      idToRefUrls.putIfAbsent(refUrl.mealId, () => []).add(dto.MealRefUrl(id: refUrl.id, url: refUrl.url));
    }

    for(final mealEntity in idToMealEntities.values){
      mealList.add(
        dto.Meal(
          id: mealEntity.id,
          name: mealEntity.name,
          lastCookedDate: mealEntity.lastCookedDate,
          createdAt: mealEntity.createdAt,
          refUrls: idToRefUrls[mealEntity.id],
          imagePathInAppDoc: mealEntity.imagePathInAppDoc
        )
      );
    }

    return mealList;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}