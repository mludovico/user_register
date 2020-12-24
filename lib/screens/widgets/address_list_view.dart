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
                onPressed: bloc.addAddress,
              ),
            ]
        ),
        StreamBuilder<List<Address>>(
          stream: bloc.outAddress,
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Container();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputField(
                      hint: 'CEP',
                      obscure: false,
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(zip: value),
                      ),
                      formatters: [
                        CepInputFormatter(),
                      ],
                      suffix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => bloc.getAddressFromZip(index),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      hint: 'Endereço',
                      obscure: false,
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(address: value),
                      ),
                    ),
                    InputField(
                      hint: 'Número',
                      obscure: false,
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(number: int.tryParse(value)??0),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      hint: 'Complemento',
                      obscure: false,
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(complement: value),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
