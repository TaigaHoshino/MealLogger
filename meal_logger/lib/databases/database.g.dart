// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MenusTable extends Menus with TableInfo<$MenusTable, Menu> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dinnerHoursTypeMeta =
      const VerificationMeta('dinnerHoursType');
  @override
  late final GeneratedColumn<int> dinnerHoursType = GeneratedColumn<int>(
      'dinner_hours_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cookedDateMeta =
      const VerificationMeta('cookedDate');
  @override
  late final GeneratedColumn<DateTime> cookedDate = GeneratedColumn<DateTime>(
      'cooked_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dinnerHoursType, cookedDate];
  @override
  String get aliasedName => _alias ?? 'menus';
  @override
  String get actualTableName => 'menus';
  @override
  VerificationContext validateIntegrity(Insertable<Menu> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dinner_hours_type')) {
      context.handle(
          _dinnerHoursTypeMeta,
          dinnerHoursType.isAcceptableOrUnknown(
              data['dinner_hours_type']!, _dinnerHoursTypeMeta));
    } else if (isInserting) {
      context.missing(_dinnerHoursTypeMeta);
    }
    if (data.containsKey('cooked_date')) {
      context.handle(
          _cookedDateMeta,
          cookedDate.isAcceptableOrUnknown(
              data['cooked_date']!, _cookedDateMeta));
    } else if (isInserting) {
      context.missing(_cookedDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Menu map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Menu(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dinnerHoursType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dinner_hours_type'])!,
      cookedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cooked_date'])!,
    );
  }

  @override
  $MenusTable createAlias(String alias) {
    return $MenusTable(attachedDatabase, alias);
  }
}

class Menu extends DataClass implements Insertable<Menu> {
  final int id;
  final int dinnerHoursType;
  final DateTime cookedDate;
  const Menu(
      {required this.id,
      required this.dinnerHoursType,
      required this.cookedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dinner_hours_type'] = Variable<int>(dinnerHoursType);
    map['cooked_date'] = Variable<DateTime>(cookedDate);
    return map;
  }

  MenusCompanion toCompanion(bool nullToAbsent) {
    return MenusCompanion(
      id: Value(id),
      dinnerHoursType: Value(dinnerHoursType),
      cookedDate: Value(cookedDate),
    );
  }

  factory Menu.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Menu(
      id: serializer.fromJson<int>(json['id']),
      dinnerHoursType: serializer.fromJson<int>(json['dinnerHoursType']),
      cookedDate: serializer.fromJson<DateTime>(json['cookedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dinnerHoursType': serializer.toJson<int>(dinnerHoursType),
      'cookedDate': serializer.toJson<DateTime>(cookedDate),
    };
  }

  Menu copyWith({int? id, int? dinnerHoursType, DateTime? cookedDate}) => Menu(
        id: id ?? this.id,
        dinnerHoursType: dinnerHoursType ?? this.dinnerHoursType,
        cookedDate: cookedDate ?? this.cookedDate,
      );
  @override
  String toString() {
    return (StringBuffer('Menu(')
          ..write('id: $id, ')
          ..write('dinnerHoursType: $dinnerHoursType, ')
          ..write('cookedDate: $cookedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dinnerHoursType, cookedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Menu &&
          other.id == this.id &&
          other.dinnerHoursType == this.dinnerHoursType &&
          other.cookedDate == this.cookedDate);
}

class MenusCompanion extends UpdateCompanion<Menu> {
  final Value<int> id;
  final Value<int> dinnerHoursType;
  final Value<DateTime> cookedDate;
  const MenusCompanion({
    this.id = const Value.absent(),
    this.dinnerHoursType = const Value.absent(),
    this.cookedDate = const Value.absent(),
  });
  MenusCompanion.insert({
    this.id = const Value.absent(),
    required int dinnerHoursType,
    required DateTime cookedDate,
  })  : dinnerHoursType = Value(dinnerHoursType),
        cookedDate = Value(cookedDate);
  static Insertable<Menu> custom({
    Expression<int>? id,
    Expression<int>? dinnerHoursType,
    Expression<DateTime>? cookedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dinnerHoursType != null) 'dinner_hours_type': dinnerHoursType,
      if (cookedDate != null) 'cooked_date': cookedDate,
    });
  }

  MenusCompanion copyWith(
      {Value<int>? id,
      Value<int>? dinnerHoursType,
      Value<DateTime>? cookedDate}) {
    return MenusCompanion(
      id: id ?? this.id,
      dinnerHoursType: dinnerHoursType ?? this.dinnerHoursType,
      cookedDate: cookedDate ?? this.cookedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dinnerHoursType.present) {
      map['dinner_hours_type'] = Variable<int>(dinnerHoursType.value);
    }
    if (cookedDate.present) {
      map['cooked_date'] = Variable<DateTime>(cookedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenusCompanion(')
          ..write('id: $id, ')
          ..write('dinnerHoursType: $dinnerHoursType, ')
          ..write('cookedDate: $cookedDate')
          ..write(')'))
        .toString();
  }
}

class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _lastCookedDateMeta =
      const VerificationMeta('lastCookedDate');
  @override
  late final GeneratedColumn<DateTime> lastCookedDate =
      GeneratedColumn<DateTime>('last_cooked_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, lastCookedDate, createdAt];
  @override
  String get aliasedName => _alias ?? 'meals';
  @override
  String get actualTableName => 'meals';
  @override
  VerificationContext validateIntegrity(Insertable<Meal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('last_cooked_date')) {
      context.handle(
          _lastCookedDateMeta,
          lastCookedDate.isAcceptableOrUnknown(
              data['last_cooked_date']!, _lastCookedDateMeta));
    } else if (isInserting) {
      context.missing(_lastCookedDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastCookedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_cooked_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(attachedDatabase, alias);
  }
}

class Meal extends DataClass implements Insertable<Meal> {
  final int id;
  final String name;
  final DateTime lastCookedDate;
  final DateTime createdAt;
  const Meal(
      {required this.id,
      required this.name,
      required this.lastCookedDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_cooked_date'] = Variable<DateTime>(lastCookedDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MealsCompanion toCompanion(bool nullToAbsent) {
    return MealsCompanion(
      id: Value(id),
      name: Value(name),
      lastCookedDate: Value(lastCookedDate),
      createdAt: Value(createdAt),
    );
  }

  factory Meal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastCookedDate: serializer.fromJson<DateTime>(json['lastCookedDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastCookedDate': serializer.toJson<DateTime>(lastCookedDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Meal copyWith(
          {int? id,
          String? name,
          DateTime? lastCookedDate,
          DateTime? createdAt}) =>
      Meal(
        id: id ?? this.id,
        name: name ?? this.name,
        lastCookedDate: lastCookedDate ?? this.lastCookedDate,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastCookedDate: $lastCookedDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lastCookedDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meal &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastCookedDate == this.lastCookedDate &&
          other.createdAt == this.createdAt);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> lastCookedDate;
  final Value<DateTime> createdAt;
  const MealsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastCookedDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MealsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required DateTime lastCookedDate,
    required DateTime createdAt,
  })  : lastCookedDate = Value(lastCookedDate),
        createdAt = Value(createdAt);
  static Insertable<Meal> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? lastCookedDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastCookedDate != null) 'last_cooked_date': lastCookedDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MealsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? lastCookedDate,
      Value<DateTime>? createdAt}) {
    return MealsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastCookedDate: lastCookedDate ?? this.lastCookedDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastCookedDate.present) {
      map['last_cooked_date'] = Variable<DateTime>(lastCookedDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastCookedDate: $lastCookedDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InclusionsInMenuTable extends InclusionsInMenu
    with TableInfo<$InclusionsInMenuTable, InclusionInMenu> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InclusionsInMenuTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
      'menu_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES menus (id)'));
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<int> mealId = GeneratedColumn<int>(
      'meal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES meals (id)'));
  @override
  List<GeneratedColumn> get $columns => [menuId, mealId];
  @override
  String get aliasedName => _alias ?? 'inclusions_in_menu';
  @override
  String get actualTableName => 'inclusions_in_menu';
  @override
  VerificationContext validateIntegrity(Insertable<InclusionInMenu> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('menu_id')) {
      context.handle(_menuIdMeta,
          menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta));
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (data.containsKey('meal_id')) {
      context.handle(_mealIdMeta,
          mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta));
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {menuId, mealId};
  @override
  InclusionInMenu map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InclusionInMenu(
      menuId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menu_id'])!,
      mealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meal_id'])!,
    );
  }

  @override
  $InclusionsInMenuTable createAlias(String alias) {
    return $InclusionsInMenuTable(attachedDatabase, alias);
  }
}

class InclusionInMenu extends DataClass implements Insertable<InclusionInMenu> {
  final int menuId;
  final int mealId;
  const InclusionInMenu({required this.menuId, required this.mealId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['menu_id'] = Variable<int>(menuId);
    map['meal_id'] = Variable<int>(mealId);
    return map;
  }

  InclusionsInMenuCompanion toCompanion(bool nullToAbsent) {
    return InclusionsInMenuCompanion(
      menuId: Value(menuId),
      mealId: Value(mealId),
    );
  }

  factory InclusionInMenu.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InclusionInMenu(
      menuId: serializer.fromJson<int>(json['menuId']),
      mealId: serializer.fromJson<int>(json['mealId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'menuId': serializer.toJson<int>(menuId),
      'mealId': serializer.toJson<int>(mealId),
    };
  }

  InclusionInMenu copyWith({int? menuId, int? mealId}) => InclusionInMenu(
        menuId: menuId ?? this.menuId,
        mealId: mealId ?? this.mealId,
      );
  @override
  String toString() {
    return (StringBuffer('InclusionInMenu(')
          ..write('menuId: $menuId, ')
          ..write('mealId: $mealId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(menuId, mealId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InclusionInMenu &&
          other.menuId == this.menuId &&
          other.mealId == this.mealId);
}

class InclusionsInMenuCompanion extends UpdateCompanion<InclusionInMenu> {
  final Value<int> menuId;
  final Value<int> mealId;
  final Value<int> rowid;
  const InclusionsInMenuCompanion({
    this.menuId = const Value.absent(),
    this.mealId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InclusionsInMenuCompanion.insert({
    required int menuId,
    required int mealId,
    this.rowid = const Value.absent(),
  })  : menuId = Value(menuId),
        mealId = Value(mealId);
  static Insertable<InclusionInMenu> custom({
    Expression<int>? menuId,
    Expression<int>? mealId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (menuId != null) 'menu_id': menuId,
      if (mealId != null) 'meal_id': mealId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InclusionsInMenuCompanion copyWith(
      {Value<int>? menuId, Value<int>? mealId, Value<int>? rowid}) {
    return InclusionsInMenuCompanion(
      menuId: menuId ?? this.menuId,
      mealId: mealId ?? this.mealId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<int>(mealId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InclusionsInMenuCompanion(')
          ..write('menuId: $menuId, ')
          ..write('mealId: $mealId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealRefUrlsTable extends MealRefUrls
    with TableInfo<$MealRefUrlsTable, MealRefUrl> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealRefUrlsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<int> mealId = GeneratedColumn<int>(
      'meal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES meals (id)'));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns => [id, mealId, url];
  @override
  String get aliasedName => _alias ?? 'meal_ref_urls';
  @override
  String get actualTableName => 'meal_ref_urls';
  @override
  VerificationContext validateIntegrity(Insertable<MealRefUrl> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_id')) {
      context.handle(_mealIdMeta,
          mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta));
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealRefUrl map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealRefUrl(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meal_id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $MealRefUrlsTable createAlias(String alias) {
    return $MealRefUrlsTable(attachedDatabase, alias);
  }
}

class MealRefUrl extends DataClass implements Insertable<MealRefUrl> {
  final int id;
  final int mealId;
  final String url;
  const MealRefUrl({required this.id, required this.mealId, required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_id'] = Variable<int>(mealId);
    map['url'] = Variable<String>(url);
    return map;
  }

  MealRefUrlsCompanion toCompanion(bool nullToAbsent) {
    return MealRefUrlsCompanion(
      id: Value(id),
      mealId: Value(mealId),
      url: Value(url),
    );
  }

  factory MealRefUrl.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealRefUrl(
      id: serializer.fromJson<int>(json['id']),
      mealId: serializer.fromJson<int>(json['mealId']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealId': serializer.toJson<int>(mealId),
      'url': serializer.toJson<String>(url),
    };
  }

  MealRefUrl copyWith({int? id, int? mealId, String? url}) => MealRefUrl(
        id: id ?? this.id,
        mealId: mealId ?? this.mealId,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('MealRefUrl(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mealId, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealRefUrl &&
          other.id == this.id &&
          other.mealId == this.mealId &&
          other.url == this.url);
}

class MealRefUrlsCompanion extends UpdateCompanion<MealRefUrl> {
  final Value<int> id;
  final Value<int> mealId;
  final Value<String> url;
  const MealRefUrlsCompanion({
    this.id = const Value.absent(),
    this.mealId = const Value.absent(),
    this.url = const Value.absent(),
  });
  MealRefUrlsCompanion.insert({
    this.id = const Value.absent(),
    required int mealId,
    this.url = const Value.absent(),
  }) : mealId = Value(mealId);
  static Insertable<MealRefUrl> custom({
    Expression<int>? id,
    Expression<int>? mealId,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealId != null) 'meal_id': mealId,
      if (url != null) 'url': url,
    });
  }

  MealRefUrlsCompanion copyWith(
      {Value<int>? id, Value<int>? mealId, Value<String>? url}) {
    return MealRefUrlsCompanion(
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<int>(mealId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealRefUrlsCompanion(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $MenusTable menus = $MenusTable(this);
  late final $MealsTable meals = $MealsTable(this);
  late final $InclusionsInMenuTable inclusionsInMenu =
      $InclusionsInMenuTable(this);
  late final $MealRefUrlsTable mealRefUrls = $MealRefUrlsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [menus, meals, inclusionsInMenu, mealRefUrls];
}
