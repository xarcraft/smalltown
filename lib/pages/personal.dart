import 'package:flutter/material.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
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
      body: Center(
        child: ListView(
          children: const [
            Text('hola'),
          ],
        ),
      ),
    );
  }
}
