import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
                  labelText: 'Nome'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Data de nascimento'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CPF'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Endereço'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Telefone'
                ),
              ),
              RaisedButton(
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
