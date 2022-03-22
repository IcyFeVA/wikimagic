import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference col =
      FirebaseFirestore.instance.collection('userdata');

  Future updateUserData(
      String searchterm, String selection, String pageid) async {
      return await col.doc(uid).set({'searchterm': searchterm, 'selection': selection, 'pageID': pageid});
  }

  Stream<DocumentSnapshot> get userData {
    return col.doc(uid).snapshots();
  }
}
