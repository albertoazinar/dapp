import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensa/services/auth_service.dart';

import 'GetIt.dart';

class CommonServices {
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<bool> alreadyExists(String queryString, String colecao) async {
    return await users
        .doc(getIt<AuthService>().userId)
        .collection(colecao)
        .where('nome', isEqualTo: queryString)
        .get()
        .whenComplete(() {})
        .then((value) => value.docs.length != 0);
  }
}
