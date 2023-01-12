import 'package:collective_project/user_interface/pages/AddZonePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/soil_sorts/soil_sorts_bloc.dart';
import '../../models/Soil.dart';
import '../../repository/SoilRepository.dart';
import '../components/DrawerMenu.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../components/InputFieldWidget.dart';

class SoilSortsPage extends StatefulWidget {
  const SoilSortsPage({Key? key}) : super(key: key);

  @override
  State<SoilSortsPage> createState() => _SoilSortPageState();
}

class _SoilSortPageState extends State<SoilSortsPage> {

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
                    SizedBox(height: 10),
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
              if (state is SoilLoadedAdminState) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: ListTile(
                          title: Text("Добавить"),
                          subtitle: Text("Добавить зональность"),
                          leading: Icon(Icons.add),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>AddZonePage(index: state.count),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
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
                          itemBuilder: (BuildContext context, int index, ) {
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
                                  onTap: () {
                                    showAlertDialog(context, state.soilList[index].type, state.soilList[index].subType);
                                  },
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
  showAlertDialog(BuildContext context, String curZone, String curSoils) {

    // set up the button

    Widget closeButton = TextButton(
      child: Text("Закрыть"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(curZone),
      content: Text(curSoils),
      actions: [
        closeButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
