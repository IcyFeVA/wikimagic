import 'dart:math';
import 'package:flutter/material.dart';

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'abcdefghijklmnopqrstuvwxyz';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

class UserPageID with ChangeNotifier {
  String _pageid = '___';
  String get pageid => _pageid;

  void setID(String newID) {
    _pageid = newID;
    notifyListeners();
  }
}

class MyUser with ChangeNotifier {
  String? _uid;
  get uid => _uid;

  void setID(String newID) {
    _uid = newID;
    notifyListeners();
  }
}

class MySearchTerm with ChangeNotifier {
  String _searchterm = '-';
  String get searchterm => _searchterm;

  void setSearchTerm(String newSearchTerm) {
    _searchterm = newSearchTerm;
    notifyListeners();
  }
}

class MySelection with ChangeNotifier {
  String _selection = '-';
  String get selection => _selection;

  void setSelection(String newSelection) {
    _selection = newSelection;
    notifyListeners();
  }
}