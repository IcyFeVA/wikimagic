import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  late SharedPreferences preferences;
  late Stream<QuerySnapshot> usersStream;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    String email = preferences.getString('email') ?? 'hi@icyfeva.com';

    usersStream = FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        String searches = snapshot.data!.docs.first.get('searches');
        print(searches);

        return Text(searches);
      },
    );
  }
}
