import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/newlogin.dart';

class ShoppingPage extends StatefulWidget {
  final DatosUsuario user;
  const ShoppingPage({required this.user});

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List articulos = [];
  List resultado = [];

  void initState() {
    super.initState();
    getArticulos();
  }

  void getArticulos() async {
    String id = "";
    CollectionReference usuarioActivo =
        FirebaseFirestore.instance.collection('pedido');
    QuerySnapshot consultas = await usuarioActivo
        .where('usuario', isEqualTo: widget.user.celular)
        .get();
    if (consultas.docs.isNotEmpty) {
      for (var bus in consultas.docs) {
        setState(() {
          id = bus.id.toString();
          resultado.add(id);
        });
      }
    } //opcional busqueda vacia

    CollectionReference detalle =
        FirebaseFirestore.instance.collection('detallepedido');
    for (var i = 0; i < resultado.length; i++) {
      QuerySnapshot datoNegocio =
          await detalle.where('pedido', isEqualTo: resultado[i]).get();
      if (datoNegocio.docs.isNotEmpty) {
        for (var n in datoNegocio.docs) {
          setState(() {
            articulos.add(n.data());
          });
        }
      } else {
        Fluttertoast.showToast(
            msg: 'no hay ordenes aún',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Builder(builder: (context) {
            return const Text(
              'Mis compras        ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            );
          }),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: articulos.length,
        itemBuilder: (BuildContext context, i) {
          return ListTile(
            title: Text(
                articulos[i]['cantidad'].toString() +
                    ' ' +
                    articulos[i]['producto'] +
                    ' \$ ' +
                    articulos[i]['total'].toString(),
                textAlign: TextAlign.center),
          );
        },
      ),
    );
  }
}
