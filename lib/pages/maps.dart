import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(4.265112316043334, -75.93364354312492);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // ignore: prefer_const_constructors
  static final Marker _taz = Marker(
    markerId: const MarkerId('_taz'),
    infoWindow:
        const InfoWindow(title: 'Taz', snippet: 'comidas rapidas y más'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.266257071665986, -75.93028713344032),
  );

  // ignore: prefer_const_constructors
  static final Marker _barber = Marker(
    markerId: const MarkerId('_barber'),
    infoWindow: const InfoWindow(
        title: 'Barber Shop', snippet: 'Tu estilo nuestro trabajo'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.268354093874154, -75.93054462549006),
  );

  // ignore: prefer_const_constructors
  static final Marker _virrey = Marker(
    markerId: const MarkerId('_virrey'),
    infoWindow: const InfoWindow(
        title: 'Licores Virrey', snippet: 'importados y nacionales'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.26912442712437, -75.93517948238544),
  );

  // ignore: prefer_const_constructors
  static final Marker _trigal = Marker(
    markerId: const MarkerId('_trigal'),
    infoWindow: const InfoWindow(
        title: 'Panaderia el trigal', snippet: 'El mejor pan de la ciudad'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.2732756541046575, -75.93264747722962),
  );

  // ignore: prefer_const_constructors
  static final Marker _pana = Marker(
    markerId: const MarkerId('_pana'),
    infoWindow: const InfoWindow(
        title: 'Mecanicos El Pana', snippet: 'mejorando lo inmejorable'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.265700717874126, -75.93711067275851),
  );

  // ignore: prefer_const_constructors
  static final Marker _roble = Marker(
    markerId: const MarkerId('_roble'),
    infoWindow: const InfoWindow(
        title: 'artesanias el roble', snippet: 'dando forma a la madera'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.272334140676831, -75.92672516008554),
  );

  // ignore: prefer_const_constructors
  static final Marker _olimpo = Marker(
    markerId: const MarkerId('_olimpo'),
    infoWindow: const InfoWindow(
        title: 'Gym Olimpo', snippet: 'Tú salud, nuestro reto'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.273960390416991, -75.93230415449663),
  );

  // ignore: prefer_const_constructors
  static final Marker _pollo = Marker(
    markerId: const MarkerId('_pollo'),
    infoWindow:
        const InfoWindow(title: 'Mi pollo', snippet: 'pollo sabroso siempre'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.272205752392567, -75.93590904319302),
  );

  // ignore: prefer_const_constructors
  static final Marker _estacion = Marker(
    markerId: const MarkerId('_estacion'),
    infoWindow: const InfoWindow(
        title: 'la estación de Julio', snippet: 'un cafe antes de partir'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.26047953189201, -75.93444992157782),
  );

  // ignore: prefer_const_constructors
  static final Marker _llanera = Marker(
    markerId: const MarkerId('_llanera'),
    infoWindow: const InfoWindow(
        title: 'Llanera y Carbón',
        snippet: 'los mas deliciosos cortes de carne al carbón'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(4.267112999789585, -75.94084430747976),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Localización ',
            style: TextStyle(
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
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: {
            _taz,
            _barber,
            _virrey,
            _trigal,
            _pana,
            _roble,
            _olimpo,
            _pollo,
            _estacion,
            _llanera
          },
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
        ),
      ),
    );
  }
}
