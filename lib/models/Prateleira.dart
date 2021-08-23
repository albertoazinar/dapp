import 'package:flutter/material.dart';

class Shelve with ChangeNotifier {
  String _nome;

  Shelve(this._nome);

  Shelve.empty();

  String get nome => _nome;

  setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  Shelve.fromJson(Map<String, dynamic> json) {
    _nome = json["nome"];
  }

  Map<String, String> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["nome"] = this._nome;

    return data;
  }
}
