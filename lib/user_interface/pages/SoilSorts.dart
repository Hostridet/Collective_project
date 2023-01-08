import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../../models/Soil.dart';
import '../components/DrawerMenu.dart';

class SoilSortsPage extends StatefulWidget {
  const SoilSortsPage({Key? key}) : super(key: key);

  @override
  State<SoilSortsPage> createState() => _SoilSortPageState();
}

class _SoilSortPageState extends State<SoilSortsPage> {
  Soil currSoil = Soil(id: 0, type: "Арг", subType: "Арг", genus: "Арг", sort: "Арг", varieties: "Арг", category: "Арг");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Виды почв'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Добавить новый вид почвы"),
            leading: Icon(Icons.add),
            onTap: () {},
          ),
          Divider(),
          FutureBuilder<Soil>(
              future: getValue(),
              builder: (BuildContext context, AsyncSnapshot<Soil> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.category);
                }
                return Text("null");
              }
          ),
        ],
      ),
    );
  }
  Future<Soil> getValue() async {
    currSoil.save();
    return Soil.getSoilById(0);
  }
}
