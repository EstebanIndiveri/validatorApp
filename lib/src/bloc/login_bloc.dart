

import 'dart:async';

import 'package:validatorapp/src/bloc/validators.dart';

class LoginBloc with Validators{

  final _emailController= StreamController<String>.broadcast();
  final _passwordController= StreamController<String>.broadcast();


  //datos stream

  Stream<String> get emailStream=>_emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream=>_passwordController.stream.transform(validarPassword);


  //insert value stream
  Function(String)get changeEmail=>_emailController.sink.add;
  Function(String)get changePassword=>_passwordController.sink.add;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}