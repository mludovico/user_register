import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/login_bloc.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/screens/forgot_password_screen.dart';
import 'package:user_register/screens/home_screen.dart';
import 'package:user_register/screens/register_screen.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginBloc _bloc;
  StreamSubscription _subscription;
  bool passwordObscure = true;

  @override
  void initState() {
    _bloc = BlocProvider.getBloc<LoginBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _subscription = _bloc.outState.listen((event) {
      switch(event) {
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Credenciais inválidas'),
              content: Text('Não foi possível fazer login com as credenciais fornecidas ou o usuário não tem acesso ao conteúdo.'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          break;
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeScreen())
          );
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.translate,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<LoginState>(
        stream: _bloc.outState,
        builder: (context, snapshot) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      iconData: Icons.person_outline,
                      stream: _bloc.outEmail,
                      hint: 'Email',
                      onChanged: _bloc.changeEmail,
                      obscure: false,
                    ),
                    InputField(
                      iconData: Icons.lock_outline,
                      stream: _bloc.outPassword,
                      hint: 'Password',
                      onChanged: _bloc.changePassword,
                      obscure: passwordObscure,
                      suffix: IconButton(
                        icon: Icon(passwordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          child: Text(
                            'Esqueci a senha',
                            style: TextStyle(
                              color: primary
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => ForgotPasswordScreen())
                            );
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Não tenho uma conta',
                            style: TextStyle(
                              color: primary,
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => RegisterScreen())
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RaisedButton(
                        child: Text('Entrar'),
                        onPressed: _bloc.submit,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text(
                          'Entrar com Google',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onPressed: _bloc.loginWithGoogle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RaisedButton(
                        color: Color(0xff3b5998),
                        child: Text(
                          'Entrar com Facebook',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        onPressed: _bloc.loginWithFacebook
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !snapshot.hasData
                ?
                  false
                :
                  snapshot.data == LoginState.LOADING,
                child: Container(
                  color: Color(0x90000000),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primary),
                    ),
                  ),
                ),
              ),
            ]
          );
        }
      ),
    );
  }

  togglePasswordVisibility(){
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }
}
