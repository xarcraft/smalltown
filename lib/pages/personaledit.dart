import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/homepage.dart';
import 'package:smalltown/pages/index.dart';
import 'package:smalltown/pages/login.dart';

class EditPage extends StatefulWidget {
  final DatosUsuario usuario;
  // ignore: use_key_in_widget_constructors
  const EditPage({required this.usuario});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  String celular = "";

  @override
  Widget build(BuildContext context) {
    celular = widget.usuario.celular;
    nombre.text = widget.usuario.nombre;
    direccion.text = widget.usuario.direccion;
    correo.text = widget.usuario.correo;
    contrasena.text = widget.usuario.contrasena;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndexPage(
                          correo: correo.text,
                          nombre: nombre.text,
                        )));
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
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Ahora si aquí estan tus datos, dime que quieres modificar',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: nombre,
              decoration: const InputDecoration(
                  hintText: "Ingrese su nombre",
                  labelText: 'Nombre',
                  icon: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Icon(Icons.account_circle))),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: direccion,
              decoration: const InputDecoration(
                  hintText: "Ingrese su dirección",
                  labelText: 'Dirección',
                  icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.home))),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: correo,
              decoration: const InputDecoration(
                  hintText: "Ingrese su e-mail",
                  labelText: 'Correo',
                  icon: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Icon(Icons.mail_outline))),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: contrasena,
              decoration: const InputDecoration(
                  hintText: "Ingrese su contraseña",
                  labelText: 'Contraseña',
                  icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.vpn_key))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  height: 60,
                  color: const Color.fromRGBO(246, 215, 121, 10.0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('usuarios');
                    if (nombre.text.isEmpty ||
                        direccion.text.isEmpty ||
                        correo.text.isEmpty ||
                        contrasena.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Campos vacios',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP);
                    } else {
                      users.doc(widget.usuario.celular).update({
                        'nombre': nombre.text,
                        'direccion': direccion.text,
                        'correo': correo.text,
                        'contrasena': contrasena.text
                      });
                      Fluttertoast.showToast(
                          msg: 'Datos Actualizados con exito',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndexPage(
                                    correo: correo.text,
                                    nombre: nombre.text,
                                  )));
                    }
                  },
                  child: const Text(
                    'Actualizar',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  height: 60,
                  color: const Color.fromRGBO(246, 215, 121, 10.0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('usuarios');
                    users.doc(widget.usuario.celular).delete();
                    Fluttertoast.showToast(
                        msg: 'Su cuenta fue eliminada con exito',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(0),
            child: const Text(
              'Recuerda',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Si eliminas tu cuenta ya no podrás disfrutar de nuestra App espero lo pienses bien antes de hacerlo',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
