import 'package:flutter/material.dart';

class Advertisement extends StatelessWidget {
  const Advertisement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Builder(builder: (context) {
            return const Text(
              'Promociones    ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            );
          }),
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
          Container(
            padding: const EdgeInsets.all(45),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/banner.gif'),
                    fit: BoxFit.cover)),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Este fin de semana aprovecha los mejores precios de tu localidad.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'así es, los comercios que tanto disfrutas, tambien tienen promociones para ti',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              '¡Que esperas! corre y aprovecha los mejores descuentos y promociones',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(120),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/run.png'),
            )),
          )
        ],
      ),
    );
  }
}
