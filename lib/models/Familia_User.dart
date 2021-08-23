import 'package:flutter/material.dart';

class FamiliaUser with ChangeNotifier {
  String _userId, _familiaId;

  FamiliaUser(this._userId, this._familiaId);

  FamiliaUser.empty();

  get familiaId => _familiaId;

  setFamiliaId(value) {
    _familiaId = value;
  }

  String get userId => _userId;

  setUserId(String value) {
    _userId = value;
  }

  FamiliaUser.fromJson(Map<String, String> json) {
    this._userId = json['userId'];
    this._familiaId = json['familiaId'];
  }

  Map<String, String> toJson() {
    Map<String, String> data = new Map<String, String>();

    data['userId'] = this._userId;
    data['familiaId'] = this._familiaId;

    return data;
  }
}
