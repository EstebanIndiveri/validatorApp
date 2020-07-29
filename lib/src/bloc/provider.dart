import 'package:flutter/material.dart';
import 'package:validatorapp/src/bloc/login_bloc.dart';
import 'package:validatorapp/src/bloc/productos_bloc.dart';
export 'package:validatorapp/src/bloc/productos_bloc.dart';
export 'package:validatorapp/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  static Provider _instancia;
  final _productosBloc=new ProductosBloc();

  factory Provider({Key key, Widget child}){
    if(_instancia==null){
      _instancia=new Provider._internal(key: key,child: child);
    }
    return _instancia;
  }

   Provider._internal({Key key, Widget child})
  :super(key: key,child: child);

  final loginBloc=LoginBloc();

  // Provider({Key key, Widget child})
  // :super(key: key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>true;

  static LoginBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
    // return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)as Provider).loginBloc;
    
  }

    static ProductosBloc productosBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
    // return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)as Provider).loginBloc;
    
  }
  

}