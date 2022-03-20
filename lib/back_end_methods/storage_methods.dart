import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // STORE PIC
  Future<String> uploadProfileBackgroundPic({
    required String userId,
    required bool isProfilePic,
    required Uint8List picData,
  }) async {
    TaskSnapshot taskSnapshot = await _firebaseStorage
        .ref()
        .child(isProfilePic ? "profilePics" : "backgroundPics")
        .child(userId)
        .putData(picData);

    return await taskSnapshot.ref.getDownloadURL();
  }
}
