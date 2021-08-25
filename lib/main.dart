import 'package:despensa/screens/create_family_screen.dart';
import 'package:despensa/screens/dashboard.dart';
import 'package:despensa/screens/enter_family_screen.dart';
import 'package:despensa/screens/login.dart';
import 'package:despensa/screens/products_screen.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/firebase_conn.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import 'screens/family_screen.dart';

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
        login_screen: (context) => LoginScreen(),
        dashboard_screen: (context) => Dashboard(),
        produtos_screen: (context) => ProductsPage(),
        enter_family_screen: (context) => EnterFamilyScreen(),
        family_screen: (context) => FamilyScreen(),
        create_family_screen: (context) => CreateFamilyScreen()
      },
    );
  }

  Widget checkLoginStatus() {
    if (getIt<AuthService>().user == null) {
      return LoginScreen();
    } else {
      return Dashboard();
    }
  }
}
