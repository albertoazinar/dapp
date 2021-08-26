import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Definições",
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: heightScreen(context) / 1.4,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Text('Convidar para Família'),
                    leading: Icon(Icons.share),
                    onTap: () {
                      Share.share(
                          'Olá,\nConvido-o a fazer parte da minha '
                          'família para gestão do rancho, use este código '
                          'após fazer o login [${getIt<FamiliaService>().familiaId}]',
                          subject: app_link);
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              margin: EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                child: Text(
                  'SAIR',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey[400]),
                ),
                onPressed: () {
                  // super.dispose();
                  getIt<AuthService>().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, login_screen, (Route<dynamic> route) => false);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
