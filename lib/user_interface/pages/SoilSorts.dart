import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../components/DrawerMenu.dart';

class SoilSortsPage extends StatefulWidget {
  const SoilSortsPage({Key? key}) : super(key: key);

  @override
  State<SoilSortsPage> createState() => _SoilSortPageState();
}

class _SoilSortPageState extends State<SoilSortsPage> {
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
        ],
      ),
    );
  }
}
