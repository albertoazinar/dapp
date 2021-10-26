import 'package:despensa/models/Produto.dart';
import 'package:despensa/screens/single_product_screen.dart';
import 'package:despensa/services/ListaComprasController.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/compraItem.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';

class ListaComprasScreen extends StatefulWidget {
  const ListaComprasScreen({Key key}) : super(key: key);

  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  String familyName;
  ObservableList items = getIt<ListaComprasController>().listaDeCompra;
  ProdutosServices produtosServices;
  String sharableList = '';
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
      int qntd = prod.quantidade - prod.disponivel;
      double subtotal = 0;
      if (prod.pUnit != null) {
        // print(total);
        subtotal = prod.pUnit * qntd;
        total = total + subtotal;
      }
      sharableList += '- ';
      sharableList +=
          '${prod.nome}\n Quant: $qntd ${prod.unidade}| Preço Unit.: ${prod.pUnit ?? '0.0'}0| Subt.: ${subtotal}0MZN';
      sharableList += '\n';
    }
    sharableList += '\nTotal: ${total}0MZN';

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lista de Compras',
        actions: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                icon: Icon(
                  !UniversalPlatform.isIOS
                      ? Icons.share_outlined
                      : Icons.ios_share,
                  color: Colors.white,
                ),
                onPressed: () {
                  Share.share(sharableList);
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
                height: 40,
                color: Colors.blueGrey,
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: widthScreen(context) / 40,
                        ),
                        text: 'Total\n',
                        children: [
                          TextSpan(
                            text: '${total}$currency',
                            style:
                                TextStyle(fontSize: widthScreen(context) / 30),
                          )
                        ]),
                  ),
                )),
            Divider(),
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
                    produtosServices = ProdutosServices(
                        getIt<PrateleiraService>()
                            .prateleirasMap[produto.prateleira]);
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
                              ? '${produto.pUnit}$currency'
                              : '--',
                          pTotal: produto.pUnit != null
                              ? '${produto.pUnit * qntd}$currency'
                              : '--'),
                      trailing: Container(
                        alignment: Alignment.center,
                        width: widthScreen(context) / 5.5,
                        height: double.infinity,
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueGrey[400],
                              padding: EdgeInsets.all(0),
                            ),
                            child: Text('Repor'),
                            onPressed: () {
                              setState(() {
                                produto.setDisponivel(produto.quantidade);
                                produtosServices
                                    .updateProduto(produto)
                                    .whenComplete(() {})
                                    .then((value) {
                                  setState(() {
                                    getIt<ListaComprasController>()
                                        .removeProductItem(produto);
                                  });
                                });
                              });
                            },
                          ),
                        ),
                      ),
                      isThreeLine: false,
                      // enabled: false,
                      onTap: () {
                        //   // =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SingleProductPage(produto)));
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
