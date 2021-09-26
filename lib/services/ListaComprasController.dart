import 'package:despensa/models/Produto.dart';
import 'package:mobx/mobx.dart';

part 'ListaComprasController.g.dart';

class ListaComprasController = ListaComprasControllerBase
    with _$ListaComprasController;

abstract class ListaComprasControllerBase with Store {
  @observable
  ObservableList listaDeCompra = [].asObservable();

  @action
  addProductItem(Produto productItem) {
    listaDeCompra.add(productItem);
  }

  @action
  removeLastProductItem() {
    listaDeCompra.removeLast();
  }

  @action
  removeProductItem(Produto productItem) {
    listaDeCompra.removeWhere((item) => item.id == productItem.id);
  }

  @action
  reset() {
    listaDeCompra.clear();
  }
}
