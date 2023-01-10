import 'package:shared_preferences/shared_preferences.dart';

class Soil {
  int id;
  String type;
  String subType;
  Soil({
    required this.id,
    required this.type,
    required this.subType,
  });

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$type/$subType";
    await prefs.setString('soil + ${id.toString()}', savedString);
  }

  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$type/$subType";
    await prefs.setString('soil + ${id.toString()}', savedString);
  }

  static Future<Soil> getSoilById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("soil + ${id.toString()}") != null
        ? value = prefs.getString("soil + ${id.toString()}")
        : value = "0/null/null";
    List<String> valueList = value!.split("/");
    return (Soil(
      id: int.parse(valueList[0]),
      type: valueList[1],
      subType: valueList[2],
    ));
  }
}