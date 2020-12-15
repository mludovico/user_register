import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/forgot_password_bloc.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/screens/register_screen.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  ForgotPasswordBloc _bloc;
  StreamSubscription _subscription;


  @override
  void initState() {
    _bloc = BlocProvider.getBloc<ForgotPasswordBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _subscription = _bloc.outState.listen((event) async {
      switch(event){

        case LoginState.SUCCESS:
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Recuperação de senha'),
              content: Text('Verifique a caixa do email fornecido para obter as instruções de recuperação de senha.'),
            )
          );
          Navigator.of(context).pop();
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Erro na recuperação'),
              content: Text('Não foi possível verificar as informações.'),
              actions: [
                StreamBuilder<String>(
                  stream: _bloc.outEmail,
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                      return FlatButton(
                        child: Text('Cadastrar'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => RegisterScreen(email: snapshot.data))
                          );
                        },
                      );
                    else
                      return Container();
                  }
                ),
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
        case LoginState.IDLE:
        case LoginState.LOADING:
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
        title: Text('Recuperação de senha'),
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
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primary),
              ),
            );
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      iconData: Icons.mail_outline,
                      hint: 'E-mail',
                      stream: _bloc.outEmail,
                      obscure: false,
                      onChanged: _bloc.changeEmail,
                    ),
                    InputField(
                      iconData: Icons.wysiwyg_outlined,
                      hint: 'CPF',
                      stream: _bloc.outCpf,
                      obscure: false,
                      onChanged: _bloc.changeCpf,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                      child: RaisedButton(
                        child: Text('Recuperar senha'),
                        onPressed: _bloc.passwordRecover,
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
              ),            ]
          );
        }
      ),
    );

  }
}
