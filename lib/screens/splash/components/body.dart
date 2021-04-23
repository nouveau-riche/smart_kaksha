import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../vx_store.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../components/splash_content.dart';
import '../../../utility/google_signin.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MyStore store = VxState.store;

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Smart Kaksha, Let’s study!",
      "image": "assets/images/exam.png"
    },
    {
      "text": "We help students to connect with their teachers",
      "image": "assets/images/teacher.png"
    },
    {
      "text": "We show the easy way to study. \nJust stay at home with us",
      "image": "assets/images/study.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  IncrementPage(value);
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    VxBuilder(
                      mutations: {IncrementPage},
                      builder: (_, status) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                    buildSignInButton(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildSignInButton() {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 25,
            child: Image.asset('assets/images/google.jpg'),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Sign in with Google'),
        ],
      ),
      style: ElevatedButton.styleFrom(
          primary: kPrimaryColor, elevation: 2, padding: const EdgeInsets.all(5)),
      onPressed: () {
        signInWithGoogle(context).whenComplete(() {
          print('done successfully');
        });
      },
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: store.currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: store.currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
