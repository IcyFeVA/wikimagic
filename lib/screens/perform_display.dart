import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakelock/wakelock.dart';

final supabase = Supabase.instance.client;

class PerformDisplay extends StatefulWidget {
  final Function? toggle;

  const PerformDisplay({Key? key, this.toggle}) : super(key: key);

  @override
  State<PerformDisplay> createState() => _PerformDisplayState();
}

class _PerformDisplayState extends State<PerformDisplay> {
  late DateTime _initialTime;
  late final Timer _timer;
  var hours = DateFormat("hh").format(DateTime.now());
  var minutes = DateFormat("mm").format(DateTime.now());

  final _stream = supabase.from('userdata').stream(primaryKey: ['url']).eq('url', 'dqu').limit(1);

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        hours = DateFormat("hh").format(DateTime.now());
        minutes = DateFormat("mm").format(DateTime.now());
      });
    });

    Wakelock.enable();
  }


  @override
  void dispose() {
    Wakelock.disable();
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<MyUser>(context);



    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            String txt1 = "-";
            String txt2 = "-";

            final data = snapshot.data!.asMap();
            data.forEach((key, value) {
              txt1 = value['searchterm'];
              txt2 = value['focusword'];
            });

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
