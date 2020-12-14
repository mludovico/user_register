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
  
  static final TextInputFormatter phoneFormatter =
    TextInputFormatter.withFunction((oldValue, newValue){
      final newTextLength = newValue.text.length;

      var selectionIndex = newValue.selection.end;

      if (newTextLength == 11) {
        if (newValue.text.toString()[2] != '9') {
          return oldValue;
        }
      }

      if (newTextLength > 11) {
        return oldValue;
      }

      var usedSubstringIndex = 0;

      final newText = StringBuffer();

      if (newTextLength >= 1) {
        newText.write('(');
        if (newValue.selection.end >= 1) selectionIndex++;
      }

      if (newTextLength >= 3) {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ') ');
        if (newValue.selection.end >= 2) selectionIndex += 2;
      }

      if (newValue.text.length == 11) {
        if (newTextLength >= 8) {
          newText
              .write(newValue.text.substring(2, usedSubstringIndex = 7) + '-');
          if (newValue.selection.end >= 7) selectionIndex++;
        }
      } else {
        if (newTextLength >= 7) {
          newText
              .write(newValue.text.substring(2, usedSubstringIndex = 6) + '-');
          if (newValue.selection.end >= 6) selectionIndex++;
        }
      }

      if (newTextLength >= usedSubstringIndex) {
        newText.write(newValue.text.substring(usedSubstringIndex));
      }

      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    });

  static final TextInputFormatter zipFormatter =
    TextInputFormatter.withFunction((oldValue, newValue){
      final int maxLength = 8;
      final newLength = newValue.text.length;
      var selectionIndex = newValue.selection.end;

      if (newLength > maxLength) {
        return oldValue;
      }
      var substrIndex = 0;
      final newText = StringBuffer();

      if (newLength >= 6) {
        newText
            .write(newValue.text.substring(0, substrIndex = 5) + '-');
        if (newValue.selection.end >= 5) selectionIndex++;
      }

      if (newLength >= substrIndex) {
        newText.write(newValue.text.substring(substrIndex));
      }

      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    });
}