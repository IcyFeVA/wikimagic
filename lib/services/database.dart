import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  //String uid = "a";
  //DatabaseService({ this.uid });

  final CollectionReference users =  Firestore.instance.collection('users');

  void test() {
    dynamic test = Firestore.instance.collection('users');
  }

  Stream<QuerySnapshot> get userData {
    return users.snapshots();
  }

}

