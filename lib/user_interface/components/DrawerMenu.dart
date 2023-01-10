import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(UserLoadEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            return Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xff228B22),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            backgroundColor: Colors.brown,
                            child: Text("${state.name[0]}${state.patronymic[0]}"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(state.surname,
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.name,
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 5),
                            Text(state.patronymic,
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.history, size: 30, color: Colors.orange),
                    ),
                    title: Text("История"),
                    subtitle: Text("История классификатора"),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.settings, size: 30, color: Colors.grey),
                    ),
                    title: Text("Настройки"),
                    subtitle: Text("Настройки приложения"),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/home/settings');
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.exit_to_app, size: 30, color: Colors.red),
                    ),
                    title: Text("Выйти"),
                    subtitle: Text("Выйти из аккаунта"),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                  ),
                  Divider(),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
