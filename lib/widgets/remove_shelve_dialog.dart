import 'package:despensa/models/Prateleira.dart';
import 'package:flutter/material.dart';

class RemoveShelveDialog extends StatelessWidget {
  double width;
  Shelve prateleira = Shelve.empty();
  TextEditingController minionNameController = TextEditingController();
  late GlobalKey<ScaffoldState> scaffoldKey;
  RemoveShelveDialog({
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('REMOVER PRATELEIRA')),
        content: Container(
            width: width,
            height: 100,
            child: Text('Realmente deseja remover esta prateleira?')),
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
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                          child: Text(
                            'REMOVER',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
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
                                  Colors.white),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
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
