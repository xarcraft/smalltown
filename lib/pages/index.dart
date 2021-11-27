import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/homepage.dart';
import 'package:smalltown/pages/perfil.dart';
import 'package:smalltown/pages/personal.dart';
import 'package:smalltown/pages/search.dart';

class IndexPage extends StatefulWidget {
  final String nombre;
  final String correo;
  // ignore: use_key_in_widget_constructors
  const IndexPage({required this.correo, required this.nombre});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List negocios = [];
  @override
  void initState() {
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos =
        FirebaseFirestore.instance.collection('comercios');
    QuerySnapshot comercio = await datos.get();
    if (comercio.docs.isNotEmpty) {
      for (var c in comercio.docs) {
        negocios.add(c.data());
        setState(() {});
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Oye, algo salio mal pero estamos trabajando para solucionarlo',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              accountName: Text(
                widget.nombre,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                widget.correo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              currentAccountPicture:
                  Image.asset('assets/images/Logo_SmallTown1.png'),
            ),
            ListTile(
              title: const Text('Perfil'),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PersonalData())); // cerrar menu
              },
            ),
            ListTile(
              title: const Text('Favoritos'),
              leading: const Icon(Icons.star_border),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Compras'),
              leading: const Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Mi carrito'),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Promociones'),
              leading: const Icon(Icons.money_off),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              leading: const Icon(Icons.logout),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            )
          ],
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
                                  comercio: local,
                                )));
                  },
                  title: Presentacion(
                      imagen: negocios[i]['foto'],
                      texto: negocios[i]['nombre']));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 0, 0, 3),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

class Presentacion extends StatelessWidget {
  final String imagen;
  final String texto;
  // ignore: use_key_in_widget_constructors
  const Presentacion({required this.imagen, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      margin: const EdgeInsets.all(20),
      elevation: 15,
      color: const Color.fromRGBO(243, 255, 0, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(children: [
          Image.network(imagen),
          Container(
              padding: const EdgeInsets.all(10),
              color: const Color.fromRGBO(243, 255, 0, 1),
              child: Text(
                texto,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ))
        ]),
      ),
    );
  }
}

class DatosComercios {
  String nombre = "";
  String celular = "";
  String coordenada = "";
  String direccion = "";
  String foto = "";
  String logo = "";
  String rubro = "";
  String telefono = "";
  String web = "";
  String descripcion = "";

  DatosComercios(
      this.celular,
      this.coordenada,
      this.direccion,
      this.foto,
      this.logo,
      this.nombre,
      this.rubro,
      this.telefono,
      this.web,
      this.descripcion);
}
