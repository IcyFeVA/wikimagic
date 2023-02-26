import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                            child: const Text('CONNECT & PERFORM'),
                            onPressed: () {
                                Navigator.pushNamed(context, '/perform');
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
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/about');
                            },
                            style: OutlinedButton.styleFrom(shape: StadiumBorder()),
                            child: const Text(
                              "ABOUT",
                              style: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 13),
                            ),
                          )
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
