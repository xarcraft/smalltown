// ignore_for_file: unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smalltown/pages/index.dart';
import 'package:smalltown/pages/newlogin.dart';
import 'package:smalltown/pages/perfil.dart';

class Shoppingcart extends StatefulWidget {
  final String usuario;
  final String negocio;
  final List<DatosPedido> pedido;
  final DatosUsuario user;
  // ignore: use_key_in_widget_constructors
  const Shoppingcart(
      {required this.negocio,
      required this.pedido,
      required this.usuario,
      required this.user});

  @override
  _ShoppingcartState createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrito de compras',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
                'Este es el paso final para adquirir tus productos, revisa tu cesta, agrega más productos, elimina productos y cuando estes list@ procede a verificar tu compra en el menu inferior.',
                textAlign: TextAlign.center),
          ),
          Center(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.pedido.length,
                itemBuilder: (BuildContext context, i) {
                  return ListTile(
                    title: Text(
                        '  ' +
                            widget.pedido[i].cant.toString() +
                            '       ' +
                            widget.pedido[i].nombre +
                            '   \$' +
                            widget.pedido[i].precio.toString() +
                            ' ' +
                            ' \$ ' +
                            widget.pedido[i].total.toString(),
                        style: const TextStyle(fontSize: 14)),
                    trailing: IconButton(
                      onPressed: () {
                        widget.pedido.removeAt(i);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.remove_shopping_cart,
                        size: 30,
                        color: Colors.red,
                      ),
                    ),
                    /* subtitle:
                        Text('cant      desc            pvp        total'), */
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: ConfirmarPedido(
          listapedido: widget.pedido,
          producto: widget.negocio,
          usuario: widget.user.celular,
          user: widget.user),
    );
  }
}

class ConfirmarPedido extends StatefulWidget {
  final List<DatosPedido> listapedido;
  final String usuario;
  final String producto;
  final DatosUsuario user;
  // ignore: use_key_in_widget_constructors
  const ConfirmarPedido(
      {required this.listapedido,
      required this.producto,
      required this.usuario,
      required this.user});

  @override
  _ConfirmarPedidoState createState() => _ConfirmarPedidoState();
}

class _ConfirmarPedidoState extends State<ConfirmarPedido> {
  void registrarDetalle(idPedido) {
    CollectionReference detalle =
        FirebaseFirestore.instance.collection('detallepedido');
    for (var dat = 0; dat < widget.listapedido.length; dat++) {
      detalle.add({
        'pedido': idPedido.toString(),
        'producto': widget.listapedido[dat].nombre,
        'codigo': widget.listapedido[dat].cod,
        'cantidad': widget.listapedido[dat].cant,
        'total': widget.listapedido[dat].total
      });
    }
  }

  void registrarPedido() {
    DateTime hoy = DateTime.now();
    DateTime fecha = DateTime(hoy.year, hoy.month, hoy.day);
    int total = 0;
    for (var i = 0; i < widget.listapedido.length; i++) {
      total += widget.listapedido[i].total;
    }
    CollectionReference pedido =
        FirebaseFirestore.instance.collection('pedido');
    pedido.add({
      'usuario': widget.usuario,
      'comercio': widget.producto,
      'fecha': fecha,
      'total': total
    }).then((value) => registrarDetalle(value.id));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        // ignore: duplicate_ignore
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.add_shopping_cart_sharp,
            size: 30,
          ),
          label: '\  Agregar \nproducto(s)',
        ),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.request_quote,
              size: 30,
            ),
            label: '\ consultar \nSUBTOTAL'),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.paid,
              size: 30,
            ),
            label: 'confirmar \n \  pedido'),
      ],
      backgroundColor: const Color.fromRGBO(255, 0, 0, 3),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: (indice) {
        if (indice == 0) {
          Navigator.pop(context);
        } else if (indice == 1) {
          int total = 0;
          for (var i = 0; i < widget.listapedido.length; i++) {
            total += widget.listapedido[i].total;
          }
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Total a pagar: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black)),
                    contentPadding: const EdgeInsets.all(10),
                    content: Text('\$: ' + total.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromRGBO(255, 0, 0, 3),
                        )),
                  ));
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('confirmar pedido: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black)),
              contentPadding: const EdgeInsets.all(30),
              content: const Text('un tap más y los productos seran tuyos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20))),
                        onPressed: () {
                          registrarPedido();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      IndexPage(user: widget.user)));
                        },
                        child: const Text('Confirmar')),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar')),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
