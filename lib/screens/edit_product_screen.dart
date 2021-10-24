import 'package:despensa/models/Produto.dart';
import 'package:despensa/screens/single_product_screen.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:despensa/widgets/custom_dropdown.dart';
import 'package:despensa/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class EditProductScreen extends StatefulWidget {
  Produto produto;

  EditProductScreen();

  EditProductScreen.prod(this.produto);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final globalScaffoldKey = GlobalKey<ScaffoldMessengerState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController qntdController = TextEditingController();
  TextEditingController disponivelController = TextEditingController();
  TextEditingController unidController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  ProdutosServices produtosServices;

  @override
  void initState() {
    nameController.text = widget.produto.nome;
    desController.text = widget.produto.descricao;
    qntdController.text = widget.produto.quantidade.toString();
    unidController.text = widget.produto.unidade;
    disponivelController.text = widget.produto.disponivel.toString();
    priceController.text = widget.produto.pUnit != null
        ? widget.produto.pUnit.toString().replaceAll('.0', '')
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _prateleirasMap = new Map<String, dynamic>.from(
        getIt<PrateleiraService>().prateleirasMap);
    print(_prateleirasMap);
    return Scaffold(
      key: globalScaffoldKey,
      appBar: CustomAppBar(
        title: "Editar Detalhes",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                  label: 'Nome do Produto',
                  validatorText: "O nome não pode estar vazio",
                  hintText: 'John Doe',
                  controller: nameController,
                  onChange: (val) => widget.produto.setNome(val)),
              CustomTextField(
                  label: 'Descrição',
                  // validatorText: "Please insert a valid text",
                  hintText: 'Coloque algo super específico para sua casa',
                  controller: desController,
                  onChange: (val) {
                    if (val.isNotEmpty) widget.produto.setDescricao(val);
                  }),
              CustomTextField(
                  label: 'Quantidade do Produto (Total)',
                  validatorText: "Por favor coloque uma qualidade válida",
                  hintText: '2',
                  controller: qntdController,
                  inputType: TextInputType.number,
                  onChange: (val) {
                    if (val.isNotEmpty)
                      widget.produto.setQuantidade(int.parse(val));
                  }),
              CustomTextField(
                label: 'Quantidade do Produto (Disponível)',
                validatorText: "A unidade não pode estar vazia",
                hintText: "Quantidade do Produto Disponível",
                controller: disponivelController,
                inputType: TextInputType.number,
                validator: (val) {
                  if (val.isNotEmpty) {
                    if (int.parse(disponivelController.text) >
                        int.parse(qntdController.text))
                      return 'A quantidade disponível não pode ser maior que o total';
                  }
                },
              ),
              CustomTextField(
                  label: 'Unidade (Ex: Kg, Pacote...)',
                  validatorText: "A unidade não pode estar vazia",
                  hintText: "Ex: Kg, Pacote, Caixa, etc",
                  controller: unidController,
                  onChange: (val) {
                    if (val.isNotEmpty) widget.produto.setUnidade(val);
                  }),
              CustomTextField(
                  label: 'Preço unitário (Estimativa)',
                  // validatorText: "Please insert a valid text",
                  hintText: "Ex:1000",
                  controller: priceController,
                  inputType: TextInputType.number,
                  onChange: (val) {
                    if (val.isNotEmpty)
                      widget.produto.setPunit(double.parse(val));
                  }),
              CustomDropDownTextField(
                label: 'Prateleira',
                items: _prateleirasMap,
                currentSelectedValue: widget.produto.prateleira,
                width: widthScreen(context),
                onChange: (value) {
                  if (value.isNotEmpty) widget.produto.setPrateleira(value);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // alignment: WrapAlignment,
                // direction: Axis.horizontal,
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // int qntdMinimaCtr = qntdMinimaCtrl;

                              return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: !UniversalPlatform.isIOS
                                    ? AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: Center(
                                            child: Text('APAGAR PRODUTO')),
                                        content: Text(
                                            'Esta ação é irreversível, deseja mesmo apagar?'),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ButtonTheme(
                                                height: 40,
                                                minWidth: 30,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              shape: MaterialStateProperty.all<
                                                                      OutlinedBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              )),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white)),
                                                          child: Text(
                                                            'SIM',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            getIt<ProdutosServices>()
                                                                .deleteUser(
                                                                    widget
                                                                        .produto
                                                                        .id)
                                                                .whenComplete(
                                                                    () {})
                                                                .then((value) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content:
                                                                    Text(value),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            4),
                                                              ));
                                                              Navigator.of(
                                                                      context)
                                                                  .popUntil(ModalRoute
                                                                      .withName(
                                                                          produtos_screen));
                                                            });

                                                            // setState((){qntdMinimaCtrl = });
                                                          }),
                                                      SizedBox(
                                                        width: widthScreen(
                                                                context) /
                                                            40,
                                                      ),
                                                      ElevatedButton(
                                                          child: Text(
                                                            'CANCELAR',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all<Color>(Colors
                                                                          .blueGrey),
                                                              shape: MaterialStateProperty.all<
                                                                      OutlinedBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(
                                                                          10)))),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : CupertinoAlertDialog(
                                        title: Center(
                                            child: Text('APAGAR PRODUTO')),
                                        content: Text(
                                            'Esta ação é irreversível, deseja mesmo apagar?'),
                                        actions: [
                                          CupertinoDialogAction(
                                              child: Text(
                                                'SIM',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                getIt<ProdutosServices>()
                                                    .deleteUser(
                                                        widget.produto.id)
                                                    .whenComplete(() {})
                                                    .then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(value),
                                                    duration:
                                                        Duration(seconds: 4),
                                                  ));
                                                  Navigator.of(context)
                                                      .popUntil(
                                                          ModalRoute.withName(
                                                              produtos_screen));
                                                });

                                                // setState((){qntdMinimaCtrl = });
                                              }),
                                          CupertinoDialogAction(
                                              child: Text(
                                                'CANCELAR',
                                                //   style: TextStyle(
                                                //       color: Colors.white),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context)),
                                        ],
                                      ),
                              );
                            });
                      },
                      child: Text(
                        "APAGAR PRODUTOO",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: widthScreen(context) / 35),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 12),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blueGrey),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            widget.produto.setDisponivel(
                                int.parse(disponivelController.text));
                            produtosServices = ProdutosServices(
                                getIt<PrateleiraService>()
                                    .prateleirasMap[widget.produto.prateleira]);
                            produtosServices
                                .updateProduto(widget.produto)
                                .whenComplete(() {})
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleProductPage(widget.produto)));
                            });
                          });
                        }
                      },
                      child: Text(
                        "ACTUALIZAR PRODUTO",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: widthScreen(context) / 35),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
