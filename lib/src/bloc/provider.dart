import 'package:flutter/material.dart';
import 'package:validatorapp/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  final loginBloc=LoginBloc();

  Provider({Key key, Widget child})
  :super(key: key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>true;

  static LoginBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)as Provider).loginBloc;
    
  }

}