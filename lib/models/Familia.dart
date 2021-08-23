import 'package:flutter/material.dart';

class Familia with ChangeNotifier {
  String _nome, _owner;

  Familia(this._nome, this._owner);

  Familia.empty();

  String get nome => _nome;

  setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  get owner => _owner;

  set owner(value) {
    _owner = value;
  }

  Familia.fromJson(Map<String, String> json) {
    this._nome = json["nome"];
    this._owner = json["owner"];
  }

  Map<String, String> toJson() {
    Map<String, String> data = new Map<String, String>();
    data["nome"] = this._nome;
    data["owner"] = this._owner;

    return data;
  }
}
