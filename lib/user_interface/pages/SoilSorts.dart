import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/soil_sorts/soil_sorts_bloc.dart';
import '../../models/Soil.dart';
import '../../repository/SoilRepository.dart';
import '../components/DrawerMenu.dart';

class SoilSortsPage extends StatefulWidget {
  const SoilSortsPage({Key? key}) : super(key: key);

  @override
  State<SoilSortsPage> createState() => _SoilSortPageState();
}

class _SoilSortPageState extends State<SoilSortsPage> {

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SoilRepository(),
      child: BlocProvider<SoilSortsBloc>(
        create: (context) => SoilSortsBloc(
          RepositoryProvider.of<SoilRepository>(context),
        )..add(SoilGetEvent()),
        child: Scaffold(
          drawer: DrawerMenu(),
          appBar: NewGradientAppBar(
            title: const Text('Виды почв'),
            gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
          ),
          body: BlocBuilder<SoilSortsBloc, SoilSortsState>(
            builder: (context, state) {
              if (state is SoilLoadingState) {
                return CircularProgressIndicator();
              }
              if (state is SoilLoadedState) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: ListTile(
                          title: Text("Добавить"),
                          subtitle: Text("Добавить новый вид почвы"),
                          leading: Icon(Icons.add),
                          onTap: () {
                            Soil currSoil = Soil(id: 0, type: "Арг", subType: "Арг", genus: "Арг", sort: "Арг",
                                varieties: "Арг", category: "Арг");
                            currSoil.save();
                            BlocProvider.of<SoilSortsBloc>(context)
                                .add(SoilGetEvent());
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.soilList.length,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(state.soilList[index].type),
                              onTap: () {
                                BlocProvider.of<SoilSortsBloc>(context)
                                    .add(SoilDeleteEvent(state.soilList[index]));
                              },
                            ),
                          );
                        },
                    ),
                  ],
                );
              }
              return Container();

            },
          ),
        ),
      ),
    );
  }
}
