import 'package:despensa/screens/create_family_screen.dart';
import 'package:despensa/screens/dashboard.dart';
import 'package:despensa/screens/edit_product_screen.dart';
import 'package:despensa/screens/enter_family_screen.dart';
import 'package:despensa/screens/lista_compras_screen.dart';
import 'package:despensa/screens/login.dart';
import 'package:despensa/screens/products_screen.dart';
import 'package:despensa/screens/settings_screen.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/services/firebase_conn.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/app_colors.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

import 'screens/family_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();
  initializeDefault().whenComplete(() => {}).then((value) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    runApp(provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider.value(value: AuthService()),
        provider.ChangeNotifierProvider.value(value: FamiliaService()),
        provider.ChangeNotifierProvider.value(value: ThemeChanger())
      ],
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(builder: (context, theme, _) {
      return MaterialApp(
        title: 'DAPP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: checkLoginStatus(),
        routes: {
          login_screen: (context) => LoginScreen(),
          dashboard_screen: (context) => Dashboard(),
          produtos_screen: (context) => ProductsPage(),
          enter_family_screen: (context) => EnterFamilyScreen(),
          family_screen: (context) => FamilyScreen(),
          create_family_screen: (context) => CreateFamilyScreen(),
          settings_screen: (context) => SettingsScreen(),
          lista_compras_screen: (context) => ListaComprasScreen(),
          edit_product_screen: (context) => EditProductScreen()
        },
      );
    });
  }

  Widget checkLoginStatus() {
    if (getIt<AuthService>().user == null) {
      return LoginScreen();
    } else {
      return Dashboard();
    }
  }
}
