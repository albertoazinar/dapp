import 'package:despensa/models/Familia.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:flutter/material.dart';

class CreateFamilyScreen extends StatefulWidget {
  @override
  _CreateFamilyScreenState createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends State<CreateFamilyScreen> {
  Familia familia = Familia.empty();
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
              //     Container(
              //       width: textfieldWidth,
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           border: OutlineInputBorder(),
              //           labelText: "Email",
              //         ),
              //       ),
              //     ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: widthScreen(context) / 1.2,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome da Família"),
                  onChanged: (value) {
                    familia.setNome(value);
                  },
                ),
              ),
              //   ],
              // )),
              // SizedBox(
              //   height: 30,
              // ),
              // Container(
              //   width: 150,
              //   margin: EdgeInsets.only(bottom: 15),
              //   child: RaisedButton(
              //     child: Text(
              //       'ENTRAR',
              //       style: TextStyle(color: Colors.blueGrey[400]),
              //     ),
              //     onPressed: null,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              // Text("OR"),
              Container(
                width: 150,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  child: Text(
                    'CRIAR',
                    // style: TextStyle(color: Colors.blueGrey[400]),
                  ),
                  onPressed: () {
                    familia.setOwner(getIt<AuthService>().userId);

                    getIt<FamiliaService>()
                        .addFamily(familia)
                        .whenComplete(() {})
                        .then((value) {
                      print(value);
                      setState(() {
                        // _isLoadingGSignIn = false;
                        // _isDoneSignIn = true;
                        // _message = value;
                      });
                      Navigator.pushNamedAndRemoveUntil(context,
                          dashboard_screen, (Route<dynamic> route) => false);
                    });
                  },
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
