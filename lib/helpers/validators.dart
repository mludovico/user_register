import 'dart:async';

class Validators {

  static final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      String regex = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
      if(!RegExp(regex).hasMatch(email))
        sink.addError("Email inválido");
      else
        sink.add(email);
    }
  );

  static final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      String regex = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$";
      if(!RegExp(regex).hasMatch(password))
        sink.addError("A senha deve conter pelo menos 6 caracteres, 1 maiúscula, 1 número e um caractere especial");
      else
        sink.add(password);
    }
  );

  static final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink){
      String regex = r"(^[A-zÀ-ú]{2,50})(.*\ .*)([A-zÀ-ú]{2,50}$)";
      if(!RegExp(regex).hasMatch(name))
        sink.addError("Nome inválido");
      else
        sink.add(name);
    }
  );

  static final validateBirthDate = StreamTransformer<String, String>.fromHandlers(
    handleData: (birthDate, sink){
      String regex = r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$";
      if(!RegExp(regex).hasMatch(birthDate))
        sink.addError("Data inválida");
      else
        sink.add(birthDate);
    }
  );

  static final validateCpf = StreamTransformer<String, String>.fromHandlers(
    handleData: (cpf, sink){
      String regex = r"^((\d{3})\.(\d{3})\.(\d{3})\-(\d{2}))*$";
      if(!RegExp(regex).hasMatch(cpf))
        sink.addError("CPF inválido");
      else
        sink.add(cpf);
    }
  );

}