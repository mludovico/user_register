import 'package:flutter/material.dart';
import 'package:user_register/screens/forgot_password_screen.dart';
import 'package:user_register/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Awesome Registration App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
          ),
          IconButton(
            icon: Icon(Icons.translate),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'E-mail'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              ),
              Row(
                children: [
                  FlatButton(
                    child: Text('Esqueci a senha'),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ForgotPasswordScreen())
                      );
                    },
                  ),
                  FlatButton(
                    child: Text('Não tenho uma conta'),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegisterScreen())
                      );
                    },
                  ),
                ],
              ),
              RaisedButton(
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
