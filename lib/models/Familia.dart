import 'package:despensa/models/Prateleira.dart';
import 'package:flutter/material.dart';

class Familia with ChangeNotifier {
  String _id = '';
  String? _nome, _owner;
  List<Shelve>? _prateleiras = [];
  int? _qntdMinima = 0;

  Familia(
      this._id, this._nome, this._owner, this._prateleiras, this._qntdMinima);

  Familia.empty();

  String get id => _id;
  setId(String value) {
    _id = value;
    notifyListeners();
  }

  String get nome => _nome!;

  setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  get owner => _owner;

  setOwner(String userId) {
    _owner = userId;
    notifyListeners();
  }

  List<Shelve> get prateleiras => _prateleiras!;

  setPrateleiras(List<Shelve> value) {
    _prateleiras = value;
    notifyListeners();
  }

  setQntdMinima(int qntdMinimaCtrl) {
    _qntdMinima = qntdMinimaCtrl;
    notifyListeners();
  }

  addQntdMinima() {
    _qntdMinima = _qntdMinima! + 1;
    notifyListeners();
  }

  subtractQntdMinima() {
    _qntdMinima = _qntdMinima! - 1;
    notifyListeners();
  }

  int get qntdMinima => _qntdMinima!;

  Familia.fromJson(Map<String, dynamic> json) {
    this._id = json["id"];
    this._nome = json["nome"];
    this._owner = json["owner"];
    this._prateleiras = json["prateleiras"];
    this._qntdMinima = json["quantidadeMinima"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();

    data["id"] = this._id;
    data["nome"] = this._nome;
    data["owner"] = this._owner;
    data["prateleiras"] = this._prateleiras;
    data["quantidadeMinima"] = this._prateleiras;

    return data;
  }
}
