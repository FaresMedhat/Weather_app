import 'package:hive/hive.dart';

class HiveModel {
  static final box = Hive.box("weatherCity");
  Future<void> saveCityName(String cityName) async {
    await box.put('cityName', cityName);
  }

  String? getCityName() {
    return box.get('cityName');
  }
}
