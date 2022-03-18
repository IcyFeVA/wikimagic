import 'package:WikiMagic/services/auth.dart';
import 'package:WikiMagic/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _uid = '2JWtsBxIVtNrbeAOkJTrYbX0vL93';
  final AuthService _auth = AuthService();
  final Stream<QuerySnapshot> users = Firestore.instance.collection('users').where('uid', isEqualTo: '2JWtsBxIVtNrbeAOkJTrYbX0vL93').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  //dynamic result = await _auth.signInWithEmailAndPassword('hi@icyfeva.com', 'Marsmx23');
                  //print('fantastic $result');
                },
                child: Text('Sign in')),
            Container(
              height: 250,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong. Snapshot Error.');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('loading...');
                  }

                  final data = snapshot.requireData;
                  return ListView.builder(
                    itemCount: data.documents.length,
                    itemBuilder: (context, index) {
                      return Text(data.documents[index]['searches']);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
