import 'package:despensa/models/Produto.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:flutter/material.dart';

class ChangeTotal extends StatefulWidget {
  double width;
  Produto produto;
  ChangeTotal({
    @required this.produto,
    @required this.width,
  });

  @override
  _ChangeTotalState createState() => _ChangeTotalState();
}

class _ChangeTotalState extends State<ChangeTotal> {
  TextEditingController minionNameController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey;
  String _errMsg = '';
  int _newTotal = 0;
  ProdutosServices produtosServices;

  @override
  Widget build(BuildContext context) {
    produtosServices = ProdutosServices(widget.produto.prateleira);
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('ACTUALIZAR TOTAL')),
        // content: Container(
        // height: heightScreen(context) / 5,
        content: Wrap(
          children: [
            Text(
              _errMsg,
              style: TextStyle(color: Colors.red),
            ),
            Container(
                width: widget.width,
                height: 100,
                child: TextField(
                  onChanged: (value) => _newTotal = int.parse(value),
                  decoration: InputDecoration(hintText: 'Novo Total'),
                )),
          ],
        ),
        // ),
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
                            'ALTERAR',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            if (_newTotal < widget.produto.disponivel) {
                              setState(() {
                                _errMsg =
                                    'Certifique que o total é maior que o disponível (${widget.produto.disponivel})';
                              });
                            } else {
                              widget.produto.setQuantidade(_newTotal);
                              produtosServices
                                  .updateTotal(widget.produto.nome, _newTotal)
                                  .whenComplete(() {})
                                  .then((value) => print(value));
                              Navigator.pop(context);
                            }
                          }),
                      SizedBox(
                        width: widget.width / 40,
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
