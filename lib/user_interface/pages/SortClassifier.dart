import 'package:collective_project/user_interface/components/InputWidget.dart';

import '../../bloc/classifier_bloc/classifier_bloc.dart';
import '../../models/Soil.dart';
import '../../repository/ClassifierRepository.dart';
import '../components/DrawerMenu.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SortClassifierPage extends StatefulWidget {
  const SortClassifierPage({Key? key}) : super(key: key);

  @override
  State<SortClassifierPage> createState() => _SortClassifierPageState();
}

class _SortClassifierPageState extends State<SortClassifierPage> {
  late Soil currSoil;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Классификатор'),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider<ClassifierRepository>(
          create: (context) => ClassifierRepository(),
          child: BlocProvider<ClassifierBloc>(
            create: (context) =>
                ClassifierBloc(
                  RepositoryProvider.of<ClassifierRepository>(context),
                )..add(ClassifierGetSoils()),
            child: BlocBuilder<ClassifierBloc, ClassifierState>(
              builder: (context, state) {
                if (state is ClassifierLoadedState) {
                  currSoil = state.soilList[0];
                  List<String> typeList = [];
                  for (Soil item in state.soilList) {
                    typeList.add(item.type);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InputWidget(soil: state.soilList),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          )
      ),
    );
  }
}
