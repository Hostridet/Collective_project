import '../components/DrawerMenu.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortClassifierPage extends StatefulWidget {
  const SortClassifierPage({Key? key}) : super(key: key);

  @override
  State<SortClassifierPage> createState() => _SortClassifierPageState();
}

class _SortClassifierPageState extends State<SortClassifierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Классификатор'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
    );
  }
}
