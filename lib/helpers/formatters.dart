import 'package:flutter/services.dart';

class Formatters {

  static final TextInputFormatter dateFormatter =
    TextInputFormatter.withFunction((oldValue, newValue){
      final int maxLength = 8;
      final newTextLength = newValue.text.length;
      var selectionIndex = newValue.selection.end;

      if (newTextLength > maxLength) {
        return oldValue;
      }

      var usedSubstringIndex = 0;
      final newText = StringBuffer();

      if (newTextLength >= 3) {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + '/');
        if (newValue.selection.end >= 2)
          selectionIndex++;
      }
      if (newTextLength >= 5) {
        newText.write(newValue.text.substring(2, usedSubstringIndex = 4) + '/');
        if (newValue.selection.end >= 4)
          selectionIndex++;
      }
      if (newTextLength >= usedSubstringIndex) {
        newText.write(newValue.text.substring(usedSubstringIndex));
      }

      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    });

  static final TextInputFormatter cpfFormatter =
    TextInputFormatter.withFunction((oldValue, newValue){
      final int maxLength = 11;
      final newTextLength = newValue.text.length;
      var selectionIndex = newValue.selection.end;

      if (newTextLength > maxLength) {
        return oldValue;
      }

      var usedSubstringIndex = 0;
      final newText = StringBuffer();

      if (newTextLength >= 4) {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '.');
        if (newValue.selection.end >= 3)
          selectionIndex++;
      }
      if (newTextLength >= 7) {
        newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '.');
        if (newValue.selection.end >= 6)
          selectionIndex++;
      }
      if (newTextLength >= 10) {
        newText.write(newValue.text.substring(6, usedSubstringIndex = 9) + '-');
        if (newValue.selection.end >= 9)
          selectionIndex++;
      }
      if (newTextLength >= usedSubstringIndex) {
        newText.write(newValue.text.substring(usedSubstringIndex));
      }

      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    });

  static final TextInputFormatter phoneFormatter = TextInputFormatter
      .withFunction((oldValue, newValue){
        print(oldValue.text);
        print(newValue.text);
        if(oldValue.text.length == 2 && newValue.text.length == 1) {
          return TextEditingValue(
            text: '',
            selection: TextSelection.collapsed(
              offset: 0,
            ),
          );
        }
        if(newValue.text.length == 2 && !newValue.text.contains('(')) {
          String value = '(${newValue.text})';
          return TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(
              offset: value.length,
            ),
          );
        }
        if(!newValue.text.contains(')9') && newValue.text.length > 12) {
          String value = newValue.text.substring(0, 12);
          return TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: 12,),
          );
        }
        if(newValue.text.length > 13) {
          String value = newValue.text.substring(0, 13);
          return TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: 13,),
          );
        }
      return newValue;
  });

  static final TextInputFormatter zipFormatter =
    TextInputFormatter.withFunction((oldValue, newValue){
      if (newValue.text.length > 5 && !newValue.text.contains('-')) {
        String value = '${newValue.text.substring(0, 5)}-${newValue.text.substring(5)}';
        return TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      }
      if (newValue.text.length > 9) {
        final value = newValue.text.substring(0, 9);
        return TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      }
      return newValue;
    });
}