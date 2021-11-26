import 'package:flutter/material.dart';
import 'package:smalltown/pages/index.dart';
import 'package:url_launcher/url_launcher.dart';

class Perfil extends StatelessWidget {
  final DatosComercios comercio;
  // ignore: use_key_in_widget_constructors
  const Perfil({required this.comercio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          comercio.nombre,
          style: const TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
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
      body: ListView(
        children: [
          Presentacion(imagen: comercio.foto, texto: comercio.nombre),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              comercio.descripcion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          ResumenDatos(mensaje: 'Dirección: ' + comercio.direccion),
          ResumenDatos(mensaje: 'Celular: ' + comercio.celular),
          ResumenDatos(mensaje: 'Telefono fijo: ' + comercio.telefono),
          ResumenDatos(mensaje: 'Categoria: ' + comercio.rubro),
          InkWell(
            child: Text(
              'Pagina web: ' + comercio.web,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              launch(comercio.web);
            },
          ),
        ],
      ),
    );
  }
}

class ResumenDatos extends StatelessWidget {
  final String mensaje;
  // ignore: use_key_in_widget_constructors
  const ResumenDatos({required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Text(
      mensaje,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
