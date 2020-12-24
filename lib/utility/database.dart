import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _fireStoreInst = FirebaseFirestore.instance;
final _firebaseStorage = FirebaseStorage.instance;

void saveUserInfoToFireStore(
    {String uid, String name, String imageURL, String email}) {
  final ref = _fireStoreInst.collection('users').doc(uid);

  ref.set({'id': uid, 'name': name, 'email': email, 'imageURL': imageURL});
}

void createClassOnFirebase(
    {String uid,
    String name,
    String section,
    String subject,
    String instructor,
    String instructorPhotoUrl,
    bool isInst}) {
  final ref1 = _fireStoreInst
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
    'photoUrl': instructorPhotoUrl,
    'instructor': instructor,
    'isInstructor': true
  });

  final ref2 = _fireStoreInst.collection('singleClass').doc(ref1.id);
  ref2.set({
    'class_id': ref1.id,
    'instructor_id': uid,
    'name': name,
    'section': section,
    'subject': subject,
    'instructor': instructor,
    'isInstructor': true,
    'photoUrl': instructorPhotoUrl,
    'studentJoined': []
  });
}

void joinClassOnFirebase(
    {String classId,
    String name,
    String section,
    String subject,
    String studentUID,
    String studentName,
    String instructorPhotoUrl,
    String imageUrl}) {
  final ref = _fireStoreInst
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
    'instructor_photo_url': instructorPhotoUrl,
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

void unEnrolFromJoinedClass({String uid, String classId}) {
  final ref = _fireStoreInst
      .collection('classesCreated')
      .doc(uid)
      .collection('allClasses')
      .doc(classId);
  ref.delete();
}

void deleteCreatedClass({String uid, String classId}) {
  final ref = _fireStoreInst
      .collection('classesCreated')
      .doc(uid)
      .collection('allClasses')
      .doc(classId);
  ref.delete();
}

void updateAssignmentInClass(
    {String uid,
    String classId,
    String assignmentName,
    String url,
    String studentName,
    String studentPhotoUrl,
    bool isInstructor}) {
  final ref = FirebaseFirestore.instance
      .collection('assignments')
      .doc(classId)
      .collection('allAssignments')
      .doc();
  ref.set({
    'assignmentId': ref.id,
    'uid': uid,
    'assignmentName': assignmentName,
    'url': url,
    'studentName': studentName,
    'isInstructor': isInstructor,
    'photoUrl': studentPhotoUrl,
    'timestamp': Timestamp.now()
  });
}

Future<String> uploadAssignmentOnFirebaseStorage(
    {String postId, File file}) async {
  final ref = _firebaseStorage.ref().child('documents');
  StorageUploadTask storageUploadTask = ref.child(postId).putFile(file);
  StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
  String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}

void deleteAssignment({String classId, String assignmentId}) {
  final ref = _fireStoreInst
      .collection('assignments')
      .doc(classId)
      .collection('allAssignments')
      .doc(assignmentId);
  ref.delete();
}

void editClassroomDetails(
    {String uid, String classId, String section, String name, String subject}) {
  final ref = _fireStoreInst
      .collection('classesCreated')
      .doc(uid)
      .collection('allClasses')
      .doc(classId);
  ref.update({
    'name': name,
    'subject': subject,
    'section': section,
  });
}
