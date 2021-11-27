import 'package:flutter/material.dart';

class FindPage extends StatelessWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Resultados para ',
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
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                  'Aqui deberia aparecer el resultado de tu consulta')),
        ],
      ),
    );
  }
}
