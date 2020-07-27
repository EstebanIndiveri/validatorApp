import 'package:flutter/material.dart';
import 'package:validatorapp/src/bloc/provider.dart';
import 'package:validatorapp/src/model/Producto_model.dart';
import 'package:validatorapp/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
    final productosProvider=new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc=Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.add),
      onPressed: ()=>Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context,AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          return Container();
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}