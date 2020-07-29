import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:validatorapp/src/preferencias_usuario/preferencias.dart';

class UsuarioProvider{

  final String _firebaseToken='AIzaSyC2xcdqA_JShoiEnTU17oTvb_lKm-88x8I';
  final _prefs=new PreferenciasUsuario();

  Future<Map<String,dynamic>> login(String email,String password)async{
  final authData={
      'email':email,
      'password':password,
      'returnSecureToken':true
    };
    
    final resp=await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String,dynamic>decodedResp=json.decode(resp.body);
    // print(decodedResp);
    if(decodedResp.containsKey('idToken')){
      _prefs.token=decodedResp['idToken'];
      return{
        'ok':true,
        'token':decodedResp['idToken'],
      };
    }else{
      return{
        'ok':false,
        'mensaje':decodedResp['error']['message']
      };
    }
  }


  Future<Map<String,dynamic>> nuevoUsuario(String email, String password)async{
    final authData={
      'email':email,
      'password':password,
      'returnSecureToken':true
    };
    
    final resp=await http.post(
      // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String,dynamic>decodedResp=json.decode(resp.body);
    // print(decodedResp);
    if(decodedResp.containsKey('idToken')){
      _prefs.token=decodedResp['idToken'];
      return{
        'ok':true,
        'token':decodedResp['idToken'],
      };
    }else{
      return{
        'ok':false,
        'mensaje':decodedResp['error']['message']
      };
    }
  }

}