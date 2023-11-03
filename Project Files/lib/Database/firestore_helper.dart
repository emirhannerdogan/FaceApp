import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final String? uid;
  FirestoreHelper({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future registerUser(String email) async {
    return await users.doc(uid).set({
      'name': email,
      'email': email,
      'groups': [],
      'profilePic': '',
      'uid': uid,
    });
  }

  Future updateUserName(String name) async {
    return await users.doc(uid).set({
      'name': name,
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: email).get();
    return querySnapshot;
  }
}
