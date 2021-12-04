import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/index.dart';
import 'package:smalltown/pages/register.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({Key? key}) : super(key: key);

  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final celular = TextEditingController();
  final contrasena = TextEditingController();
  CollectionReference usuario =
      FirebaseFirestore.instance.collection('usuarios');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Logo_SmallTown.png',
                      width: 80,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.orange,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Small Town',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color.fromRGBO(225, 0, 0, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            'Todo el comercio de tu localidad más cerca de ti',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 30),
                          child: TextField(
                            controller: celular,
                            autofocus: false,
                            decoration: const InputDecoration(
                                hintText: 'Celular',
                                prefixIcon: Icon(Icons.phone_android),
                                contentPadding: EdgeInsets.all(10),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2))),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 30),
                          child: TextField(
                            controller: contrasena,
                            obscureText: true,
                            autofocus: false,
                            decoration: const InputDecoration(
                                hintText: 'Contraseña',
                                prefixIcon: Icon(Icons.vpn_key),
                                contentPadding: EdgeInsets.all(10),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2))),
                          ),
                        ),
                        const SizedBox(height: 60),
                        InkWell(
                          onTap: () async {
                            List credencial = [];
                            if (celular.text.isEmpty ||
                                contrasena.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                      '¡oye! espera un momento ingresa tus credenciales si te quieres loguear',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER);
                            } else {
                              QuerySnapshot inicio = await usuario
                                  .where(FieldPath.documentId,
                                      isEqualTo: celular.text)
                                  .where('contrasena',
                                      isEqualTo: contrasena.text)
                                  .get();
                              if (inicio.docs.isNotEmpty) {
                                for (var aces in inicio.docs) {
                                  credencial.add(aces.data());
                                }
                                DatosUsuario dataUser = DatosUsuario(
                                    celular.text,
                                    credencial[0]['contrasena'],
                                    credencial[0]['correo'],
                                    credencial[0]['direccion'],
                                    credencial[0]['nombre']);
                                Fluttertoast.showToast(
                                    msg: 'sabia que volverias',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return IndexPage(
                                        user: dataUser,
                                      );
                                    },
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        'las credenciales que ingresaste son erroneas por favor verificalas o registrate',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            }
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Iniciar Sesión',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(225, 0, 0, 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
          ),
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
