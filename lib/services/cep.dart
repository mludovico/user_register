import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:user_register/models/address.dart';

enum ResponseType {JSON, XML}

class Cep {

  String _url = 'https://viacep.com.br/ws';
  Address address;

  Cep({this.address});

  Future<Address> get({Address address, ResponseType responseType = ResponseType.JSON}) async {
    String type = responseType.toString().split('.')[1].toLowerCase();
    http.Response response = await http.get('$_url/${address.zip}/$type');
    if(response.statusCode == 200){
      Address address = Address.fromMap(jsonDecode(response.body));
      return address;
    }
    else
      return null;
  }
}