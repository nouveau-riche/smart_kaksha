import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestoreInst = FirebaseFirestore.instance;
final _firebaseStrorage = FirebaseStorage.instance;

void saveUserInfoToFirestore(
    String uid, String name, String imageURL, String email) {
  final ref = _firestoreInst.collection('users').doc(uid);

  ref.set({'id': uid, 'name': name, 'email': email, 'imageURL': imageURL});
}

Future<Map<String, dynamic>> fetchUserDetails(String uid) async {
  final ref = _firestoreInst.collection('users').doc(uid);

  DocumentSnapshot snapshot = await ref.get();
  return snapshot.data();
}

void saveClassOnFirebase(String uid, String name, String section,
    String subject, String instructor, bool isInst) {
  final ref1 = _firestoreInst
      .collection('classesCreated')
      .doc(uid)
      .collection('allClasses')
      .doc();
  ref1.set({
    'class_id': ref1.id,
    'instructor_id': uid,
    'name': name,
    'section': section,
    'subject': subject,
    'instructor': instructor,
    'isInstructor': true
  });

  final ref2 = _firestoreInst.collection('singleClass').doc(ref1.id);
  ref2.set({
    'class_id': ref1.id,
    'instructor_id': uid,
    'name': name,
    'section': section,
    'subject': subject,
    'instructor': instructor,
    'isInstructor': true,
    'studentJoined': []
  });
}

void joinClassOnFirebase(String classId, String name, String section,
    String subject, String studentUID, String studentName, String imageUrl) {
  final ref = _firestoreInst
      .collection('classesCreated')
      .doc(studentUID)
      .collection('allClasses')
      .doc(classId);
  ref.set({
    'class_id': classId,
    'student_id': studentUID,
    'name': name,
    'section': section,
    'subject': subject,
    'isInstructor': false
  });

  final ref1 =
      FirebaseFirestore.instance.collection('singleClass').doc(classId);
  ref1.update({
    'studentJoined': FieldValue.arrayUnion([
      {'studentName': studentName, 'studentImageUrl': imageUrl}
    ])
  });
}

void updateAssignmentInClass(String classId,String url,String studentName,bool isInstructor) {
  final ref = FirebaseFirestore.instance.collection('singleClass').doc(classId);
  ref.update({
    'assignments': FieldValue.arrayUnion([{
      'url': url,
      'name': studentName,
      'isInstructor': isInstructor
    }])
  });
}

void fetchClasses(String uid) async {
  final ref = _firestoreInst
      .collection('classesCreated')
      .doc(uid)
      .collection('allClasses');
  QuerySnapshot snapshot =
      await ref.orderBy('timestamp', descending: true).get();
}

Future<String> uploadAssignmentOnFirebaseStorage(String uid, File file) async {
  final ref = _firebaseStrorage.ref().child(uid);
  StorageUploadTask storageUploadTask = ref.child(uid).putFile(file);
  StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
  String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}
