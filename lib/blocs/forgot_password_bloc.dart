import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/helpers/validators.dart';

class ForgotPasswordBloc extends BlocBase {

  final _firebase = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _stateController = BehaviorSubject<LoginState>();
  final _emailController = BehaviorSubject<String>();
  final _cpfController = BehaviorSubject<String>();
  Stream<LoginState> get outState => _stateController.stream;
  Stream<String> get outEmail => _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get outCpf => _cpfController.stream.transform(Validators.validateCpf);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;

  ForgotPasswordBloc(){
    _stateController.add(LoginState.IDLE);
  }

  void passwordRecover() async {
    _stateController.add(LoginState.LOADING);
    QuerySnapshot user = await _firestore.collection('users')
      .where('email', isEqualTo: _emailController.value)
      .where('cpf', isEqualTo: _cpfController.value)
      .get();
    if(user.size > 0) {
      await _firebase.sendPasswordResetEmail(email: _emailController.value)
        .catchError((error) {
          print(error);
          _stateController.add(LoginState.FAIL);
          return;
        });
      _stateController.add(LoginState.SUCCESS);
    }else{
      _stateController.add(LoginState.FAIL);
    }
  }

  @override
  void dispose() {
    _stateController.close();
    _emailController.close();
    _cpfController.close();
    super.dispose();
  }
}