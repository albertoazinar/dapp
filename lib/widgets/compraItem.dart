import 'package:flutter/material.dart';

class CompraItem extends StatelessWidget {
  String descricao, qntd, pUnit, pTotal;

  CompraItem(
      {@required this.descricao,
      @required this.qntd,
      @required this.pUnit,
      @required this.pTotal});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Container(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unid',
              ),
              Text(
                descricao,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Quant'), singleItemTitle(qntd)],
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Preco Unt.'), singleItemTitle(pUnit)],
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Total'), singleItemTitle(pTotal)],
        )
      ],
    );
  }

  Widget singleItemTitle(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black),
    );
  }
}
