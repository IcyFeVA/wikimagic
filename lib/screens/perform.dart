import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:animations/animations.dart';
import 'perform_display.dart';

class Perform extends StatefulWidget {
  const Perform({Key? key}) : super(key: key);

  @override
  State<Perform> createState() => _PerformState();
}

class _PerformState extends State<Perform> {
  final AuthService _auth = AuthService();
  bool _isPerforming = false;

  final SharedAxisTransitionType? _transitionType =
      SharedAxisTransitionType.horizontal;

  void _togglePerformStatus() {
    setState(() {
      _isPerforming = !_isPerforming;
    });
  }

  Widget PerformHome() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          child: const Text(
            'www.wikimagic.net/3hdi',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 14,
                decoration: TextDecoration.none),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _togglePerformStatus();
          },
          child: const Text('Display Lockscreen'),
        ),
        ElevatedButton(
            onPressed: () async {
              _auth.signOut();
            },
            child: const Text('End Session')),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverse: !_isPerforming,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: _transitionType!,
                    );
                  },
                  child: _isPerforming ? PerformDisplay(toggle: _togglePerformStatus) : PerformHome(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
