import 'package:WikiMagic/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:rive/rive.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  DatabaseService? db;
  bool showLoader = false;

  late Artboard artboard;
  late RiveAnimationController controller;

  @override
  void initState() {
    super.initState();
    artboard = Artboard();
    rootBundle.load("animations/gestures.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controller = SimpleAnimation("Double Tap"));
      setState(() => this.artboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  width: 232,
                    height: 232,
                    child: Image.asset('assets/images/logo.png')),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(72),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            child: const Text('PRESENATATION'),
                            onPressed: () async {},
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF372A43)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            child: const Text('HOW IT WORKS'),
                            onPressed: () async {},
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF372A43)),
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
