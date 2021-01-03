import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_register/blocs/states.dart';
import 'package:user_register/helpers/validators.dart';
import 'package:user_register/models/address.dart';
import 'package:user_register/services/zip.dart';

class RegistrationBloc extends BlocBase{
  final _firebase = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _stateController = BehaviorSubject<LoginState>();
  final _nameController = BehaviorSubject<String>();
  final _birthDateController = BehaviorSubject<String>();
  final _cpfController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordCheckController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<List<Address>>();
  final _phoneController = BehaviorSubject<List<String>>();
  Stream<LoginState> get outState => _stateController.stream;
  Stream<String> get outName => _nameController.stream.transform(Validators.validateName);
  Stream<String> get outBirth => _birthDateController.stream.transform(Validators.validateBirthDate);
  Stream<String> get outCpf => _cpfController.stream.transform(Validators.validateCpf);
  Stream<String> get outEmail => _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(Validators.validatePassword);
  Stream<String> get outPasswordCheck => _passwordCheckController.stream.transform(Validators.validatePassword);
  Stream<List<Address>> get outAddress => _addressController.stream;
  Stream<List<String>> get outPhone => _phoneController.stream;
  List<String> phoneList = [];
  List<Address> addressList = [];

  StreamSubscription _stateSubscription;

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeBirthDate => _birthDateController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePasswordCheck => _passwordCheckController.sink.add;

  RegistrationBloc(){
    _stateSubscription = _firebase.authStateChanges().listen((user) {
      if(user != null){
        _stateController.add(LoginState.SUCCESS);
      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submitWithEmail() async {
    _stateController.add(LoginState.LOADING);
    UserCredential credential = await _firebase.createUserWithEmailAndPassword(
      email: _emailController.value,
      password: _passwordController.value,
    ).catchError((error, stacktrace){
      print(error);
      print(stacktrace);
      _stateController.add(LoginState.FAIL);
    });
    await _firebase.currentUser.updateProfile(
      displayName: _nameController.value,
    ).catchError((e, stackTrace){
      print(e);
      print(stackTrace);
    });
    await _firebase.currentUser.reload();
    var data = {
      'name': _nameController.value,
      'email': _emailController.value,
      'birthDate': _birthDateController.value,
      'cpf': _cpfController.value,
      'addresses': _addressController.value,
      'phones': _phoneController.value,
    };
    await _firestore.collection('users').doc(credential.user.uid).set(data);
    _stateController.add(LoginState.SUCCESS);
  }

  void addPhone() {
    if(phoneList.length < 3)
      phoneList.add('value');
    _phoneController.add(phoneList);
  }

  void changePhone(int index, String value) {
    phoneList[index] = value;
    _phoneController.sink.add(phoneList);
  }

  void addAddress() {
    if(addressList.length < 3)
      addressList.add(Address());
    _addressController.add(addressList);
  }

  void changeAddress(int index, Address address) {
    addressList[index] = address;
    _addressController.add(addressList);
  }

  void getAddressFromZip(int index){
    Cep cep = Cep(
      address: Address(

      )
    );
  }

  @override
  void dispose() {
    _stateController.close();
    _nameController.close();
    _birthDateController.close();
    _cpfController.close();
    _emailController.close();
    _passwordController.close();
    _passwordCheckController.close();
    _addressController.close();
    _phoneController.close();
    _stateSubscription.cancel();
    super.dispose();
  }
}