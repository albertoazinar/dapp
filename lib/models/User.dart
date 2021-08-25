class Utilizador {
  List<String> familias;

  Utilizador();

  Utilizador.fromJson(Map<String, dynamic> json) {
    familias = json["familias"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["familias"] = this.familias;

    return data;
  }
}
