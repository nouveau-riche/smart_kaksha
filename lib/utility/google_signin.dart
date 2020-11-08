import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database.dart';
import '../screens/home_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if(googleSignInAccount == null){
    return 'nikunj sharmna';
  }

  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  String name;
  String email;
  String imageUrl;

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if(user.uid == null){
    return 'null';
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser =  _auth.currentUser;
  assert(user.uid == currentUser.uid);


  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoURL != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;

  if(user.uid != null){
    saveUserInfoToFirestore(user.uid, name, imageUrl, email);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HomePage()));
  }

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  await _auth.signOut();
}
