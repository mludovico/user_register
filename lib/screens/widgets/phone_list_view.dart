import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/helpers/formatters.dart';
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                iconData,
                color: primary,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600]
                  ),
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: Icon(
                Icons.add,
                color: primary,
              ),
              onPressed: bloc.addPhone,
            ),
          ]
        ),
        StreamBuilder<List<String>>(
          stream: bloc.outPhone,
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Container();
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                final selection = TextSelection.collapsed(offset: snapshot.data[index].length);
                return InputField(
                  hint: 'Telefone',
                  obscure: false,
                  formatters: [
                    Formatters.phoneFormatter,
                  ],
                  controller: TextEditingController(
                    text: snapshot.data[index],
                  )..selection = selection,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => bloc.changePhone(index, value),
                );
              });
          },
        ),
      ],
    );
  }
}
