import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'perform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Perform()),
                );
              },
              child: const Text('Display Lockscreen'),
            ),
            ElevatedButton(
                onPressed: () async {
                  _auth.signOut();
                },
                child: const Text('End Session')),
          ],
        ),
      ),
    );
  }
}
