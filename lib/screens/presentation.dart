import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Presentation extends StatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  SharedPreferences? preferences;
  Stream<QuerySnapshot>? usersStream;
  String? email;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    email = preferences?.getString('email') ?? 'hi@icyfeva.com';
    //email = preferences?.getString('email') ?? 'hi@icyfeva.com';
    //usersStream = FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots();

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
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
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(snapshot.data.docs[0]['searches'],
                    style: const TextStyle(color: Colors.white)),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
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
