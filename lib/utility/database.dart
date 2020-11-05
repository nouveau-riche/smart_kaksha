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
    String subject, String instructor,bool isInst) {
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
    'isInstructor': true
  });
}

void joinClassOnFirebase(
    String classId, String name,String section,String subject,String studentUID) {
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
    //'student_name': studentName,
    'isInstructor': false
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
