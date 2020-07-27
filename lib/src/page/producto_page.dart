import 'package:flutter/material.dart';
import 'package:validatorapp/src/model/Producto_model.dart';
import 'package:validatorapp/src/providers/productos_provider.dart';
import 'package:validatorapp/src/utils/utils.dart' as utils;
class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey=GlobalKey<FormState>();
  ProductoModel producto= new ProductoModel();
  final productoProvider=new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.photo_size_select_actual),
            onPressed: (){},
          ),
          IconButton(
            icon:Icon(Icons.camera_alt),
            onPressed: (){},
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
      onPressed: _submit,
    );
  }

  void _submit(){
    if(!formKey.currentState.validate())return;

    formKey.currentState.save();

    print('todook');
    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);

    productoProvider.crearProducto(producto);

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
}