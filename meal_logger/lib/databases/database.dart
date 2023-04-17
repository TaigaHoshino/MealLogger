import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
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
  DateTimeColumn get lastCookedDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}