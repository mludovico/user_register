import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/models/address.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class AddressListView extends StatelessWidget {

  final RegistrationBloc bloc;
  final String label;
  final IconData iconData;
  final void Function() onAdd;
  AddressListView({this.bloc, this.label, this.iconData, this.onAdd});

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
                onPressed: bloc.addressList.length < 3 ? bloc.addAddress : null,
              ),
            ]
        ),
        StreamBuilder<List<Address>>(
          stream: bloc.outAddress,
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Container();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: snapshot.data.map((item){
                return Column(
                  children: [
                    InputField(
                      hint: 'CEP',
                      obscure: false,
                      formatters: [
                        CepInputFormatter(),
                      ],
                      suffix: IconButton(
                        icon: Icon(Icons.search),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      hint: 'Endereço',
                      obscure: false,
                    ),
                    InputField(
                      hint: 'Número',
                      obscure: false,
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      hint: 'Complemento',
                      obscure: false,
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
