import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smalltown/pages/advertisement.dart';
import 'package:smalltown/pages/homepage.dart';
import 'package:smalltown/services/push_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      navigatorKey.currentState?.pushNamed('offer');
      //print('MyApp: $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Small Town',
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      routes: {
        'home': (_) => const HomePage(),
        'offer': (_) => const Advertisement(),
      },
    );
  }
}
