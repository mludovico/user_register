import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/screens/home_screen.dart';
import 'package:user_register/screens/widgets/address_list_view.dart';
import 'package:user_register/screens/widgets/input_field.dart';
import 'package:user_register/screens/widgets/phone_list_view.dart';

class RegisterScreen extends StatefulWidget {

  final email;
  RegisterScreen({this.email});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController _birthDateController = TextEditingController(text: '');
  bool passwordObscure = true;
  RegistrationBloc _bloc;
  StreamSubscription subscription;

  @override
  void initState() {
    _bloc = BlocProvider.getBloc<RegistrationBloc>();
    if(widget.email != null) {
      print(widget.email);
      _bloc.changeEmail(widget.email);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    subscription = _bloc.outState.listen((event) async {
      switch(event) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Erro no cadastro'),
              content: Text('Ocorreu um erro ao cadastrar usuário. Tente novamente mais tarde.'),
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
        case LoginState.IDLE:
        case LoginState.LOADING:
        default:
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
        title: Text('Cadastro'),
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
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primary),
            );
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      iconData: Icons.person_outline,
                      stream: _bloc.outName,
                      hint: 'Nome',
                      onChanged: _bloc.changeName,
                      obscure: false,
                    ),
                    InputField(
                      iconData: Icons.calendar_today_outlined,
                      stream: _bloc.outBirth,
                      hint: 'Data de nascimento',
                      onChanged: _bloc.changeBirthDate,
                      obscure: false,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      iconData: Icons.wysiwyg_outlined,
                      stream: _bloc.outCpf,
                      hint: 'CPF',
                      onChanged: _bloc.changeCpf,
                      obscure: false,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      iconData: Icons.mail_outline,
                      stream: _bloc.outEmail,
                      hint: 'Email',
                      onChanged: _bloc.changeEmail,
                      obscure: false,
                      controller: TextEditingController(text: widget.email == null ? '' : widget.email),
                    ),
                    InputField(
                      iconData: Icons.lock_outline,
                      stream: _bloc.outPassword,
                      hint: 'Senha',
                      onChanged: _bloc.changePassword,
                      obscure: passwordObscure,
                      suffix: IconButton(
                        icon: Icon(passwordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    InputField(
                      iconData: Icons.lock_outline,
                      stream: _bloc.outPasswordCheck,
                      hint: 'Digite a senha novamente',
                      onChanged: _bloc.changePasswordCheck,
                      obscure: passwordObscure,
                      suffix: IconButton(
                        icon: Icon(passwordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    PhoneListView(
                      iconData: Icons.phone,
                      bloc: _bloc,
                      label: 'Telefones',
                      onAdd: (){},
                    ),
                    AddressListView(
                      iconData: Icons.location_on_outlined,
                      bloc: _bloc,
                      label: 'Endereços',
                      onAdd: (){},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RaisedButton(
                        child: Text('Cadastrar'),
                        onPressed: _bloc.submitWithEmail,
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

  void togglePasswordVisibility(){
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }
}
