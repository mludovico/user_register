import 'package:flutter/material.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/helpers/formatters.dart';
import 'package:user_register/models/address.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class AddressListView extends StatelessWidget {

  final RegistrationBloc bloc;
  final String label;
  final IconData iconData;
  final void Function() onAdd;
  AddressListView({this.bloc, this.label, this.iconData, this.onAdd});

  Map<String, List<FocusNode>> focusNodes = {
    'zip': [],
    'number': [],
  };

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
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                focusNodes['zip'].add(FocusNode()..requestFocus());
                focusNodes['number'].add(FocusNode());
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    index > 0 ? Divider() : Container(),
                    Text('Endereço ${index + 1}'),
                    InputField(
                      hint: 'CEP',
                      obscure: false,
                      focusNode: focusNodes['zip'][index],
                      controller: TextEditingController(
                        text: snapshot.data[index].zip
                      )..selection = TextSelection.collapsed(offset: snapshot.data[index].zip.length),
                      onChanged: (value) => bloc.changeAddress(index, Address(zip: value)),
                      formatters: [
                        Formatters.zipFormatter,
                      ],
                      suffix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          bloc.getAddressFromZip(index);
                          focusNodes['zip'][index].unfocus(disposition: UnfocusDisposition.scope);
                          focusNodes['number'][index].requestFocus();
                        },
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      hint: 'Endereço',
                      obscure: false,
                      controller: TextEditingController(
                        text: snapshot.data[index].address
                      )..selection = TextSelection.collapsed(
                        offset: snapshot.data[index].address.length,
                      ),
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(address: value),
                      ),
                    ),
                    InputField(
                      hint: 'Número',
                      obscure: false,
                      focusNode: focusNodes['number'][index],
                      controller: TextEditingController(
                        text: snapshot.data[index].number.toString()
                      )..selection = TextSelection.collapsed(
                        offset: snapshot.data[index].number.toString().length,
                      ),
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(number: int.tryParse(value)??0),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    InputField(
                      hint: 'Complemento',
                      obscure: false,
                      controller: TextEditingController(
                        text: snapshot.data[index].complement
                      )..selection = TextSelection.collapsed(
                        offset: snapshot.data[index].complement.length
                      ),
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(complement: value),
                      ),
                    ),
                    InputField(
                      hint: 'Bairro',
                      obscure: false,
                      controller: TextEditingController(
                        text: snapshot.data[index].district
                      )..selection = TextSelection.collapsed(
                        offset: snapshot.data[index].district.length
                      ),
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(district: value),
                      ),
                    ),
                    InputField(
                      hint: 'Cidade',
                      obscure: false,
                      controller: TextEditingController(
                        text: snapshot.data[index].city
                      )..selection = TextSelection.collapsed(
                        offset: snapshot.data[index].city.length
                      ),
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(city: value),
                      ),
                    ),
                    InputField(
                      hint: 'Estado',
                      obscure: false,
                      controller: TextEditingController(
                        text: snapshot.data[index].state
                      )..selection = TextSelection.collapsed(
                        offset: snapshot.data[index].state.length
                      ),
                      onChanged: (value) => bloc.changeAddress(
                        index,
                        Address(state: value),
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
