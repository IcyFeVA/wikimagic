import 'package:WikiMagic/helpers/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/auth.dart';
import 'package:animations/animations.dart';
import 'perform_display.dart';
import '../services/database.dart';

// class UserPageID extends StatelessWidget {
//   const UserPageID({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String id = context.watch<UserPageID>().pageid;
//     return Text(id);
//   }
// }

class Perform extends StatefulWidget {
  const Perform({Key? key}) : super(key: key);

  @override
  State<Perform> createState() => _PerformState();
}

class _PerformState extends State<Perform> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  bool _isPerforming = false;

  final SharedAxisTransitionType? _transitionType =
      SharedAxisTransitionType.horizontal;

  void _togglePerformStatus() {
    setState(() {
      _isPerforming = !_isPerforming;
    });
  }

  Widget PerformHome() {
    //String a = Provider.of<UserPageID>(context).pageid;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 0),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Your spectators url',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 128),
              child: Text(
                'wima.app/' + Provider.of<UserPageID>(context).pageid,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF1FC4BA),
                    fontSize: 13,
                    decoration: TextDecoration.none),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: const [
                    Text(
                      'Peek spectators thoughts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      '(Double-Tap to exit screen)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFBABABA),
                          fontSize: 13,
                          decoration: TextDecoration.none),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _togglePerformStatus();
                },
                child: const Text('ALWAYS ON DISPLAY'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF5E41D4)),
                  minimumSize: MaterialStateProperty.all(Size(300, 50)),
                ),
              ),
            ),
            Opacity(
              opacity: 0.3,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('BLACK SCREEN (soon)'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF5E41D4)),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  ),
                ),
              ),
            ),
          ]),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 72),
            child: ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('END SESSION'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                backgroundColor: MaterialStateProperty.all(Color(0xFF372A43)),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: Container(
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
                    child: _isPerforming
                        ? PerformDisplay(toggle: _togglePerformStatus)
                        : PerformHome(),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
