
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Soil.dart';

class ClassifierRepository {
  Future<List<Soil>> getAllSoils() async {
    final prefs = await SharedPreferences.getInstance();
    List<Soil> soilList = [];
    int index = 0;
    bool flag = false;
    while(flag == false) {
      Soil curSoil = await Soil.getSoilById(index);
      if (curSoil.type != "null") {
        if (curSoil.id != -1) {
          soilList.add(curSoil);
        }
        index++;
      }
      else {
        flag = true;
      }
    }
    return soilList;
  }
}