import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:validatorapp/src/bloc/validators.dart';

class LoginBloc with Validators{

  final _emailController= BehaviorSubject<String>();
  final _passwordController= BehaviorSubject<String>();

  //datos stream

  Stream<String> get emailStream=>_emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream=>_passwordController.stream.transform(validarPassword);

  Stream<bool>get formValidStream=>CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  //insert value stream
  Function(String)get changeEmail=>_emailController.sink.add;
  Function(String)get changePassword=>_passwordController.sink.add;

    //ultimo valor stream:
  String get email=>_emailController.value;
  String get password=>_passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}