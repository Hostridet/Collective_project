import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/soil_sorts/soil_sorts_bloc.dart';
import '../../models/Soil.dart';
import '../../repository/SoilRepository.dart';
import '../components/DrawerMenu.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            title: const Text('Зональность'),
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
                          subtitle: Text("Добавить зональность"),
                          leading: Icon(Icons.add),
                          onTap: () {
                            Soil currSoil = Soil(id: state.count, type: "Тундра", subType: "Тундровые");
                            currSoil.save();
                            BlocProvider.of<SoilSortsBloc>(context)
                                .add(SoilGetEvent());
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.soilList.length,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed:  (_) {
                                      BlocProvider.of<SoilSortsBloc>(context)
                                          .add(SoilDeleteEvent(state.soilList[index]));
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Удалить',
                                  ),
                                ],
                              ),
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(state.soilList[index].type),
                                  subtitle: Text("Типы почв: ${state.soilList[index].subType}"),
                                  onTap: () {},
                                ),
                              ),
                            );
                          },
                      ),
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
