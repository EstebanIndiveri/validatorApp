import 'package:flutter/material.dart';
import 'package:validatorapp/src/bloc/provider.dart';
import 'package:validatorapp/src/page/home_page.dart';
import 'package:validatorapp/src/page/login_page.dart';
import 'package:validatorapp/src/page/producto_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context)=>LoginPage(),
          'home': (BuildContext context)=>HomePage(),
          'producto':(BuildContext context)=>ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}