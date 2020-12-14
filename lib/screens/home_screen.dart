import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/login_bloc.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  LoginBloc _bloc;
  StreamSubscription subscription;

  @override
  void initState() {
    _bloc = BlocProvider.getBloc<LoginBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    subscription = _bloc.outState.listen((event) {
      switch(event){
        case LoginState.IDLE:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen())
          );
          break;
        case LoginState.LOADING:
        case LoginState.SUCCESS:
        case LoginState.FAIL:
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _bloc.signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            'Bem vindo à tela inicial',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
