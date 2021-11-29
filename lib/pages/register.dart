import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/index.dart';
import 'package:smalltown/pages/newlogin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final correo = TextEditingController();
  final celular = TextEditingController();
  final contrasena = TextEditingController();

  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Asi que deseas registrarte",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "pues vamos alla. Completa por favor todos los campos",
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  TextField(
                    controller: nombre,
                    decoration: const InputDecoration(
                        hintText: "Ingrese su nombre",
                        labelText: 'Nombre',
                        icon: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Icon(Icons.account_circle))),
                  ),
                  TextField(
                    controller: direccion,
                    decoration: const InputDecoration(
                        hintText: "Ingrese su dirección",
                        labelText: 'Dirección',
                        icon: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.home))),
                  ),
                  TextField(
                    controller: correo,
                    decoration: const InputDecoration(
                        hintText: "Ingrese su e-mail",
                        labelText: 'Correo',
                        icon: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Icon(Icons.mail_outline))),
                  ),
                  TextField(
                    controller: celular,
                    decoration: const InputDecoration(
                        hintText: "Ingrese su numero de telefono",
                        labelText: 'Celular',
                        icon: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Icon(Icons.phone_android))),
                  ),
                  TextField(
                    controller: contrasena,
                    decoration: const InputDecoration(
                        hintText: "Ingrese su contraseña",
                        labelText: 'Contraseña',
                        icon: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.vpn_key))),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  if (celular.text.isEmpty ||
                      nombre.text.isEmpty ||
                      direccion.text.isEmpty ||
                      correo.text.isEmpty ||
                      contrasena.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'recuerda que debes llenar todos los campos',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER);
                  } else {
                    QuerySnapshot existe = await usuarios
                        .where(FieldPath.documentId, isEqualTo: celular.text)
                        .get();
                    if (existe.docs.isNotEmpty) {
                      Fluttertoast.showToast(
                          msg:
                              'un momento ese telefono ya fue registrado intenta recuperar tu password o ingresa otro numero',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                    } else {
                      DatosUsuario nuevo = DatosUsuario(
                          celular.text,
                          contrasena.text,
                          correo.text,
                          direccion.text,
                          nombre.text);
                      usuarios.doc(celular.text).set({
                        'nombre': nombre.text,
                        'direccion': direccion.text,
                        'correo': correo.text,
                        'contrasena': contrasena.text
                      });

                      Fluttertoast.showToast(
                          msg: 'Todo salio perfecto ahora disfruta esta App',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);

                      celular.clear();
                      nombre.clear();
                      direccion.clear();
                      correo.clear();
                      contrasena.clear();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndexPage(
                                    user: nuevo,
                                  )));
                    }
                  }
                },
                color: const Color.fromRGBO(243, 255, 0, 1),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  'Registrarte',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
