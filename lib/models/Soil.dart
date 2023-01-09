import 'package:shared_preferences/shared_preferences.dart';

class Soil {
  int id;
  String type;
  String subType;
  String genus;
  String sort;
  String varieties;
  String category;
  Soil({
    required this.id,
    required this.type,
    required this.subType,
    required this.genus,
    required this.sort,
    required this.varieties,
    required this.category,
  });

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$type/$subType/"
        "$genus/$sort/$varieties/$category";
    await prefs.setString('soil + ${id.toString()}', savedString);
  }

  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$type/$subType/"
        "$genus/$sort/$varieties/$category";
    await prefs.setString('soil + ${id.toString()}', savedString);
  }

  static Future<Soil> getSoilById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("soil + ${id.toString()}") != null
        ? value = prefs.getString("soil + ${id.toString()}")
        : value = "0/null/null/null/null/null/null";
    List<String> valueList = value!.split("/");
    return (Soil(
      id: int.parse(valueList[0]),
      type: valueList[1],
      subType: valueList[2],
      genus: valueList[3],
      sort: valueList[4],
      varieties: valueList[5],
      category: valueList[6],
    ));
  }
}