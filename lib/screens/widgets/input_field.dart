import 'package:flutter/material.dart';
import 'package:user_register/constants/ui_styles.dart';

class InputField extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Widget suffix;

  InputField({this.iconData, this.hint, this.obscure, this.stream, this.onChanged, this.suffix});

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              icon: Icon(
                iconData,
                color: primary,
              ),
              hintText: hint,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: primary),
              ),
              contentPadding: EdgeInsets.only(
                  top: 20,
                  right: 30,
                  bottom: 20,
                  left: 5
              ),
              errorText: snapshot.hasError?snapshot.error:null,
              suffix: suffix,
              errorMaxLines: 2
            ),
            obscureText: obscure,
            autofocus: false,
          );
        }
    );
  }
}
