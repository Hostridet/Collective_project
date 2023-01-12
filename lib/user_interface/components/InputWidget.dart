import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/classifier_bloc/classifier_bloc.dart';
import '../../models/Soil.dart';

class InputWidget extends StatefulWidget {
  List<Soil> soil;
  InputWidget({Key? key, required this.soil}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  List<String> podzolType = ["Неподзолистые", "Слабоподзолистые", "Среднеподзолистые", "Сильноподзолистые"];
  List<String> saltType = ["Незасоленные", "Слабозасоленные", "Среднезасоленные", "Сильно засоленные", "Очень сильно засоленные"];
  late String currentSalt;
  late String currentPodzol;
  late Soil currSoil;

  late FocusNode humusFocus;
  late FocusNode humusHorizonFocus;
  late FocusNode turfFocus;
  late FocusNode acidFocus;
  late TextEditingController humusHorizon;
  late TextEditingController humus;
  late TextEditingController turf;
  late TextEditingController  acid;

  @override
  void initState() {
    super.initState();
    humusFocus = FocusNode();
    humusHorizonFocus = FocusNode();
    turfFocus = FocusNode();
    acidFocus = FocusNode();
    humus = TextEditingController();
    humusHorizon = TextEditingController();
    turf = TextEditingController();
    acid = TextEditingController();
  }

  @override
  void dispose() {
    humusFocus.dispose();
    humusHorizonFocus.dispose();
    turfFocus.dispose();
    acidFocus.dispose();
    humus.dispose();
    humusHorizon.dispose();
    turf.dispose();
    acid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentSalt = saltType.first;
    currentPodzol = podzolType.first;
    currSoil = widget.soil[0];
    List<String> typeList = [];
    for (Soil item in widget.soil) {
      typeList.add(item.type);
    }
    return ListView(
      shrinkWrap: true,
      children: [
        Text("Зональность"),
        DropdownSearch(
          selectedItem: typeList.first,
          mode: Mode.BOTTOM_SHEET,
          showSearchBox: true,
          showSelectedItems: true,
          items: typeList,
          searchFieldProps: const TextFieldProps(
            cursorColor: Colors.blue,
          ),
          onChanged: (String? value) {
            currSoil = widget.soil[typeList.indexOf(value!)];
          },
        ),
        SizedBox(height: 10),
        Text("Степень подзолитости почвы"),
        DropdownSearch(
          selectedItem: currentPodzol,
          mode: Mode.MENU,
          showSearchBox: false,
          showSelectedItems: true,
          items: podzolType,
          searchFieldProps: const TextFieldProps(
            cursorColor: Colors.blue,
          ),
          onChanged: (String? value) {
            currentPodzol = value!;
          },
        ),
        SizedBox(height: 10),
        Text("Степень засоленности почвы"),
        DropdownSearch(
          selectedItem: currentSalt,
          mode: Mode.MENU,
          showSearchBox: false,
          showSelectedItems: true,
          items: saltType,
          searchFieldProps: const TextFieldProps(
            cursorColor: Colors.blue,
          ),
          onChanged: (String? value) {
            currentSalt = value!;
          },
        ),
        SizedBox(height: 10),
        Text("Содержание гумуса в почве"),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          controller: humus,
          autofocus: false,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(humusFocus);
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: "Содержание гумуса в %",
            filled: true,
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 10),
        Text("Мощность гумусового горизонта"),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          controller: humusHorizon,
          autofocus: false,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(humusHorizonFocus);
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: "Мощность гумусового горизонта в см",
            filled: true,
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 10),
        Text("Мощность дернового слоя"),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          controller: turf,
          autofocus: false,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(turfFocus);
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: "Мощность дернового в см",
            filled: true,
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 10),
        Text("Степень кислотности почвы"),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          controller: acid,
          autofocus: false,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(acidFocus);
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.5)),
            hintText: "Степерь кислотности почвы",
            filled: true,
            fillColor: Colors.transparent,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (acid.text.isNotEmpty && turf.text.isNotEmpty && humus.text.isNotEmpty && humusHorizon.text.isNotEmpty) {
                showAlertDialog(context, acid.text, turf.text, humusHorizon.text, humus.text, currSoil);
              }
              else {
                buildErrorLayout("Необходимо заполнить все поля");
              }
            },
            child: Text("Классифицировать"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
        ),
      ],
    );
  }
  showAlertDialog(BuildContext context, String acid, String turf, String humusHorizon, String humus, Soil soil) {

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Классификатор"),
      content: Text("${soil.subType} ${currentPodzol.toLowerCase()} ${currentSalt.toLowerCase()} ${getHumus(humus)} ${getTurf(turf)}"
          " ${getHumusHorizon(humusHorizon)} ${getAcid(acid)} почвы"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  String getHumus(String humus) {
    int humusInt = int.parse(humus);
    String result = "";
    if (humusInt < 1) {
      result = "малогумусные";
    }
    else {
      if (humusInt >= 1 && humusInt <= 3) {
        result = "среднегумусные";
      }
      else {
        if (humusInt > 3 && humusInt < 5) {
          result = "многогумусные";
        }
        else {
          result = "тучные";
        }
      }
    }
    return result;
  }
  String getHumusHorizon(String humusHorizon) {
    int humusInt = int.parse(humusHorizon);
    String result = "";
    if (humusInt < 40) {
      result = "маломощные";
    }
    else {
      if (humusInt >=40 && humusInt < 120) {
        result = "мощные";
      }
      else {
        result = "сверхмощные";
      }
    }
    return result;
  }

  String getTurf(String turf) {
    int turfInt = int.parse(turf);
    String result = "";
    if (turfInt < 10) {
      result = "слабодерновые";
    }
    else {
      if (turfInt >= 10 && turfInt <= 15) {
        result = "среднедерновые";
      }
      else {
        result = "глубокодерновые";
      }
    }
    return result;
  }

  String getAcid(String acid) {
    int acidInt = int.parse(acid);
    String result = "";
    if (acidInt < 5) {
      result = "кислые";
    }
    else {
      if (acidInt > 5 && acidInt <= 6) {
        result = "слабокислые";
      }
      else {
        if (acidInt > 6 && acidInt < 7) {
          result = "нейтральные";
        }
        else {
          result = "щелочные";
        }
      }
    }
    return result;
  }
  ScaffoldFeatureController buildErrorLayout(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
}
