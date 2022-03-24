import 'dart:async';

import 'package:WikiMagic/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
    var hours = DateFormat("hh").format(DateTime.now());
    var minutes = DateFormat("mm").format(DateTime.now());

    var timeRefresher;
    if (timeRefresher == null) {
      timeRefresher = Timer.periodic(const Duration(seconds: 1), (timer) {
        print('hi');
        // setState(() {
        //   hours = DateFormat("hh").format(DateTime.now());
        //   minutes = DateFormat("mm").format(DateTime.now());
        // });
      });
    }

    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map<String, dynamic> doc =
                snapshot.data?.data() as Map<String, dynamic>;

            String txt1 = snapshot.data?.get('searchterm');
            String txt2 = snapshot.data?.get('selection');

            if (txt1 == '-') {
              txt1 = 'Upcoming Alarm';
            }
            if (txt2 == '-') {
              txt2 = 'Tomorrow 8:00 AM';
            }

            return Scaffold(
              body: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: () {
                  if (widget.toggle != null) {
                    timeRefresher.cancel();
                    widget.toggle!();
                  }
                },
                child: Scaffold(
                  backgroundColor: Colors.black,
                  body: SafeArea(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 160),
                          Column(
                            children: <Widget>[
                              Container(
                                child: Text(hours,
                                    style: TextStyle(
                                        color: Color(0xFF929292),
                                        fontSize: 80,
                                        fontFamily: 'Roboto')),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 80.0),
                                child: Text(minutes,
                                    style: TextStyle(
                                        height: 0.8,
                                        color: Color(0xFF929292),
                                        fontSize: 80,
                                        fontFamily: 'Roboto')),
                              ),
                            ],
                          ),
                          Icon(Icons.alarm, color: Color(0xFF4E4E4E), size: 22),
                          Text(txt1,
                              style: TextStyle(
                                  color: Color(0xFF4E4E4E), height: 1.7)),
                          Text(txt2,
                              style: TextStyle(
                                  color: Color(0xFF4E4E4E), fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
