import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/login.dart';
import 'package:smalltown/pages/personaledit.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final celular = TextEditingController();
  final contrasena = TextEditingController();

  CollectionReference kyc = FirebaseFirestore.instance.collection('usuarios');
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
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Ya sabemos que eres tu pero por motivos de seguridad debemos hacer una pequeña verificacion de rutina, por favor digita tus credenciales de acceso y procede a hacer los cambios que consideres necesarios',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: celular,
                decoration: const InputDecoration(
                    hintText: "Ingrese su numero de telefono",
                    labelText: 'Celular',
                    icon: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Icon(Icons.phone_android))),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
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
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Luego de llenar los campos con las credenciales correctas procede a dar clic en el boton editar para proceder con los cambios que requieras',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 0, 0, 3),
        onPressed: () async {
          List user = [];
          if (celular.text.isEmpty || contrasena.text.isEmpty) {
            Fluttertoast.showToast(
                msg: 'Creo q dejaste algunos campos vacios',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP);
          } else {
            QuerySnapshot datos = await kyc
                .where(FieldPath.documentId, isEqualTo: celular.text)
                .where('contrasena', isEqualTo: contrasena.text)
                .get();
            if (datos.docs.isNotEmpty) {
              for (var d in datos.docs) {
                user.add(d.data());
              }
              DatosUsuario dataUser = DatosUsuario(
                  celular.text,
                  user[0]['contrasena'],
                  user[0]['correo'],
                  user[0]['direccion'],
                  user[0]['nombre']);
              Fluttertoast.showToast(
                  msg: 'verificación exitosa',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditPage(
                            usuario: dataUser,
                          )));
            } else {
              Fluttertoast.showToast(
                  msg: 'Datos incorrectos',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP);
            }
          }
          /* Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditPage())); */
        },
        child: const Icon(Icons.mode_edit),
      ),
    );
  }
}
