import 'package:flutter/material.dart';

class Produto with ChangeNotifier {
  String? _id, _nome, _descricao, _unidade, _prateleira;
  double? _pUnit, _qntdMinima, _disponivel, _quantidade;

  Produto(
      this._id,
      this._nome,
      this._descricao,
      this._unidade,
      this._prateleira,
      this._quantidade,
      this._disponivel,
      this._qntdMinima,
      this._pUnit);

  Produto.empty();

  double get qntdMinima => _qntdMinima!;

  setQntdMinima(double value) {
    _qntdMinima = value;
    notifyListeners();
  }

  double get pUnit => _pUnit!;

  setPunit(double value) {
    _pUnit = value;
    notifyListeners();
  }

  String get id => _id!;

  setId(String value) {
    _id = value;
    notifyListeners();
  }

  double get disponivel => _disponivel!;

  setDisponivel(double value) {
    _disponivel = value;
    notifyListeners();
  }

  double get quantidade => _quantidade!;

  setQuantidade(double value) {
    _quantidade = value;
    notifyListeners();
  }

  get prateleira => _prateleira;

  setPrateleira(value) {
    _prateleira = value;
    notifyListeners();
  }

  get unidade => _unidade;

  setUnidade(value) {
    _unidade = value;
    notifyListeners();
  }

  get descricao => _descricao;

  setDescricao(value) {
    _descricao = value ?? '';
    notifyListeners();
  }

  String get nome => _nome!;

  setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  Produto.fromJson(Map<String, dynamic> json) {
    _nome = json["nome"];
    _descricao = json["descricao"];
    _unidade = json["unidade"];
    _quantidade =
        json["quantidade"] != null ? json["quantidade"].toDouble() : 0.0;
    _prateleira = json["prateleira"];
    _disponivel =
        json["disponivel"] != null ? json["disponivel"].toDouble() : 0.0;
    _qntdMinima =
        json["qntdMinima"] != null ? json["qntdMinima"].toDouble() : 0.0;
    _pUnit = json["pUnitario"] != null ? json["pUnitario"].toDouble() : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["nome"] = this._nome;
    data["descricao"] = this._descricao;
    data["unidade"] = this._unidade;
    data["quantidade"] = this._quantidade;
    data["prateleira"] = this._prateleira;
    data["disponivel"] = this._disponivel;
    data["qntdMinima"] = this._qntdMinima;
    data["pUnitario"] = this._pUnit;

    return data;
  }
}
