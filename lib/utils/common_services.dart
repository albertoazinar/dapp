import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/services/familia_service.dart';

import 'GetIt.dart';

class CommonServices {
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<bool> alreadyExists(String queryString, String colecao) async {
    return await users
        .doc(getIt<FamiliaService>().familia.id)
        .collection(colecao)
        .where('nome', isEqualTo: queryString)
        .get()
        .whenComplete(() {})
        .then((value) => value.docs.length != 0);
  }
}
