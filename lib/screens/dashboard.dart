import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Prateleira.dart';
import 'package:despensa/screens/add_product_screen.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/app_colors.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/add_shelve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with ChangeNotifier {
  PrateleiraService prateleiraService = PrateleiraService();
  Map<String, dynamic> _prateleirasMap = Map<String, dynamic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 20.0),
                height: heightScreen(context) / 3,
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
                    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: ClipOval(
                                  child: Image.network(
                                    getIt<AuthService>().user.photoURL,
                                    fit: BoxFit.fill,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ),
                              Text(
                                "Hello, ${getIt<AuthService>().user.displayName}",
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: heightScreen(context) / 2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: prateleiraService.users
                      .doc(getIt<AuthService>().userId)
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

                    return ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        _prateleirasMap =
                            document.data() as Map<String, dynamic>;
                        Shelve shelve = Shelve.fromJson(document.data());

                        getIt<PrateleiraService>()
                            .addPrateleirasTemp(shelve.nome, document.id);
                        notifyListeners();

                        return new ListTile(
                          title: new Text(
                            shelve.nome,
                            style: TextStyle(fontSize: 20, color: Colors.black),
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
