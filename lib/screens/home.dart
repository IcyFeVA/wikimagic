import 'package:WikiMagic/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  DatabaseService? db;
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('TUTORIAL'),
                  onPressed: () async {},
                ),
                ElevatedButton(
                  child: const Text('SETTINGS'),
                  onPressed: () async {},
                ),
                ElevatedButton(
                  child: Text('CONNECT'),
                  onPressed: () async {
                    setState(() {
                      showLoader = true;
                    });
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('error signing in');
                    } else {
                      setState(() {
                        showLoader = false;
                      });
                      context.read<MyUser>().setID(result.uid);

                      String userPageID = generateRandomString(3);
                      context.read<UserPageID>().setID(userPageID);

                      DatabaseService(uid: result.uid).updateUserData('-', '-', userPageID);

                      Navigator.pushNamed(context, '/perform');
                    }
                  },
                ),
                Visibility(child: CircularProgressIndicator(), visible: showLoader),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
