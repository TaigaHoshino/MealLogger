import 'package:meal_logger/databases/database.dart';

class Meal {
  int? id;
  String name = "";
  DateTime lastCookedDate;
  DateTime createdAt;
  List<String> refUrls = [];
  String imagePath = "";

  // idを指定しない場合、新規追加になる
  Meal(this.name, this.lastCookedDate, this.createdAt, {this.id, required this.imagePath, required this.refUrls});
}