import 'package:WikiMagic/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';

const String VERSION = "0.7 Alpha";


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  DatabaseService? db;
  bool showLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF07080D),
                Color(0xFF131523),
                Color(0xFF07080D),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  width: 140,
                    height: 140,
                    child: Image.asset('assets/images/logo.png')),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 72.0, vertical: 0.0),
                    margin: const EdgeInsets.only(bottom: 80.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            child: const Text('HOW IT WORKS'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/howitworks');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                              minimumSize:
                              MaterialStateProperty.all(Size(300, 50)),
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xFF171B33)),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            child: const Text('PERFORMANCE PATTERN'),
                            onPressed: () async {},
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xFF171B33)),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            child: const Text('SETTINGS'),
                            onPressed: () async {},
                            style: ButtonStyle(
                              minimumSize:
                              MaterialStateProperty.all(Size(300, 50)),
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xFF171B33)),
                            ),
                          ),
                        ),

                        Container(
                          child: ElevatedButton(
                            child: Column(children: [
                              Text('CONNECT & PERFORM'),
                              Container(
                                child: Visibility(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 8),
                                      child: SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      ),
                                    ),
                                    visible: showLoader),
                              )
                            ]),
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

                                DatabaseService(uid: result.uid)
                                    .updateUserData('-', '-', userPageID);

                                Navigator.pushNamed(context, '/perform');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF5E41D4)),
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 64),
                          child: const Text(
                            VERSION,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFBABABA),
                                fontSize: 13,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
