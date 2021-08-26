import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Produto.dart';
import 'package:despensa/screens/single_product_screen.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:despensa/widgets/custom_shelve_button.dart';
import 'package:despensa/widgets/no_data.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProdutosServices produtosService;
  Map<String, dynamic> _produtosMap = Map<String, dynamic>();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    produtosService = ProdutosServices(args.toString());
    print(args.toString());
    return Scaffold(
      appBar: CustomAppBar(title: args.toString()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: heightScreen(context) / 4,
            //   color: Colors.blueGrey,
            // ),
            Container(
                height: heightScreen(context) / 1.13,
                child: StreamBuilder(
                    stream: produtosService.familias
                        .doc(getIt<FamiliaService>().familiaId)
                        .collection(prateleiras_colecao)
                        .doc(getIt<PrateleiraService>()
                            .prateleirasMap[args.toString()])
                        .collection(produtos_colecao)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      // print(getIt<PrateleiraService>()
                      //     .prateleirasMap[args.toString()]);
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
                      int index = 0;
                      // _produtosMap = snapshot.data as Map<String, dynamic>;
                      // log('hummm ${Produto.fromJson(snapshot.data)}');
                      return snapshot.data.docs.length == 0
                          ? NoData()
                          : GridView.count(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 20, left: 10),
                              crossAxisSpacing: widthScreen(context) / 50,
                              mainAxisSpacing: widthScreen(context) / 50,
                              crossAxisCount: 3,
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                _produtosMap =
                                    document.data() as Map<String, dynamic>;
                                Produto produto =
                                    Produto.fromJson(_produtosMap);
                                index = ++index;
                                return buildCardButton(index,
                                    title: _produtosMap['nome'], action: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SingleProductPage(produto)),
                                  );
                                },
                                    total: produto.quantidade.toString(),
                                    disponivel: produto.disponivel.toString());
                              }).toList(),
                            );
                    }))
          ],
        ),
      ),
    );
  }
}
