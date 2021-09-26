import 'package:despensa/models/Produto.dart';
import 'package:despensa/services/ListaComprasController.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/widgets/compraItem.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class ListaComprasScreen extends StatefulWidget {
  const ListaComprasScreen({Key key}) : super(key: key);

  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  String familyName;
  ObservableList items = getIt<ListaComprasController>().listaDeCompra;

  // @override
  // void initState() {
  //   getIt<UserState>().readFamilyId().then((value) {
  //     if (value != null) getIt<FamiliaService>().setFamiliaId(value);
  //     getIt<FamiliaService>().getFamilyName(value).then((value) {
  //       setState(() {
  //         familyName = value;
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (Produto prod in items) {
      if (prod.pUnit != null) {
        int qntd = prod.quantidade - prod.disponivel;
        print(total);

        total = total + (prod.pUnit * qntd);
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lista de Compras',
        actions: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 30),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: widthScreen(context) / 40),
                    text: 'Total\n',
                    children: [
                      TextSpan(
                        text: '${total}0MZN',
                        style: TextStyle(fontSize: widthScreen(context) / 30),
                      )
                    ]),
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
                height: heightScreen(context) / 1.2,
                margin: EdgeInsets.all(0),
                child: ListView.separated(
                  separatorBuilder: (context, int index) => Divider(
                    thickness: 1,
                  ),
                  itemBuilder: (context, int index) {
                    Produto produto = items[index];
                    int qntd = produto.quantidade - produto.disponivel;

                    return new ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: new Text(
                          produto.nome,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      leading: Icon(Icons.fastfood_outlined),
                      subtitle: CompraItem(
                          descricao: produto.unidade ?? '',
                          qntd: qntd.toString(),
                          pUnit: produto.pUnit != null
                              ? '${produto.pUnit}0MZN'
                              : '--',
                          pTotal: produto.pUnit != null
                              ? '${produto.pUnit * qntd}0MZN'
                              : '--'),
                      isThreeLine: false,
                      onTap: () {
                        // =>
                        //     Navigator.pushNamed(
                        //         context, produtos_screen,
                        //         arguments: produto.nome)
                      },
                    );
                  },
                  itemCount: items.length,
                ))
          ],
        ),
      ),
    );
  }
}
