import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Perform extends StatefulWidget {
  const Perform({Key? key}) : super(key: key);

  @override
  State<Perform> createState() => _PerformState();
}

class _PerformState extends State<Perform> {
  SharedPreferences? preferences;
  Stream<QuerySnapshot>? usersStream;
  String? uid;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    uid = preferences?.getString('uid') ?? 'R3RCBb11uFUiBhi1ZeRK';
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displaySmall!,
      textAlign: TextAlign.center,
      child: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(snapshot.data.get('selections'),
                    style: const TextStyle(color: Colors.white)),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('fetching...', style: TextStyle(color: Colors.white)),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );

    // return StreamBuilder<QuerySnapshot>(
    //   stream: usersStream,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }
    //
    //     String searches = snapshot.data!.docs.first.get('searches');
    //     print(searches);
    //
    //     return Text(searches);
    //   },
    // );
  }
}
