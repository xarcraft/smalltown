import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smalltown/pages/index.dart';
import 'package:smalltown/pages/newlogin.dart';
import 'package:smalltown/pages/shoppingcart.dart';
import 'package:url_launcher/url_launcher.dart';

class Perfil extends StatefulWidget {
  final DatosComercios comercio;
  final String idNegocio;
  final String celular;
  final DatosUsuario user;
  // ignore: use_key_in_widget_constructors
  const Perfil(
      {required this.comercio,
      required this.idNegocio,
      required this.celular,
      required this.user});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List productos = [];
  List codigos = [];
  List<DatosPedido> pedido = [];

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  void getProductos() async {
    CollectionReference producto =
        FirebaseFirestore.instance.collection('productos');
    QuerySnapshot datos =
        await producto.where('comercio', isEqualTo: widget.idNegocio).get();
    if (datos.docs.isNotEmpty) {
      String id;
      for (var doc in datos.docs) {
        id = doc.id.toString();
        codigos.add(id);
        productos.add(doc.data());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Este local no tiene productos o servicios disponibles',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    late GeoPoint pos = widget.comercio.coordenada;
    final posicion =
        CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 16);

    final Set<Marker> marcador = {};

    marcador.add(
      Marker(
          markerId: MarkerId(widget.comercio.celular),
          position: LatLng(pos.latitude, pos.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
              title: widget.comercio.nombre, snippet: widget.comercio.web)),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.comercio.nombre,
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Shoppingcart(
                              negocio: widget.idNegocio,
                              pedido: pedido,
                              usuario: widget.celular,
                              user: widget.user,
                            )));
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView(
        children: [
          Presentacion(
              imagen: widget.comercio.foto, texto: widget.comercio.nombre),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.comercio.descripcion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          ResumenDatos(mensaje: 'Dirección: ' + widget.comercio.direccion),
          ResumenDatos(mensaje: 'Celular: ' + widget.comercio.celular),
          ResumenDatos(mensaje: 'Telefono fijo: ' + widget.comercio.telefono),
          ResumenDatos(mensaje: 'Categoria: ' + widget.comercio.rubro),
          const Text(
            'Pagina web: ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          InkWell(
            child: Text(
              widget.comercio.web,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              launch(widget.comercio.web);
            },
          ),
          const Text(
            '\nGeolocalización\n',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: 400,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: posicion,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              markers: marcador,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.yellow,
            child: const Text(
              'Productos y/o Servicios',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 0, 0, 3)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: productos.length,
                itemBuilder: (BuildContext context, i) {
                  var cantidad = TextEditingController();
                  return ListTile(
                    title: Text(productos[i]['nombre'] +
                        ' \$ ' +
                        productos[i]['valor'].toString()),
                    leading: const Icon(Icons.add_shopping_cart, size: 30),
                    subtitle: Container(
                      padding: const EdgeInsets.all(0),
                      child: TextField(
                        controller: cantidad,
                        decoration: const InputDecoration(hintText: 'Cant'),
                      ),
                    ),
                    onTap: () {
                      if (cantidad.text.isEmpty) {
                        cantidad.text = "0";
                      }
                      int cant = int.parse(cantidad.text);
                      int neto = int.parse(productos[i]['valor'].toString());
                      int total = cant * neto;

                      DatosPedido p = DatosPedido(
                          productos[i]['nombre'],
                          int.parse(cantidad.text),
                          codigos[i],
                          productos[i]['descripcion'],
                          productos[i]['valor'],
                          total);
                      pedido.add(p);

                      Fluttertoast.showToast(
                          msg: "Producto(s) agregado(s) al carrito",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                    },
                  );
                },
              ),
            ),
          ),
          const Text(
            '\nSmallTown® 2021\n',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
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

class DatosPedido {
  String cod = "";
  String nombre = "";
  String descripcion = "";
  int cant = 0;
  int precio = 0;
  int total = 0;

  DatosPedido(this.nombre, this.cant, this.cod, this.descripcion, this.precio,
      this.total);
}
