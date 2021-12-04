//token emulador: fNwUOZJFSDyFSobQH0ReOu:APA91bErEpNDrbrKapT9yjjq41oCijsJ3KGdIfyeOkujhNRylPtvRN5cEBD2blVosoaALU3Ha-ElmZ67H4rV79qMlxu0iD79ScIClAGZFiA2xIPQ85kTTiMqxs9KT__THMX_MrFdLV37
//token movil: dVKUUf32Q4magg4Yw_4ZYr:APA91bECSdtbM_oljw1pVCcr6lllNFEghDTkLA3oLvyCrU1nZz_05KVxhgaLYv2cluZmpHdQdxPUtfvFEX4W3Fd39BA0JV6H7kPWYPvff2gwNjsoN0R73SBX8OaxucpQmeo7nsvyBPQK

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onbackground Handler ${message.messageId}');

    _messageStream.add(message.data['product'] ?? 'Sin datos');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');

    _messageStream.add(message.data['product'] ?? 'Sin datos');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('onMessageOpenApp Handler ${message.messageId}');

    _messageStream.add(message.data['product'] ?? 'Sin datos');
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    // ignore: avoid_print
    print('token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
