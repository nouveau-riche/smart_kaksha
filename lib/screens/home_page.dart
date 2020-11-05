import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';
import '../widgets/display_class.dart';
import '../widgets/drawer.dart';
import '../utility/google_signin.dart';
import '../widgets/create_or_join_classroom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String imageUrl;
//String imageUrl =
//    "https://lh4.googleusercontent.com/-IAYOn4aVGjM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnDTKGYwe3laVoPNnFr22Mrb0QoJw/s96-c/photo.jpg";

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;
    Future<Map<String, dynamic>> map = fetchUserDetails(user.uid);
    map.then((value) {
      setState(() {
        imageUrl = value['imageURL'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Collage Classroom',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    './authentication_screen', (route) => false);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: buildDrawerContent(),
      ),
      body: stream(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        child: Icon(Icons.add, size: 30),
        onPressed: () => buildBottomSheet(context),
      ),
    );
  }

  Widget stream() {
    User user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('classesCreated')
            .doc(user.uid)
            //.doc('b9GI7GgwhrdPLwDFe9AKvOPstFE2')
            .collection('allClasses')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final _data = snapshot.data;
            List<DisplayClass> classes = [];
            _data.docs.map((doc) {
              classes.add( DisplayClass(
                className: doc['name'],
                section: doc['section'],
                isInstructor: doc['isInstructor'],
              ));
            }).toList();
            return ListView.builder(
              itemBuilder: (ctx, index) => classes[index],
              itemCount: classes.length,
            );
            //return Text('finding bug');
          } else {
            return Text('No active Clasees');
          }
        });
  }
}
