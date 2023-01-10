

import '../models/Soil.dart';

class SoilRepository {


  Future<List<Soil>> getAllSoils() async {
    bool flag = false;
    List<Soil> soilList = [];
    int index = 0;
    while (flag != true) {
      Soil curSoil = await Soil.getSoilById(index);
      if (curSoil.type == "null") {
        flag = true;
      }
      else {
        if (curSoil.id != -1) {
          soilList.add(curSoil);
        }
        index++;
      }
    }
    return soilList;
  }
  Future<void> deleteSoil(Soil soil) async {
    return soil.delete();
  }

  Future<int> getCount() async {
    int index = 0;
    bool flag = false;
    while(flag == false) {
      Soil curSoil = await Soil.getSoilById(index);
      if (curSoil.type == "null") {
        flag = true;
      }
      else {
        index++;
      }
    }
    return index;
  }

}