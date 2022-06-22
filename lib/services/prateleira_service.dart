import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Prateleira.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/common_services.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:flutter/cupertino.dart';

class PrateleiraService with ChangeNotifier {
  PrateleiraService();

  CollectionReference familias =
      FirebaseFirestore.instance.collection(familias_colecao);
  CollectionReference prateleiras =
      FirebaseFirestore.instance.collection("prateleiras");

  //funcao lambda pra permitir acesso a coleção de outras classes
  familiasCollection() => familias;
  Map<String, dynamic> _prateleirasMap = {
    "Escolha a Prateleira": "Escolha a Prateleira"
  };
  CommonServices commonServices = CommonServices();
  Future<String> addShelve(Shelve prateleira) async {
    bool _alreadyExists = await commonServices.alreadyExists(
        prateleira.nome, prateleiras_colecao);

    // print(prateleira.nome);
    // print(_alreadyExists);
    if (_alreadyExists) return Future(() => "Prateleira já existente");

    return familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .add(prateleira.toJson())
        .then((value) => "${prateleira.nome} adicionado")
        .catchError(
            (error) => "Parece que teve ao criar a prateleira:\n $error");
  }

  Future<QuerySnapshot> queryCollection(queryString) async {
    //retorna o snapshot equivalente aos objectos json onde
    // o nome é igual ao passado como argumento
    return await familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .where('nome', isEqualTo: queryString)
        .get();
  }

  String? _prateleiraId;

  String get prateleiraId => _prateleiraId!;

  setPrateleiraId(nome) {
    familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == nome) {
          _prateleiraId = doc.id;
          notifyListeners();
          //pegar o id do documento que se pretende actualizar

        }
      });
    });
  }

  Future updatePrateleira(nome, novoNome) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    return familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == nome) {
          familias
              .doc(getIt<FamiliaService>().familia.id)
              .collection(prateleiras_colecao)
              .doc(doc.id) //pegar o id do documento que se pretende actualizar
              .update({'nome': novoNome})
              .then((value) => "Mudou sua prateleira para $novoNome")
              .catchError((error) =>
                  "Oops, parece que não deu pra actualizar:\n $error");
        }
      });
    });
  }

  addPrateleirasTemp(String key, dynamic value) {
    _prateleirasMap[key] = value;
    print(prateleirasMap);
    notifyListeners();
  }

  Map<String, dynamic> get prateleirasMap => _prateleirasMap;
}
