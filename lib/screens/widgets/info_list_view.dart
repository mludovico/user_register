import 'package:flutter/material.dart';
import 'package:user_register/blocs/registration_bloc.dart';
import 'package:user_register/screens/widgets/input_field.dart';

class InfoListView extends StatelessWidget {

  final RegistrationBloc bloc;
  final String label;
  final IconData iconData;
  void Function() onAdd;
  InfoListView({this.bloc, this.label, this.iconData, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onAdd,
            ),
          ],
        ),
      ],
    );
  }
}
