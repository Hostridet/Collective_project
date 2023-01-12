import 'package:collective_project/models/Soil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../bloc/soil_sorts/soil_sorts_bloc.dart';
import '../../models/Soil.dart';

class AddZonePage extends StatefulWidget {
  int index;
  AddZonePage({Key? key, required this.index}) : super(key: key);

  @override
  State<AddZonePage> createState() => _AddZonePageState();
}

class _AddZonePageState extends State<AddZonePage> {

  late FocusNode zoneFocus;
  late FocusNode soilsFocus;
  late TextEditingController zone;
  late TextEditingController soils;

  @override
  void initState() {
    super.initState();
    zoneFocus = FocusNode();
    soilsFocus = FocusNode();
    zone = TextEditingController();
    soils = TextEditingController();
  }
  @override
  void dispose() {
    zoneFocus.dispose();
    soilsFocus.dispose();
    zone.dispose();
    soils.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed('/home');
          },
        ),
        title: const Text('Добавить зональность'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              maxLines: 1,
              controller: zone,
              autofocus: false,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(zoneFocus);
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.5)),
                hintText: "Название зоны",
                filled: true,
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              maxLines: 2,
              controller: soils,
              autofocus: false,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(soilsFocus);
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.5)),
                hintText: "Типы почв",
                filled: true,
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Soil currSoil;
                    if (zone.text.isNotEmpty && soils.text.isNotEmpty) {
                      Soil currSoil = Soil(id: widget.index, type: zone.text, subType: soils.text);
                      currSoil.save();
                      Navigator.of(context)
                          .pushReplacementNamed('/home');
                    } else {
                      buildErrorLayout("Все поля должны быть заполнены");
                    }
                  },
                  child: Text("Добавить"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  ScaffoldFeatureController buildErrorLayout(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
}
