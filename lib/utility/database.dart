import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestoreInst = FirebaseFirestore.instance;
final _firebaseStrorage = FirebaseStorage.instance;

void saveUserInfoToFirestore(String uid,String name,String imageURL,String email){
    final ref = _firestoreInst.collection('users').doc(uid);

    ref.set({
      'id':uid,
      'name': name,
      'email': email,
      'imageURL': imageURL
    });
}

Future<Map<String,dynamic>> fetchUserDetails(String uid) async {

  final ref = _firestoreInst.collection('users').doc(uid);

  DocumentSnapshot snapshot = await ref.get();
  return snapshot.data();
}

void saveClassOnFirebase(String uid,String name,String section,String subject,String instructor){
  final ref = _firestoreInst.collection('classes').doc(uid).collection('allClasses').doc();
  ref.set({
    'id': ref.id,
    'name': name,
    'section': section,
    'subject': subject,
    'instructor': instructor
  });
}