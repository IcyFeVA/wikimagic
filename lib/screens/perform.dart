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
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          child: Text(
            'wiki.ae.org/' + Provider.of<UserPageID>(context).pageid,
            style: TextStyle(
                color: Color(0xFF1FC4BA),
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
              await _auth.signOut();
              Navigator.pushNamed(context, '/');
            },
            child: const Text('End Session')),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          // context.read<MySearchTerm>().searchterm;
          // context.read<MySelection>().selection;

          return Scaffold(
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
        } else {
          return Container();
        }

      }
    );
  }
}
