import 'package:despensa/models/Produto.dart';
import 'package:despensa/services/prateleira_service.dart';
import 'package:despensa/services/produto_service.dart';
import 'package:despensa/utils/AppPhoneSize.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/widgets/custom_appBar.dart';
import 'package:despensa/widgets/custom_dropdown.dart';
import 'package:despensa/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final globalScaffoldKey = GlobalKey<ScaffoldMessengerState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController qntdController = TextEditingController();
  TextEditingController unidController = TextEditingController();

  ProdutosServices produtosServices;
  Produto produto = Produto.empty();

  @override
  void initState() {
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
        title: "Adicionar Produto",
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
                  validatorText: "Please insert a valid text",
                  hintText: "Name of the Product",
                  controller: nameController,
                  onChange: (val) => produto.setNome(val)),
              CustomTextField(
                  // validatorText: "Please insert a valid text",
                  hintText: "Descrição",
                  controller: desController,
                  onChange: (val) => produto.setDescricao(val)),
              CustomTextField(
                  validatorText: "Please insert a valid text",
                  hintText: "Quantidade do produto",
                  controller: qntdController,
                  inputType: TextInputType.number,
                  onChange: (val) => produto.setQuantidade(int.parse(val))),
              CustomTextField(
                  validatorText: "Please insert a valid text",
                  hintText: "Unidade (Ex: Kg, Pacote...)",
                  controller: unidController,
                  onChange: (val) => produto.setUnidade(val)),
              CustomDropDownTextField(
                items: _prateleirasMap,
                currentSelectedValue: "Escolha a Prateleira",
                width: widthScreen(context),
                onChange: (value) => produto.setPrateleira(value),
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
                      produto.setDisponivel(produto.quantidade);
                      produto.setPunit(0);
                      produtosServices = ProdutosServices(
                          getIt<PrateleiraService>()
                              .prateleirasMap[produto.prateleira]);
                      produtosServices
                          .addProduto(produto)
                          .whenComplete(() {})
                          .then((value) {
                        print(value);
                        globalScaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        //
                      });
                      formKey.currentState.reset();
                      nameController.text = '';
                      desController.text = '';
                      qntdController.text = '';
                      unidController.text = '';
                    }
                  },
                  child: Text("Adicionar Produto"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
