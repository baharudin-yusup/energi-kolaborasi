// Create a CollectionReference called users that references the firestore collection
import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

CollectionReference users = FirebaseFirestore.instance.collection('users');
FirebaseFirestore firestore = FirebaseFirestore.instance;

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future<void> setUserData({
  @required String uid,
  Map<String, Object> data,
}) async {
  return await users.doc(uid).set(data);
}

Future<bool> updateFirestore({
  @required String collectionPath,
  @required String uid,
  @required Map<String, dynamic> data,
}) async {
  return await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(uid)
      .update(data)
      .then((value) => true);
}

Future<String> createFirestore({
  @required String collectionPath,
  String documentPath,
  Map<String, Object> data,
}) async {
  if (documentPath == null) {
    // Generate UID
    return await firestore
        .collection(collectionPath)
        .add(data)
        .then((value) => value.id)
        .catchError((error) => print("Failed to add user: $error"));
  } else {
    return await firestore
        .collection(collectionPath)
        .doc(documentPath)
        .set(data)
        .then((value) => '')
        .catchError((error) => print("Failed to add user: $error"));
  }
}

Future<DocumentSnapshot> getFirestoreDocument({
  @required String collectionPath,
  @required String documentPath,
  Map<String, Object> data,
}) async {
  return await firestore.collection(collectionPath).doc(documentPath).get();
}

Future<DocumentSnapshot> getUserData(String uid) async {
  return await users.doc(uid).get();
}

Future<String> uploadFile(
    {@required String directory,
    @required String uid,
    @required String filePath,
    @required String name}) async {
  File file = File(filePath);

  String fileName = file.path.split('/').last;

  await storage.ref('$directory/$uid/$name').putFile(file);

  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref('$directory/$uid/$name')
      .getDownloadURL();
  return downloadURL;
}

Future<void> deleteFile({@required String url}) async {
  await storage.refFromURL(url).delete();
}

Future<String> storageUploadSingeFile(
    String storagePath, String filePath) async {
  // await firebase_core.Firebase.initializeApp();

  File file = File(filePath);

  String fileName = 'abstract.pdf';

  firebase_storage.Reference reference =
      storage.ref().child(storagePath).child(fileName);

  String downloadUrl;

  // firebase_storage.UploadTask task = storage.ref(downloadUrl).putFile(file);
  firebase_storage.UploadTask uploadTask = reference.putFile(file);

  uploadTask.whenComplete(() async {
    print("COMPLETE!");
    downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  });

  return null;
  // task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) async {
  //   print('Task state: ${snapshot.state}');
  //   print(
  //       'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
  //
  //   // TODO: ADD PROGRESS BAR
  //
  //   if (snapshot.state == firebase_storage.TaskState.success) {
  //     print('OKEEEE');
  //     return await storage.ref(downloadUrl).getDownloadURL();
  //   } else {
  //     print('ERROR');
  //
  //   }
  //
  //
  //
  // }, onError: (e) {
  //   // The final snapshot is also available on the task via `.snapshot`,
  //   // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
  //   print(task.snapshot);
  //
  //   if (e.code == 'permission-denied') {
  //     print('User does not have permission to upload to this reference.');
  //   }
  // });
}
