import 'package:flutter/material.dart';
import 'package:validatorapp/src/bloc/provider.dart';
import 'package:validatorapp/src/model/Producto_model.dart';
import 'package:validatorapp/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          final productos=snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,index)=> _crearItem(context, productos[index]),
            );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
      
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto){
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction){
          //Delete
          productosProvider.borrarProducto(producto.id);
        },
          child: ListTile(
          title: Text('${producto.titulo} - ${producto.valor}'),
          subtitle: Text(producto.id),
          onTap: ()=>Navigator.pushNamed(context, 'producto',arguments: producto),
        ),
    );
  }
}