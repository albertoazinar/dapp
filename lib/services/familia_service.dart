import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/models/Familia.dart';
import 'package:despensa/services/auth_service.dart';

class FamiliaService {
  //instanciar a coleção
  CollectionReference familias =
      FirebaseFirestore.instance.collection('familias');
  CollectionReference familias_users =
      FirebaseFirestore.instance.collection('familias_users');

  AuthService authService = AuthService();

  //funcao lambda pra permitir acesso a coleção de outras classes
  familiasCollection() => familias;

  Future<String> addFamily(Familia familia) {
    //adicionar o objecto em forma de json para a coleção de minions
    return familias.add(familia.toJson()).then((value) {
      return familias_users
          .add({"familiaId": value, "userId": authService.userId})
          .then((value) => "${familia.nome} adicionado")
          .catchError((error) =>
              "Parece que teve problemas com o último Produto:\n $error");
    }).catchError(
        (error) => "Parece que teve problemas com o último Produto:\n $error");
  }

  Future<QuerySnapshot> queryCollection(queryString) async {
    //retorna o snapshot equivalente aos objectos json onde
    // o nome é igual ao passado como argumento
    return await familias.where('nome', isEqualTo: queryString).get();
  }

  Future updateFamilia(nome, novoNome) {
    //com base na coleção pegamos todos os dados que nela existem, que retorna
    //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
    return familias.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
        if (doc['nome'] == nome) {
          familias
              .doc(doc.id) //pegar o id do documento que se pretende actualizar
              .update({'nome': novoNome})
              .then((value) => "Mudou nome da familia para $novoNome")
              .catchError((error) =>
                  "Oops, parece que não deu pra actualizar:\n $error");
        }
      });
    });
  }

  Future<String> addUser(familia_name, userId) async {
    QuerySnapshot familia =
        await familias.where('nome', isEqualTo: familia_name).get();
    String familiaId = familia.docs[0].reference.id;
    return familias_users
        .add({"familiaId": familiaId, "userId": userId})
        .then((value) => "Foi adicionado a $familia_name")
        .catchError((error) =>
            "Parece que teve problemas com o último Produto:\n $error");
  }
}
