import 'package:flutter/material.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/constants/ui_styles.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class AddressListView extends StatelessWidget {

  final RegistrationBloc bloc;
  final String label;
  final IconData iconData;
  final void Function() onAdd;
  AddressListView({this.bloc, this.label, this.iconData, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: bloc.outAddress,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primary),
          ),
        );
        return Flex(
          direction: Axis.vertical,
          children: [
            TextField(
              decoration: InputDecoration(
                icon: Icon(
                  iconData,
                  color: primary,
                ),
                hintText: label,
                contentPadding: EdgeInsets.only(
                  top: 20,
                  //right: 30,
                  bottom: 20,
                  left: 5
                ),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(right: 30),
                  icon: Icon(
                    Icons.add,
                    color: primary,
                  ),
                  onPressed: (){},
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'CEP',
                suffix: IconButton(
                  icon: Icon(Icons.search),
                )
              ),
            ),
          ],
        );
      }
    );
  }
}
