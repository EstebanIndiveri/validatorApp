import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validatorapp/src/model/Producto_model.dart';
import 'package:validatorapp/src/providers/productos_provider.dart';
import 'package:validatorapp/src/utils/utils.dart' as utils;
class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey=GlobalKey<FormState>();
  final scaffoldKey=GlobalKey<ScaffoldState>();

  ProductoModel producto= new ProductoModel();
  final productoProvider=new ProductosProvider();
  bool _guardando=false;
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData=ModalRoute.of(context).settings.arguments;
    if(prodData!=null){
      producto=prodData;
    }
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title:Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon:Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (newValue) {
        producto.titulo=newValue;
      },
      validator: (value) {
        if(value.length<3){
          return'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (newValue) {
        producto.valor=double.parse(newValue);
      },
      validator: (value) {
        if(utils.isNumber(value)){
          return null;
        }else{
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      label: Text('Guardar'),
      color:Colors.deepPurple,
      textColor: Colors.white,
      icon:Icon(Icons.save),
      onPressed: (_guardando)?null:_submit,
    );
  }

  void _submit()async{
    if(!formKey.currentState.validate())return;

    formKey.currentState.save();

    setState(() {
    _guardando=true;
    });
    if(_image!=null){
      producto.fotoUrl= await productoProvider.subirImagen(_image);
    }
    if(producto.id==null){
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }
    setState(() {
      _guardando=false;
    });
      mostrarSnackBar('Registro guardado');
      Navigator.pushNamed(context, 'home');
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      activeColor: Colors.deepPurple,
      title: Text('Disponible'),
      onChanged: (value)=>setState((){
        producto.disponible=value;
      }),
    );
  }

  void mostrarSnackBar(String message){
    final snackbar=SnackBar(
      content:Text(message),
      duration:Duration(milliseconds: 1500),
      backgroundColor: Colors.deepPurpleAccent,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto(){
    if(producto.fotoUrl!=null){
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.contain,
      );
    }else{
      return Image(
        image:AssetImage(_image?.path??'assets/no-image.png'),
        height: 300.0,
        fit:BoxFit.cover
      );
    }
  }

  _seleccionarFoto() async{
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async{
    _procesarImagen(ImageSource.camera);
  }
  _procesarImagen(ImageSource origen)async{
    final pickedFile = await picker.getImage(source: origen);
     if(_image!=null){
       producto.fotoUrl=null;
     }
     setState(() {
      _image = File(pickedFile.path);
    });
  }
}
   // foto=await ImagePicker.getImage(
    //   source: ImageSource.gallery
    // );
    // if(foto!=null){
    //   //limpieza
    // }
    // setState(() {
      
    // });