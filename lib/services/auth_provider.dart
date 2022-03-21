import 'package:flutter/material.dart';
import 'auth.dart';

class WidgetProvider extends InheritedWidget {
  final AuthService auth;

  WidgetProvider({
    Key? key,
    required Widget child,
    required this.auth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static WidgetProvider? of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<WidgetProvider>());
}
