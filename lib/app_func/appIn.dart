import 'package:flutter/material.dart';
import '../bloc/theme_bloc/theme_bloc.dart';
import '../user_interface/pages/HomePage.dart';
import '../user_interface/routes/RouteGenerator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc()..add(ThemeCheckEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeDarkState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData.dark(),
              initialRoute: "/",
              onGenerateRoute: RouteGenerator().generateRoute,
            );
          }
          if (state is ThemeWhiteState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: "/",
              onGenerateRoute: RouteGenerator().generateRoute,
            );
          }
          return Container();
        }
      ),
    );
  }
}