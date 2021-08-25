import 'dart:ui';

import 'package:despensa/models/Produto.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SingleProductPage extends StatefulWidget {
  Produto produto;
  SingleProductPage(this.produto, {Key key}) : super(key: key);

  @override
  _SingleProductPageState createState() =>
      _SingleProductPageState(this.produto);
}

class _SingleProductPageState extends State<SingleProductPage> {
  Produto produto;

  bool _isToggled = false;

  _SingleProductPageState(this.produto);

  double percent = 0;

  @override
  void initState() {
    calcPercent();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(left: heightScreen(context) / 10),
                  height: heightScreen(context) / 4,
                  width: widthScreen(context),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Text(
                    "${widget.produto.nome}",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Icon(
                    Icons.weekend_outlined,
                    size: 100,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  width: widthScreen(context) / 1.5,
                  child: Text(
                    widget.produto.descricao,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueGrey),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "${widget.produto.disponivel}/\n${widget.produto.quantidade}",
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 15),
                    ))
              ],
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
                            widget.produto.setDisponivel(newQntd);
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
                            widget.produto.setDisponivel(newQntd);
                            if (percent < 100) {
                              widget.produto.setDisponivel(newQntd);
                              calcPercent();
                            }
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
