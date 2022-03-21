import 'package:flutter/material.dart';

class Perform extends StatefulWidget {
  const Perform({Key? key}) : super(key: key);

  @override
  State<Perform> createState() => _PerformState();
}

class _PerformState extends State<Perform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: () {
          Navigator.pop(context);
        },
        child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('Hello'),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
