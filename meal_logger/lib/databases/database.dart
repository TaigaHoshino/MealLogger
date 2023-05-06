import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:meal_logger/constants/dinner_hours_type.dart';
import 'package:path/path.dart' as p;
import '../dtos/meal.dart' as dto;
import '../dtos/meal_ref_url.dart' as dto;
import '../dtos/menu.dart' as dto;
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
    )..where(meals.deleteFlag.equals(false));

    if(ids != null && ids.isNotEmpty) {
      query.where(meals.id.isIn(ids));
    }

    final idToMeal = <int, dto.Meal>{};

    for(final mealEntity in await query.map((row) => row.readTable(meals)).get()) {
      idToMeal.putIfAbsent(mealEntity.id, () =>
        dto.Meal(
            id: mealEntity.id,
            name: mealEntity.name,
            lastCookedDate: mealEntity.lastCookedDate,
            createdAt: mealEntity.createdAt,
            refUrls: [],
            imagePathInAppDoc: mealEntity.imagePathInAppDoc
        )
      );
    }

    for(final refUrl in await query.map((row) => row.readTableOrNull(mealRefUrls)).get()) {
      if(refUrl == null) {
        continue;
      }
      idToMeal[refUrl.mealId]?.refUrls.add(dto.MealRefUrl(id: refUrl.id, url: refUrl.url));
    }

    return idToMeal.values.toList();
  }

  Future<void> deleteMeal(dto.Meal meal) async {
    if(meal.id == null) {
      print('can\'t delete meal that is not recorded');
      return;
    }

    const mealCompanion = MealsCompanion(
      deleteFlag: Value(true)
    );

    await (update(meals)..where((tbl) => tbl.id.equals(meal.id!))).write(mealCompanion);
  }

  Future<void> addMealsToTodayMenu(List<dto.Meal> meals, DinnerHoursType type) async {
    int menuId;

    final now = DateTime.now();

    final menuList = await (select(menus)..where((tbl) => tbl.cookedDate.equals(DateTime(now.year, now.month, now.day)))).get();

    // 今日はじめての料理追加の場合
    if(menuList.isEmpty) {
      menuId = await into(menus).insert(MenusCompanion(
        dinnerHoursType: Value(type.index),
        cookedDate: Value(DateTime(now.year, now.month, now.day))
      ));
    }
    else {
      menuId = menuList.first.id;
    }

    for(final meal in meals) {
      await into(inclusionsInMenu).insert(
        InclusionsInMenuCompanion(
          menuId: Value(menuId),
          mealId: Value(meal.id!)
        )
      );
    }
  }

  Future<List<dto.Menu>> getMenus({DateTime? cookedDate}) async {
    final menuQuery = select(menus);

    if(cookedDate != null) {
      menuQuery.where((tbl) =>
          tbl.cookedDate.equals(DateTime(cookedDate.year, cookedDate.month, cookedDate.day)));
    }

    List<dto.Menu> menuList = [];

    for(final menuEntity in await menuQuery.get()) {
      menuList.add(dto.Menu(
        menuEntity.cookedDate,
        [],
        DinnerHoursType.intToDinnerHoursType(menuEntity.dinnerHoursType),
        id: menuEntity.id
      ));
    }

    List<int> menuIds = [];

    for(final menu in menuList) {
      menuIds.add(menu.id!);
    }

    final query = select(inclusionsInMenu).join(
      [
        leftOuterJoin(
          meals,
          meals.id.equalsExp(inclusionsInMenu.mealId)
        ),
        leftOuterJoin(
          mealRefUrls,
          mealRefUrls.mealId.equalsExp(inclusionsInMenu.mealId)
        )
      ]
    )..where(inclusionsInMenu.menuId.isIn(menuIds));

    final menuIdToMeals = <int, List<dto.Meal>>{};
    final mealIdToRefUrls = <int, List<dto.MealRefUrl>>{};

    for(final refUrlEntity in await query.map((row) => row.readTableOrNull(mealRefUrls)).get()) {
      if(refUrlEntity == null) {
        continue;
      }
      mealIdToRefUrls.putIfAbsent(refUrlEntity.mealId, () => []).add(
        dto.MealRefUrl(id: refUrlEntity.id, url: refUrlEntity.url)
      );
    }

    for(final joinedEntity in await query.get()) {
      final inclusion = joinedEntity.readTable(inclusionsInMenu);
      final mealEntity = joinedEntity.readTable(meals);

      menuIdToMeals.putIfAbsent(inclusion.menuId, () => []).add(
        dto.Meal(
          id: mealEntity.id,
          name: mealEntity.name,
          lastCookedDate: mealEntity.lastCookedDate,
          createdAt: mealEntity.createdAt,
          refUrls: mealIdToRefUrls[mealEntity.id],
          imagePathInAppDoc: mealEntity.imagePathInAppDoc
        )
      );
    }

    for(final menu in menuList) {
      menu.meals.addAll(menuIdToMeals[menu.id]?.toList() ?? []);
    }

    return menuList;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}