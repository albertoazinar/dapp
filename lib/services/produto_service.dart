import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Produto.dart';
import 'package:despensa/services/familia_service.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/common_services.dart';
import 'package:despensa/utils/constantes.dart';
import 'package:flutter/cupertino.dart';

import 'prateleira_service.dart';

class ProdutosServices extends ChangeNotifier {
  String prateleira;
  String _msg = '';

  ProdutosServices(this.prateleira);

  ProdutosServices.empty(); //instanciar a coleção
  CollectionReference familias =
      FirebaseFirestore.instance.collection(familias_colecao);
  CollectionReference produtos =
      FirebaseFirestore.instance.collection(produtos_colecao);

  //funcao lambda pra permitir acesso a coleção de outras classes
  produtosCollection() => produtos;
  CommonServices commonServices = CommonServices();
  List<Produto> _listaDeCompra = [];

  Future<String> addProduto(Produto produto) async {
    bool _alreadyExists =
        await commonServices.alreadyExists(produto.nome, produtos_colecao);

    if (_alreadyExists)
      return Future(() => "Produto já adicionado a esta prateleira");
    return familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .add(produto.toJson())
        .then((value) => "${produto.nome} adicionado à ${produto.prateleira}")
        .catchError((error) =>
            "Parece que teve problemas com o último Produto:\n $error");
  }

  Future<QuerySnapshot> queryCollection(queryString) async {
    //retorna o snapshot equivalente aos objectos json onde
    // o nome é igual ao passado como argumento
    return await familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .where('nome', isEqualTo: queryString)
        .get();
  }

  Future updatePrateleira(nome, novaPrateleira) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    return familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == nome) {
          familias
              .doc(getIt<FamiliaService>().familia.id)
              .collection(prateleiras_colecao)
              .doc(prateleira)
              .collection(produtos_colecao)
              .doc(doc.id) //pegar o id do documento que se pretende actualizar
              .update({'prateleira': novaPrateleira})
              .then((value) => "$nome pasou para $novaPrateleira $nome(s)")
              .catchError((error) =>
                  "Oops, parece que não deu pra actualizar:\n $error");
        }
      });
    });
  }

  String get msg => _msg;

  Future<String> updateProduto(Produto produto) async {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele

    CollectionReference prods = await familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao);

    prods.doc(produto.id).update(produto.toJson()).whenComplete(() {
      log(_msg + 'ok');
      _msg = "${produto.nome} foi actualizado";
      notifyListeners();
      log(_msg);
    }).catchError((error) {
      _msg = "Oops, parece que não deu pra actualizar:\n $error";
      notifyListeners();
    });
    return msg;
  }

  Future updateQuantidade(nome, novaQuantidade) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    String _prateleiraId =
        getIt<PrateleiraService>().prateleirasMap[prateleira];
    return familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(_prateleiraId)
        .collection(produtos_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs);
      return querySnapshot.docs.forEach((doc) {
        if (doc['nome'] == nome) {
          return familias
              .doc(getIt<FamiliaService>().familia.id)
              .collection(prateleiras_colecao)
              .doc(_prateleiraId)
              .collection(produtos_colecao)
              .doc(doc.id) //pegar o id do documento que se pretende actualizar
              .update({'disponivel': novaQuantidade})
              .then((value) => "Agora ficou com $novaQuantidade $nome(s)")
              .catchError((error) =>
                  "Oops, parece que não deu pra actualizar:\n $error");
        }
      });
    });
  }

  Future updateTotal(nome, novaQuantidade) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    String _prateleiraId =
        getIt<PrateleiraService>().prateleirasMap[prateleira];
    CollectionReference produtos_colection = familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(_prateleiraId)
        .collection(produtos_colecao);
    return produtos_colection.get().then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs);
      return querySnapshot.docs.forEach((doc) {
        if (doc['nome'] == nome) {
          return produtos_colection
              .doc(doc.id) //pegar o id do documento que se pretende actualizar
              .update({'quantidade': novaQuantidade})
              .then((value) => "Agora o seu novo total é $novaQuantidade")
              .catchError((error) =>
                  "Oops, parece que não deu pra actualizar:\n $error");
        }
      });
    });
  }

  // List<Produto> get listaDeCompra => _listaDeCompra;

  // setListaDeCompra(List<Produto> value) {
  //   _listaDeCompra = value;
  //   notifyListeners();
  // }
  //
  // addToListaDeCompra(Produto value) {
  //   log('in');
  //   _listaDeCompra.add(value);
  //   notifyListeners();
  // }

  Future deleteUser(String id) async {
    CollectionReference produtos_colection = familias
        .doc(getIt<FamiliaService>().familia.id)
        .collection(prateleiras_colecao)
        .doc(getIt<PrateleiraService>().prateleiraId)
        .collection(produtos_colecao);

    return produtos_colection
        .doc(id)
        .delete()
        .then((value) => "Produto Apagado")
        .catchError((error) => "Failha ao tentar apagar Produto: $error");
  }
}
