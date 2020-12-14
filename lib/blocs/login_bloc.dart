import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/helpers/validators.dart';

class LoginBloc extends BlocBase {
  final _firebase = FirebaseAuth.instance;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  LoginState current;
  Stream<String> get outEmail => _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(Validators.validatePassword);
  Stream<LoginState> get outState => _stateController.stream;
  StreamSubscription _stateSubscription;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  LoginBloc(){
    _stateSubscription = _firebase.authStateChanges().listen((user) {
      if(user != null){
        _stateController.add(LoginState.SUCCESS);
      }else{
        //_firebase.signOut();
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit(){
    _stateController.add(LoginState.LOADING);
    _firebase.signInWithEmailAndPassword(
      email: _emailController.value,
      password: _passwordController.value,
    ).catchError((error){
      _stateController.add(LoginState.FAIL);
    }).then((user) => _stateController.add(user == null ? LoginState.FAIL : LoginState.SUCCESS));
  }

  void signOut() {
    _stateController.add(LoginState.LOADING);
    _firebase.signOut();
    _stateController.add(LoginState.IDLE);
  }

  void loginWithFacebook(){

  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _stateSubscription.cancel();
    super.dispose();
  }
}