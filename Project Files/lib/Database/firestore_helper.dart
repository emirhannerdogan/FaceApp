import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:faceapp/Database/local_helper.dart';
import 'package:path_provider/path_provider.dart';

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
    return await users.doc(uid).update({
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

  Future uploadProfilePicture(String uid, File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('recogPictures')
          .child(uid)
          .child('recog_picture.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Get the download URL once the upload is complete
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // You can save this download URL to Firestore if needed
      await users.doc(uid).update({'recogPic': downloadURL});
    } catch (e) {
      // Handle any errors that might occur during the upload process
      print('Error uploading recog picture: $e');
    }
  }

  Future<void> downloadAndSaveProfilePicture(
      String uid, String downloadURL) async {
    try {
      // Check if the file already exists locally
      String? localPath = await LocalHelper.getProfilePicture();

      if (localPath == null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String directoryPath = '${appDocDir.path}/$uid';
        String filePath = '$directoryPath/recogPic.jpg';

        // Create the directory if it doesn't exist
        await Directory(directoryPath).create(recursive: true);

        Reference storageReference =
            FirebaseStorage.instance.refFromURL(downloadURL);

        File downloadToFile = File(filePath);
        await storageReference.writeToFile(downloadToFile);

        await LocalHelper.saveProfilePicture(filePath);
      }
    } catch (e) {
      print('Error downloading profile picture: $e');
    }
  }
}
