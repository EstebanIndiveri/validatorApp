import 'package:flutter/material.dart';
import 'package:validatorapp/src/bloc/provider.dart';
import 'package:validatorapp/src/model/Producto_model.dart';
import 'package:validatorapp/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    // final productosProvider=new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    
    final productosBloc=Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado(productosBloc),
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

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder: (BuildContext context,AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos=snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,index)=> _crearItem(context, productosBloc, productos[index]),
            );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    setState(() {
      
    });
    // return FutureBuilder(
    //   future: productosProvider.cargarProductos(),
    //   builder: (BuildContext context,AsyncSnapshot<List<ProductoModel>> snapshot) {
     
    //   },
      
    // );
  }

  Widget _crearItem(BuildContext context,ProductosBloc productosBloc , ProductoModel producto){
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction)=>productosBloc.borrarProducto(producto.id),
          child: Card(
            child: Column(
              children: <Widget>[
                (producto.fotoUrl==null)
                ?Image(image: AssetImage('assets/no-image.png'),)
                :FadeInImage(
                  image: NetworkImage(producto.fotoUrl),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text('${producto.titulo} - ${producto.valor}'),
                  subtitle: Text(producto.id),
                  onTap: ()=>Navigator.pushNamed(context, 'producto',arguments: producto),
                ),
              ],
            ),
          )
    );


    // ListTile(
    //       title: Text('${producto.titulo} - ${producto.valor}'),
    //       subtitle: Text(producto.id),
    //       onTap: ()=>Navigator.pushNamed(context, 'producto',arguments: producto),
    //     ),
  }
}