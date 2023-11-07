import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final String? uid;
  FirestoreHelper({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groups =
      FirebaseFirestore.instance.collection('groups');

  Future registerUser(String email) async {
    return await users.doc(uid).set({
      'name': email,
      'email': email,
      'groups': [],
      'friends': [],
      'invitations': [],
      'profilePic': '',
      'recogPic': '',
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

  Future createGroup(String userName, String uid, String groupName) async {
    DocumentReference groupDocumentReference = await groups.add({
      'groupName': groupName,
      'groupIcon': '',
      'admin': '${uid}_$userName',
      'members': [],
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
    });

    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_$userName']),
      'groupId': groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = users.doc(uid);
    await userDocumentReference.update({
      'groups':
          FieldValue.arrayUnion(['${groupDocumentReference.id}_$groupName']),
    });
  }
}
