import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Prateleira.dart';
import 'package:despensa/screens/add_product_screen.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/app_colors.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/utils/sharedPreferences.dart';
import 'package:despensa/widgets/add_shelve_dialog.dart';
import 'package:despensa/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class OK extends StatefulWidget {
  const OK({Key key}) : super(key: key);

  @override
  _OKState createState() => _OKState();
}

class _OKState extends State<OK> with ChangeNotifier {
  PrateleiraService prateleiraService = PrateleiraService();
  // Map<String, dynamic> _prateleirasMap = Map<String, dynamic>();
  String familyName;

  @override
  void initState() {
    getIt<UserState>().readFamilyId().then((value) {
      if (value != null) getIt<FamiliaService>().setFamiliaId(value);
      getIt<FamiliaService>().getFamilyName(value).then((value) {
        setState(() {
          familyName = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 20,
                    top: heightScreen(context) / 20,
                    right: 20,
                    bottom: 0),
                margin: EdgeInsets.all(0),
                height: heightScreen(context) / 5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: shadesOfGrey,
                  begin: Alignment.centerLeft,
                  end: Alignment(
                    0.3,
                    3,
                  ),
                )),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () =>
                            Navigator.pushNamed(context, settings_screen)),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: ClipOval(
                                  child: Image.network(
                                    getIt<AuthService>().user.photoURL,
                                    fit: BoxFit.fill,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olá, ${getIt<AuthService>().user.displayName}",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Text("Família $familyName"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: heightScreen(context) / 1.2,
                margin: EdgeInsets.all(0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: prateleiraService.familias
                      .doc(getIt<FamiliaService>().familiaId)
                      .collection('prateleiras')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    // print(snapshot.data.docs);
                    if (snapshot.hasError) {
                      return Text('Occorreu um erro');
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

                    return snapshot.data.docs.length == 0
                        ? NoData()
                        : ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              // _prateleirasMap =
                              //     document.data() as Map<String, dynamic>;
                              Shelve shelve = Shelve.fromJson(document.data());

                              getIt<PrateleiraService>()
                                  .addPrateleirasTemp(shelve.nome, document.id);
                              notifyListeners();

                              return new ListTile(
                                title: new Text(
                                  shelve.nome,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                leading: Icon(Icons.amp_stories),
                                subtitle: Divider(
                                  thickness: 2,
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, produtos_screen,
                                    arguments: shelve.nome),
                              );
                            }).toList(),
                          );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: SpeedDialFabWidget(
          primaryIconExpand: Icons.add,
          primaryIconCollapse: Icons.clear,
          secondaryIconsList: [
            Icons.article_sharp,
            Icons.amp_stories,
          ],
          secondaryIconsText: [
            "Produto",
            "Prateleira",
          ],
          secondaryIconsOnPress: [
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                ),
            () => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AddShelve(width: widthScreen(context));
                }),
          ],
          primaryBackgroundColor: Colors.blueGrey,
        ));
  }
}
