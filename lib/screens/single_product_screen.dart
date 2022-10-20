import 'dart:ui';

import 'package:despensa/models/Produto.dart';
import 'package:despensa/screens/edit_product_screen.dart';
import 'package:despensa/services/ListaComprasController.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/change_total_dialog.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SingleProductPage extends StatefulWidget {
  Produto produto;
  SingleProductPage(this.produto, {Key? key}) : super(key: key);

  @override
  _SingleProductPageState createState() =>
      _SingleProductPageState(this.produto);
}

class _SingleProductPageState extends State<SingleProductPage> {
  Produto produto;

  bool _isToggled = false;

  bool _isTotalToggled = false;

  _SingleProductPageState(this.produto);

  double percent = 0;

  @override
  void initState() {
    calcPercent();
  }

  @override
  Widget build(BuildContext context) {
    String gasto = '${widget.produto.disponivel}/${widget.produto.quantidade}';

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.produto.prateleira,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(top: 0, left: heightScreen(context) / 20),
                  height: heightScreen(context) / 10,
                  width: widthScreen(context),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Text(
                    "${widget.produto.nome}",
                    style: TextStyle(fontSize: widthScreen(context) / 15),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProductScreen.prod(produto))),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          width: widthScreen(context) / 1.6,
                          child: Text(
                            widget.produto.descricao ?? 'SEM DESCRIÇÃO',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 30),
                            child: TextButton(
                              onPressed: () {
                                _isToggled = true;
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ChangeTotal(
                                        produto: widget.produto,
                                        width: widthScreen(context),
                                      );
                                    });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "$gasto",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    '${widget.produto.unidade}(s)',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  widget.produto.pUnit != null
                      ? Container(
                          margin: EdgeInsets.only(bottom: 15, left: 12),
                          width: widthScreen(context) / 1.6,
                          child: Row(
                            children: [
                              Icon(
                                Icons.money,
                                color: Colors.blueGrey,
                              ),
                              Text(
                                  '${widget.produto.pUnit.toString()}$currency/${widget.produto.unidade}',
                                  style: TextStyle(
                                      fontSize: widthScreen(context) / 28,
                                      color: Colors.blueGrey)),
                            ],
                          ))
                      : SizedBox()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: LinearPercentIndicator(
                width: widthScreen(context) - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 3000,
                percent: (percent / 100),
                animateFromLastPercent: true,
                center: Text("$percent%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.blueGrey,
                // widgetIndicator: RotatedBox(
                //     quarterTurns: 1,
                //     child: Icon(Icons.airplanemode_active, size: 50)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: widthScreen(context) - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 35,
                      height: 25,
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
                          var newQntd = widget.produto.disponivel - 1;
                          setState(() {
                            _isToggled = true;
                            // widget.produto.setDisponivel(newQntd);
                            if (percent > 0) {
                              widget.produto.setDisponivel(newQntd);
                              calcPercent();
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: IconButton(
                        // color: Colors.blueGrey,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.add,
                          size: 20,
                        ),
                        onPressed: () {
                          var newQntd = widget.produto.disponivel + 1;
                          setState(() {
                            _isToggled = true;
                            widget.produto.setDisponivel(newQntd.toDouble());
                            if (percent >= 100) {
                              _isTotalToggled = true;
                              widget.produto.setQuantidade(newQntd);
                            }
                            calcPercent();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _isToggled
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Actualizar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                ProdutosServices produtosServices =
                    ProdutosServices(widget.produto.prateleira);
                if (_isTotalToggled) {
                  produtosServices
                      .updateTotal(
                          widget.produto.nome, widget.produto.quantidade)
                      .then((value) {
                    getIt<ListaComprasController>()
                        .removeProductItem(widget.produto);
                    // print(value);
                  });
                }
                produtosServices
                    .updateQuantidade(
                        widget.produto.nome, widget.produto.disponivel)
                    .then((value) {
                  print(value);
                });
              },
            )
          : null,
    );
  }

  calcPercent() {
    setState(() {
      percent = (widget.produto.disponivel * 100) / widget.produto.quantidade;
      percent = percent.round().toDouble();
    });
  }
}
