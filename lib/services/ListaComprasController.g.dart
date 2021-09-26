// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListaComprasController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListaComprasController on ListaComprasControllerBase, Store {
  final _$listaDeCompraAtom =
      Atom(name: 'ListaComprasControllerBase.listaDeCompra');

  @override
  ObservableList<dynamic> get listaDeCompra {
    _$listaDeCompraAtom.reportRead();
    return super.listaDeCompra;
  }

  @override
  set listaDeCompra(ObservableList<dynamic> value) {
    _$listaDeCompraAtom.reportWrite(value, super.listaDeCompra, () {
      super.listaDeCompra = value;
    });
  }

  final _$ListaComprasControllerBaseActionController =
      ActionController(name: 'ListaComprasControllerBase');

  @override
  dynamic addProductItem(Produto productItem) {
    final _$actionInfo = _$ListaComprasControllerBaseActionController
        .startAction(name: 'ListaComprasControllerBase.addProductItem');
    try {
      return super.addProductItem(productItem);
    } finally {
      _$ListaComprasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeLastProductItem() {
    final _$actionInfo = _$ListaComprasControllerBaseActionController
        .startAction(name: 'ListaComprasControllerBase.removeLastProductItem');
    try {
      return super.removeLastProductItem();
    } finally {
      _$ListaComprasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeProductItem(Produto productItem) {
    final _$actionInfo = _$ListaComprasControllerBaseActionController
        .startAction(name: 'ListaComprasControllerBase.removeProductItem');
    try {
      return super.removeProductItem(productItem);
    } finally {
      _$ListaComprasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$ListaComprasControllerBaseActionController
        .startAction(name: 'ListaComprasControllerBase.reset');
    try {
      return super.reset();
    } finally {
      _$ListaComprasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaDeCompra: ${listaDeCompra}
    ''';
  }
}
