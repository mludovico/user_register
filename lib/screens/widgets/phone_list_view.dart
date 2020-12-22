import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class PhoneListView extends StatelessWidget {

    final RegistrationBloc bloc;
    final String label;
    final IconData iconData;
    final void Function() onAdd;
    PhoneListView({this.bloc, this.label, this.iconData, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: primary,
          ),
          title: Text(
            label,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add,
              color: primary,
            ),
            onPressed: bloc.addPhone,
          ),
        ),
        StreamBuilder<List<String>>(
          stream: bloc.outPhone,
          builder: (context, snapshot) {
            if(snapshot.hasData)
              return ListView(
                children: snapshot.data.map((item){
                  return Column(
                    children: [
                      InputField(
                        hint: 'Telefone',
                        iconData: iconData,
                        obscure: false,
                        formatters: [
                          CepInputFormatter(),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              );
            else
              return Container();
          },
        ),
      ],
    );
  }
}
