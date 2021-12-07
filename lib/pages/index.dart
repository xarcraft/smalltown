import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smalltown/pages/about.dart';
import 'package:smalltown/pages/advertisement.dart';
import 'package:smalltown/pages/homepage.dart';
import 'package:smalltown/pages/maps.dart';
import 'package:smalltown/pages/newlogin.dart';
import 'package:smalltown/pages/perfil.dart';
import 'package:smalltown/pages/personaledit.dart';
import 'package:smalltown/pages/search.dart';
import 'package:smalltown/pages/shopping.dart';

class IndexPage extends StatefulWidget {
  final DatosUsuario user;
  // ignore: use_key_in_widget_constructors
  const IndexPage({required this.user});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List negocios = [];
  List codigo = [];
  @override
  void initState() {
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    String id = "";
    CollectionReference datos =
        FirebaseFirestore.instance.collection('comercios');
    QuerySnapshot comercio = await datos.get();
    if (comercio.docs.isNotEmpty) {
      for (var c in comercio.docs) {
        id = c.id.toString();
        codigo.add(id);
        negocios.add(c.data());
        if (!mounted) return;
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
                widget.user.nombre,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                widget.user.correo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              currentAccountPicture:
                  Image.asset('assets/images/Logo_SmallTown1.png'),
            ),
            ListTile(
              title: const Text('Mi Perfil'),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                            usuario: widget
                                .user) /* PersonalData() */)); // cerrar menu
              },
            ),
            /* ListTile(
              title: const Text('Favoritos'),
              leading: const Icon(Icons.star_border),
              onTap: () {
                Navigator.of(context).pop();
              },
            ), */
            ListTile(
              title: const Text('Mis Compras'),
              leading: const Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingPage(
                              user: widget.user,
                            )));
              },
            ),
            /* ListTile(
              title: const Text('Mi carrito'),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Shoppingcart(
                              negocio: '',
                              pedido: [],
                              usuario: '',
                              user: widget.user,
                            )));
              },
            ), */
            ListTile(
              title: const Text('Promociones'),
              leading: const Icon(Icons.money_off),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Advertisement()));
              },
            ),
            ListTile(
              title: const Text('My Town'),
              leading: const Icon(Icons.travel_explore),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MapsPage()));
              },
            ),
            ListTile(
              title: const Text('Acerca de'),
              leading: const Icon(Icons.help_outline),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutMe()));
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              leading: const Icon(Icons.logout),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                  (route) => false,
                );
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
                                  user: widget.user,
                                  celular: widget.user.celular,
                                  idNegocio: codigo[i],
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
              context,
              MaterialPageRoute(
                  builder: (context) => SearchPage(usuario: widget.user)));
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CircleAvatar(
            maxRadius: 100,
            child: Image.network(imagen),
          ),
        ),
        Text(
          texto,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const Divider()
      ],
    );
  }
}

class DatosComercios {
  String nombre = "";
  String celular = "";
  late GeoPoint coordenada;
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
