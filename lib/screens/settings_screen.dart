import 'package:despensa/services/auth_service.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _qntdController = TextEditingController();
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    _qntdController.text =
        getIt<FamiliaService>().familia.qntdMinima.toString();
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
                    title: Text('Quantida mínima'),
                    subtitle: Text('% para entrar na Lista de compras'),
                    leading: Icon(Icons.rule),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // int qntdMinimaCtr = qntdMinimaCtrl;

                          return StatefulBuilder(
                            builder: (context, setState) => Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Center(
                                    child: Text('DEFINIR QUANTIDADE MINIMA')),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15))),
                                      child: IconButton(
                                        // color: Colors.blueGrey,
                                        hoverColor: Colors.black,
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          Icons.remove,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (getIt<FamiliaService>()
                                                    .familia
                                                    .qntdMinima >
                                                0) {
                                              getIt<FamiliaService>()
                                                  .familia
                                                  .subtractQntdMinima();
                                              _qntdController.text =
                                                  getIt<FamiliaService>()
                                                      .familia
                                                      .qntdMinima
                                                      .toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: _qntdController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                          onChanged: (value) {
                                            getIt<FamiliaService>()
                                                .familia
                                                .setQntdMinima(
                                                    int.parse(value));
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: IconButton(
                                        // color: Colors.blueGrey,
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (getIt<FamiliaService>()
                                                    .familia
                                                    .qntdMinima <
                                                100) {
                                              getIt<FamiliaService>()
                                                  .familia
                                                  .addQntdMinima();
                                              _qntdController.text =
                                                  getIt<FamiliaService>()
                                                      .familia
                                                      .qntdMinima
                                                      .toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ButtonTheme(
                                        height: 40,
                                        minWidth: 30,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<OutlinedBorder>(
                                                              RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ))),
                                                  child: Text(
                                                    'ADICIONAR',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    getIt<FamiliaService>()
                                                        .updateQntMinima(
                                                            getIt<FamiliaService>()
                                                                .familia
                                                                .nome,
                                                            getIt<FamiliaService>()
                                                                .familia
                                                                .qntdMinima);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "REGRA ACTUUALIZADA, QNTD. MIN ${getIt<FamiliaService>().familia.qntdMinima}%",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      duration:
                                                          Duration(seconds: 3),
                                                      // backgroundColor: Colors.blue,
                                                    ));
                                                    Navigator.pop(context);

                                                    // setState((){qntdMinimaCtrl = });
                                                  }),
                                              SizedBox(
                                                width:
                                                    widthScreen(context) / 40,
                                              ),
                                              ElevatedButton(
                                                  child: Text(
                                                    'CANCELAR',
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .white10),
                                                      shape: MaterialStateProperty.all<
                                                              OutlinedBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      10)))),
                                                  onPressed: () =>
                                                      Navigator.pop(context)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  ListTile(
                    title: Text('Convidar para Lar'),
                    leading: Icon(Icons.share),
                    onTap: () {
                      Share.share(
                          'Olá,\nConvido-o a fazer parte do meu '
                          'lar para gestão do rancho, use este código '
                          'após fazer o login [${getIt<FamiliaService>().familia.id}]',
                          subject: app_link);
                    },
                  ),
                  // CustomSwitch(
                  //   width: widthScreen(context),
                  //   val: _isDarkMode,
                  //   label: 'Dark Mode',
                  //   onToggle: (val) {
                  //     setState(() {
                  //       _isDarkMode = val;
                  //       if (val) {
                  //         getIt<ThemeChanger>().setDarkMode();
                  //       }
                  //       getIt<ThemeChanger>().setLightMode();
                  //       // print(dependentIn.applyWaitingPeriod);
                  //     });
                  //   },
                  // ),
                  // ListTile(
                  //   title: Text('Dark Mode'),
                  //   subtitle: Container(
                  //     alignment: Alignment.bottomLeft,
                  //     child:
                  //   ),
                  // )
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
