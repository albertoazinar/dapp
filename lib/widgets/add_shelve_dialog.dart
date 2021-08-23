import 'package:despensa/models/Prateleira.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutterfire_demo/services/produto_service.dart';

class AddShelve extends StatelessWidget {
  double width;
  Shelve prateleira = Shelve.empty();
  PrateleiraService prateleiraService = PrateleiraService();
  TextEditingController minionNameController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey;
  AddShelve({
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('ADICONAR PRATELEIRA')),
        content: Container(
            width: width,
            height: 100,
            child: TextField(
              onChanged: (value) => prateleira.setNome(value),
              decoration: InputDecoration(hintText: 'Nome da Prateleira'),
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                height: 40,
                minWidth: 30,
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                          child: Text(
                            'ADICIONAR',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            prateleiraService
                                .addShelve(prateleira)
                                .whenComplete(() {})
                                .then((value) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value,
                                        textAlign: TextAlign.center,
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
                            });
                          }),
                      SizedBox(
                        width: width / 40,
                      ),
                      ElevatedButton(
                          child: Text(
                            'CANCELAR',
                            style: TextStyle(color: Colors.black45),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white10),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
