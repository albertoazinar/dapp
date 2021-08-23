import 'package:flutter/material.dart';

class Produto with ChangeNotifier {
  String _nome, _descricao, _unidade, _prateleira;
  int _quantidade, _disponivel;

  Produto(this._nome, this._descricao, this._unidade, this._prateleira,
      this._quantidade, this._disponivel);

  Produto.empty();

  int get disponivel => _disponivel;

  int setDisponivel(int value) {
    _disponivel = value;
    notifyListeners();
  }

  int get quantidade => _quantidade;

  setQuantidade(int value) {
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
    _descricao = value;
    notifyListeners();
  }

  String get nome => _nome;

  setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  Produto.fromJson(Map<String, dynamic> json) {
    _nome = json["nome"];
    _descricao = json["descricao"];
    _unidade = json["unidade"];
    _quantidade = json["quantidade"];
    _prateleira = json["prateleira"];
    _disponivel = json["disponivel"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["nome"] = this._nome;
    data["descricao"] = this._descricao;
    data["unidade"] = this._unidade;
    data["quantidade"] = this._quantidade;
    data["prateleira"] = this._prateleira;
    data["disponivel"] = this._disponivel;

    return data;
  }
}
