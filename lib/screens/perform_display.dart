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
                                child: Text(
                                    DateFormat("hh").format(DateTime.now()),
                                    style: TextStyle(
                                        color: Colors.white10,
                                        fontSize: 80,
                                        fontFamily: 'Roboto')),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 80.0),
                                child: Text(
                                    DateFormat("mm").format(DateTime.now()),
                                    style: TextStyle(
                                        height: 0.8,
                                        color: Colors.white10,
                                        fontSize: 80,
                                        fontFamily: 'Roboto')),
                              ),
                            ],
                          ),
                          Icon(Icons.alarm, color: Colors.white10, size: 22),
                          Text(txt1,
                              style: TextStyle(
                                  color: Colors.white10, height: 1.7)),
                          Text(txt2,
                              style: TextStyle(
                                  color: Colors.white10, fontSize: 12)),
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
