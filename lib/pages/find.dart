import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/index.dart';
import 'package:smalltown/pages/newlogin.dart';
import 'package:smalltown/pages/perfil.dart';

class FindPage extends StatefulWidget {
  final String indice;
  final DatosUsuario userActivo;
  // ignore: use_key_in_widget_constructors
  const FindPage(this.indice, {required this.userActivo});

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  List resultado = [];
  List negocios = [];

  @override
  void initState() {
    super.initState();
    getIndice();
  }

  void getIndice() async {
    CollectionReference producto =
        FirebaseFirestore.instance.collection('productos');
    QuerySnapshot consultas =
        await producto.where('nombre', isEqualTo: widget.indice).get();
    if (consultas.docs.isNotEmpty) {
      for (var bus in consultas.docs) {
        setState(() {
          resultado.add(bus.data());
        });
      }
    } //opcional busqueda vacia

    String id;
    CollectionReference comercio =
        FirebaseFirestore.instance.collection('comercios');
    for (var i = 0; i < resultado.length; i++) {
      id = resultado[i]['comercio'];
      QuerySnapshot datoNegocio =
          await comercio.where(FieldPath.documentId, isEqualTo: id).get();
      if (datoNegocio.docs.isNotEmpty) {
        for (var n in datoNegocio.docs) {
          setState(() {
            negocios.add(n.data());
          });
        }
      } else {
        Fluttertoast.showToast(
            msg:
                'no hemos encontrado lo que buscas pero dale una chequeada a los demas comercios quizas algo te guste',
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
        title: Text(
          'Resultados para ' + widget.indice,
          style: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
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
      body: Center(
        child: ListView.builder(
          itemCount: negocios.length,
          itemBuilder: (BuildContext context, i) {
            return ListTile(
              onTap: () {
                DatosComercios local = DatosComercios(
                    negocios[i]['celular'],
                    negocios[i]['coordenada'],
                    negocios[i]['direccion'],
                    negocios[i]['foto'],
                    negocios[i]['logo'],
                    negocios[i]['nombre'],
                    negocios[i]['rubro'],
                    negocios[i]['telefono'],
                    negocios[i]['web'],
                    negocios[i]['descripcion']);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Perfil(
                              user: widget.userActivo,
                              celular: widget.userActivo.celular,
                              idNegocio: resultado[i]['comercio'], //id comercio
                              comercio: local,
                            )));
              },
              title: Presentacion(
                imagen: negocios[i]['foto'],
                texto: negocios[i]['nombre'],
              ),
            );
          },
        ),
      ),
    );
  }
}
