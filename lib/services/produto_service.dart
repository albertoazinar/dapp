import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Produto.dart';
import 'package:despensa/services/auth_service.dart';
import 'package:despensa/utils/GetIt.dart';
import 'package:despensa/utils/common_services.dart';
import 'package:despensa/utils/constantes.dart';

class ProdutosServices {
  String prateleira;

  ProdutosServices(this.prateleira);

  //instanciar a coleção
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference produtos =
      FirebaseFirestore.instance.collection(produtos_colecao);

  //funcao lambda pra permitir acesso a coleção de outras classes
  produtosCollection() => produtos;
  CommonServices commonServices = CommonServices();

  Future<String> addProduto(Produto produto) async {
    bool _alreadyExists =
        await commonServices.alreadyExists(produto.nome, produtos_colecao);

    if (_alreadyExists)
      return Future(() => "Produto já adicionado a esta prateleira");
    return users
        .doc(getIt<AuthService>().userId)
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
    return await users
        .doc(getIt<AuthService>().userId)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .where('nome', isEqualTo: queryString)
        .get();
  }

  Future updatePrateleira(nome, novaPrateleira) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    return users
        .doc(getIt<AuthService>().userId)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == nome) {
          users
              .doc(getIt<AuthService>().userId)
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

  Future update(Produto produto) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    return users
        .doc(getIt<AuthService>().userId)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == produto.nome) {
          users
              .doc(getIt<AuthService>().userId)
              .collection(prateleiras_colecao)
              .doc(prateleira)
              .collection(produtos_colecao)
              .doc(doc.id) //pegar o id do documento que se pretende actualizar
              .update(produto.toJson())
              .then((value) => "${produto.nome} foi actualizado")
              .catchError((error) =>
                  "Oops, parece que não deu pra actualizar:\n $error");
        }
      });
    });
  }

  Future updateQuantidade(nome, novaQuantidade) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    return users
        .doc(getIt<AuthService>().userId)
        .collection(prateleiras_colecao)
        .doc(prateleira)
        .collection(produtos_colecao)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == nome) {
          users
              .doc(getIt<AuthService>().userId)
              .collection(prateleiras_colecao)
              .doc(prateleira)
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
}
