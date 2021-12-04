// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smalltown/pages/find.dart';

class SearchPage extends StatelessWidget {
  TextEditingController search = TextEditingController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Busquedas y consultas',
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                //margin: EdgeInsets.all(30.0),
                child: TextField(
                  controller: search,
                  decoration: const InputDecoration(
                      hintText: "Dime que buscas",
                      icon: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Icon(Icons.search))),
                ),
              ),
              MaterialButton(
                height: 60,
                color: const Color.fromRGBO(243, 255, 0, 1),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FindPage(search.text)));
                },
                child: const Text(
                  'Consultar',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(40.0),
                child: const Text(
                  'Este espacio esta diseñado para que realices busquedas de productos especificos y asi saber que comercio cercano a ti lo vende, pero debes escribir la definición completa de aquello que buscas, ejemplo (jugo)',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'si quizás olvidaste que hacias aqui regresa al menu anterior alli encontraras el listado completo de comercios esperando por ti',
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
