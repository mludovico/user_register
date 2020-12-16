import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/helpers/validators.dart';

class LoginBloc extends BlocBase {
  final _firebase = FirebaseAuth.instance;
  final _userController = BehaviorSubject<User>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  Stream<User> get outUser => _userController.stream;
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
        _userController.add(user);
      }else{
        //_firebase.signOut();
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit() async {
    _stateController.add(LoginState.LOADING);
    try {
      final UserCredential userCredential = await _firebase.signInWithEmailAndPassword(
        email: _emailController.value,
        password: _passwordController.value,
      );
      final User user = userCredential.user;
      if(user != null) {
        _stateController.add(LoginState.SUCCESS);
        _userController.add(user);
      } else
        _stateController.add(LoginState.FAIL);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      _stateController.add(LoginState.FAIL);
    }
  }

  void signOut() {
    _stateController.add(LoginState.LOADING);
    _firebase.signOut();
    _stateController.add(LoginState.IDLE);
  }

  void loginWithFacebook() async {
    _stateController.add(LoginState.LOADING);
    try{
      final FacebookLogin facebookLogin = FacebookLogin();
      final FacebookLoginResult facebookLoginResult
        = await facebookLogin.logIn(
          permissions: [
            FacebookPermission.publicProfile,
            FacebookPermission.email,
          ]
        );
      if(facebookLoginResult.status == FacebookLoginStatus.Success) {
        final AuthCredential credential
          = FacebookAuthProvider.credential(facebookLoginResult.accessToken.token);
        final UserCredential userCredential = await _firebase.signInWithCredential(credential);
        User user = userCredential.user;
        if(user != null)
          _stateController.add(LoginState.SUCCESS);
        else
          _stateController.add(LoginState.FAIL);
      }
    }catch(e, stackTrace){
      print(e);
      print(stackTrace);
      _stateController.add(LoginState.IDLE);
    }
  }

  void loginWithGoogle() async {
    _stateController.add(LoginState.LOADING);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount
        = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication
        = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      final UserCredential userCredential
        = await _firebase.signInWithCredential(credential);

      final User user = userCredential.user;
      if(user != null)
        _stateController.add(LoginState.SUCCESS);
      else
        _stateController.add(LoginState.FAIL);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      _stateController.add(LoginState.IDLE);
    }
  }

  @override
  void dispose() {
    _userController.close();
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _stateSubscription.cancel();
    super.dispose();
  }
}