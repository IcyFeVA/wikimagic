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

class MyUrl with ChangeNotifier {
  String _url = '?';
  String get url => _url;

  void setUrl(String newUrl) {
    _url = newUrl;
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

class MyFocusword with ChangeNotifier {
  String _focusword = '-';
  String get focusword => _focusword;

  void setSelection(String newFocusword) {
    _focusword = newFocusword;
    notifyListeners();
  }
}