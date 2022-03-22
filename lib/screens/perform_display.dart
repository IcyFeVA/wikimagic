import 'package:WikiMagic/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:provider/provider.dart';

class PerformDisplay extends StatefulWidget {
  final Function? toggle;

  const PerformDisplay({Key? key, this.toggle}) : super(key: key);

  @override
  State<PerformDisplay> createState() => _PerformDisplayState();
}

class _PerformDisplayState extends State<PerformDisplay> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          final Map<String, dynamic> doc = snapshot.data?.data() as Map<String, dynamic>;

          return Scaffold(
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onDoubleTap: () {
                if(widget.toggle != null) {
                  widget.toggle!();
                }
              },
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data?.get('searchterm')}'),
                      Text('${snapshot.data?.get('selection')}'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      }
    );
  }
}
