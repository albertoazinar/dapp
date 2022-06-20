import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/utils/sharedPreferences.dart';
import 'package:flutter/material.dart';

class FamilyScreen extends StatefulWidget {
  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
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
              SingleChildScrollView(
                child: Container(
                  height: heightScreen(context) / 6,
                  child: FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      print('P' + snapshot.data.toString());
                      if (snapshot.hasError) {
                        return Text('SEM FAMILIAS');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("SEM DADOS"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 1,
                              margin: EdgeInsets.only(
                                  left: widthScreen(context) / 6,
                                  right: widthScreen(context) / 6),
                              color: Colors.blueGrey[400],
                              child: new ListTile(
                                title: Center(
                                  child: new Text(
                                    snapshot.data!.keys.toList()[index],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                onTap: () {
                                  getIt<UserState>().saveFamilyId(
                                      snapshot.data!.values.toList()[index]);
                                  // print(value);

                                  setState(() {
                                    // _isLoadingGSignIn = false;
                                    // _isDoneSignIn = true;
                                    // _message = value;
                                  });
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      dashboard_screen,
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            );
                          });
                    },
                    future: getIt<FamiliaService>().getUserFamilies(),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  child: Text(
                    'ENTRAR NUMA FAMILIA',
                    textAlign: TextAlign.center,
                    // style: TextStyle(color: Colors.blueGrey[400]),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, enter_family_screen),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              Text("OR"),
              Container(
                width: 150,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  child: Text(
                    'CRIAR FAMILIA',
                    // style: TextStyle(color: Colors.blueGrey[400]),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, create_family_screen),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
