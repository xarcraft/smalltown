import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smalltown/pages/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Small Town',
      home: HomePage(),
    );
  }
}
