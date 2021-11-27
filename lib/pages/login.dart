import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/register.dart';
import 'package:smalltown/pages/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final celular = TextEditingController();
  final contrasena = TextEditingController();

  CollectionReference usuario =
      FirebaseFirestore.instance.collection('usuarios');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,  //color de fondo del scaffold
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
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Aquí vamos de nuevo",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ingresa a tu cuenta",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
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
                    obscureText: true,
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    List credencial = [];
                    if (celular.text.isEmpty || contrasena.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg:
                              '¡oye! espera un momento ingresa tus credenciales si te quieres loguear',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                    } else {
                      QuerySnapshot inicio = await usuario
                          .where(FieldPath.documentId, isEqualTo: celular.text)
                          .where('contrasena', isEqualTo: contrasena.text)
                          .get();
                      if (inicio.docs.isNotEmpty) {
                        for (var aces in inicio.docs) {
                          credencial.add(aces.data());
                        }
                        /* DatosUsuario dataUser = DatosUsuario(
                            celular.text,
                            credencial[0]['contrasena'],
                            credencial[0]['correo'],
                            credencial[0]['direccion'],
                            credencial[0]['nombre']); */
                        Fluttertoast.showToast(
                            msg: 'sabia que volverias',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IndexPage(
                                      correo: credencial[0]["correo"],
                                      nombre: credencial[0]['nombre'],
                                    )));
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                'las credenciales que ingresaste son erroneas por favor verificalas o registrate',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM);
                      }
                    }
                  },
                  color: const Color.fromRGBO(246, 215, 121, 10.0),
                  //elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Iniciar sesión",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Olvidaste tu contraseña? '),
                      InkWell(
                        child: const Text(
                          'Recuperala aquí',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {},
                      )
                    ],
                  ), */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Aún no tienes una cuenta? '),
                      InkWell(
                        child: const Text(
                          'Regístrate aquí',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DatosUsuario {
  String celular = "";
  String nombre = "";
  String direccion = "";
  String correo = "";
  String contrasena = "";

  DatosUsuario(
      this.celular, this.contrasena, this.correo, this.direccion, this.nombre);
}
