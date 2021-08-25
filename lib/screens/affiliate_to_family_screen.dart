import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/utils/sharedPreferences.dart';
import 'package:flutter/material.dart';

class EnterFamilyScreen extends StatefulWidget {
  @override
  _EnterFamilyScreenState createState() => _EnterFamilyScreenState();
}

class _EnterFamilyScreenState extends State<EnterFamilyScreen> {
  String familiaName;
  String _familyName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dapp",
                style: TextStyle(fontSize: 30, color: Colors.blueGrey[700]),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: widthScreen(context) / 1.2,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Código de convite"),
                  onChanged: (value) {
                    familiaName = value;
                  },
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(color: Colors.blueGrey[400]),
                  ),
                  onPressed: () => getIt<FamiliaService>()
                      .checkUser(familiaName)
                      .whenComplete(() {})
                      .then((value) {
                    if (value != null) {
                      getIt<UserState>().saveFamilyId(value);

                      print(value);
                      setState(() {
                        // _isLoadingGSignIn = false;
                        // _isDoneSignIn = true;
                        // _message = value;
                      });
                      Navigator.pushReplacementNamed(context, dashboard_screen);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Por favor, garanta que escreveu o nome certo,"
                                " ou crie a sua família",
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          duration: Duration(seconds: 3),
                          // backgroundColor: Colors.blue,
                        ),
                      );
                    }
                  }),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
