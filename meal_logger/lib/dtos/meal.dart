import 'package:meal_logger/databases/database.dart';

class Meal {
  int? id;
  String name;
  DateTime? lastCookedDate;
  DateTime? createdAt;
  List<String> refUrls = [];
  final String imagePath;

  // 保存する料理写真の一時パス
  String savedImgTmpPath;

  // idを指定しない場合、新規追加になる
  Meal({this.id,
        this.name = "",
        this.lastCookedDate,
        this.createdAt,
        List<String>? refUrls,
        this.imagePath = "",
        this.savedImgTmpPath = ""}) : refUrls = refUrls ?? [];
}