import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';
import '../widgets/drawer.dart';
import '../utility/google_signin.dart';
import '../widgets/create_or_join_classroom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String imageUrl = "https://lh4.googleusercontent.com/-IAYOn4aVGjM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnDTKGYwe3laVoPNnFr22Mrb0QoJw/s96-c/photo.jpg";

  @override
//  void initState() {
//    super.initState();
//    User user = FirebaseAuth.instance.currentUser;
//    Future<Map<String,dynamic>> map = fetchUserDetails(user.uid);
//    map.then((value){
//      setState(() {
//        imageUrl = value['imageURL'];
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collage Classroom'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                signOutGoogle();
                Navigator.of(context).pushNamedAndRemoveUntil('./authentication_screen', (route) => false);
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 26),
        onPressed: () => buildBottomSheet(context),
      ),
    );
  }
}


