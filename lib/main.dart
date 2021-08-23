import 'package:despensa/screens/dashboard.dart';
import 'package:despensa/screens/login.dart';
import 'package:despensa/screens/products_screen.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/firebase_conn.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();

  initializeDefault()
      .whenComplete(() => {})
      .then((value) => runApp(provider.MultiProvider(
            providers: [
              provider.ChangeNotifierProvider.value(value: AuthService())
            ],
            child: MyApp(),
          )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: checkLoginStatus(),
      routes: {
        dashboard_screen: (context) => Dashboard(),
        produtos_screen: (context) => ProductsPage()
      },
    );
  }

  Widget checkLoginStatus() {
    if (FirebaseAuth.instance.currentUser != null) return LoginScreen();
    return Dashboard();
  }
}
