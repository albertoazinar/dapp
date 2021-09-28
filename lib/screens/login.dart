import 'package:despensa/services/auth_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              //     Container(
              //       margin: EdgeInsets.only(top: 10),
              //       width: textfieldWidth,
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //             border: OutlineInputBorder(), labelText: "Password"),
              //       ),
              //     ),
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
                width: widthScreen(context) / 1.5,
                margin: EdgeInsets.only(top: 15),
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () => getIt<AuthService>()
                      .signInWithGoogle()
                      .whenComplete(() {})
                      .then((value) {
                    print(value);
                    setState(() {
                      // _isLoadingGSignIn = false;
                      // _isDoneSignIn = true;
                      // _message = value;
                    });
                    Navigator.pushNamed(context, family_screen);
                  }),
                  text: 'ENTRAR COM GOOGLE',
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
