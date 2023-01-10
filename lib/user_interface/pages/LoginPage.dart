import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../repository/AuthRepository.dart';
import '../components/InputFieldWidget.dart';
import '../components/LoginButtonWidget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  clearTextData() {
    userName.clear();
    password.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RepositoryProvider(
          create: (context) => AuthRepository(),
          child: BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              RepositoryProvider.of<AuthRepository>(context),
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthEmptyError) {
                    buildErrorLayout("Ввдетие логин или пароль");
                  }
                  if (state is AuthWrongDataError) {
                    buildErrorLayout("Неверный логин или пароль");
                  }
                  if (state is AuthLoaded) {
                    clearTextData();
                    Navigator.of(context)
                        .pushReplacementNamed('/home');
                  }
                },
                builder: (context, state) {
                  return buildInitialInput();
                }
            ),
          ),
        )
    );
  }
  Widget buildInitialInput() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 150),
        SvgPicture.asset(
          "assets/logo.svg",
          height: 100,
          width: 100,
        ),
        SizedBox(height: 25),
        InputField(
          focusNode: usernameFocus,
          textController: userName,
          label: "Логин",
          icons: const Icon(Icons.person, color: Colors.green),
        ),
        SizedBox(height: 25),
        InputField(
          focusNode: passwordFocus,
          textController: password,
          label: "Пароль",
          icons: const Icon(Icons.lock, color: Colors.green),
        ),
        SizedBox(height: 25),
        LoginButton(
          focusNode: loginBtnFocus,
          userName: userName,
          password: password,
        ),
        SizedBox(height: 25),
      ],
    ),
  );

  ScaffoldFeatureController buildErrorLayout(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );

}