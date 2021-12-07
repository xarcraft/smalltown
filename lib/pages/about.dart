import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
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
        body: Center(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(80),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/Logo_SmallTown1.png'),
                )),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text(
                  'SMALLTOWN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'es una aplicación desarrollada bajo la iniciativa MISION TIC 2022, en una alianza entre, la facultad de ingenieria y la división de educacion continuada de la Universidad EL BOSQUE y el ministerio de las tecnologias de la información y las comunicaciones',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('diseñada y programada por:\n'),
                    const Text(
                      'HAROLD H GOMEZ B \n Grupo 04 ciclo 4B \n Desarrollo movil\n',
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Instructora: YENNY VIVIANA FORERO R',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      InkWell(
                        child: const Text(
                          'Universidad el Bosque',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          launch('https://www.unbosque.edu.co/');
                        },
                      ),
                      InkWell(
                        child: const Text(
                          'Mision Tic 2022',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          launch('https://www.misiontic2022.gov.co/portal/');
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
