// class MyUser {
//
//   final String? uid;
//
//   MyUser({this.uid});
//
// }

import 'package:flutter/material.dart';

class MyUser with ChangeNotifier {
  final String? uid;

  get theid => uid;

  MyUser({this.uid});
}