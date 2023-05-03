import "package:meal_logger/dtos/meal_ref_url.dart";

class Meal {
  int? id;
  String name;
  DateTime? lastCookedDate;
  DateTime? createdAt;
  List<MealRefUrl> refUrls = [];
  String imagePathInAppDoc;
  String imageFullPath;

  // idを指定しない場合、新規追加になる
  Meal({this.id,
        this.name = "",
        this.lastCookedDate,
        this.createdAt,
        List<MealRefUrl>? refUrls,
        this.imagePathInAppDoc = "",
        this.imageFullPath = ""}) : refUrls = refUrls ?? [];
}