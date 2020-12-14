import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/forgot_password_bloc.dart';
import 'package:user_register/blocs/login_bloc.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => LoginBloc()),
        Bloc((i) => RegistrationBloc()),
        Bloc((i) => ForgotPasswordBloc()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}