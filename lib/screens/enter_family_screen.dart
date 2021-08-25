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
  String familiaId;
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
              // Form(
              //     child: Column(
              //   children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: widthScreen(context) / 1.2,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome da Família"),
                  onChanged: (value) {
                    familiaId = value;
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
                      .addFamiliaToUser(familiaId)
                      .whenComplete(() {})
                      .then((value) {
                    getIt<UserState>().saveFamilyId(familiaId);

                    print(value);
                    setState(() {
                      // _isLoadingGSignIn = false;
                      // _isDoneSignIn = true;
                      // _message = value;
                    });
                    Navigator.pushReplacementNamed(context, dashboard_screen);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                        // backgroundColor: Colors.blue,
                      ),
                    );
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
