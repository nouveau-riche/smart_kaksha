import 'package:flutter/material.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:velocity_x/velocity_x.dart';

// This is the best practice
import '../../../size_config.dart';
import '../components/splash_content.dart';
// import '../../../components/default_button.dart';
import '../../../vx_store.dart';


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
      "image": "assets/images/"
    },
    {
      "text":
          "We help students to conect with teacher \naround the India",
      "image": "assets/images/"
    },
    {
      "text": "We show the easy way to study. \nJust stay at home with us",
      "image": "assets/images/"
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
                  // setState(() {
                  //   currentPage = value;
                  // });
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
                    Spacer(),
                    VxBuilder(
                      mutations: {IncrementPage},
                      builder: (_,status) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                    ),
                    Spacer(flex: 3),
                    ElevatedButton(onPressed: (){}, child: Text('Continue'),),
                    // DefaultButton(
                    //   text: "Continue",
                    //   press: () {
                    //     Navigator.pushNamed(context, SignInScreen.routeName);
                    //   },
                    // ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    const kPrimaryColor = Color(0xFFFF7643);
    const kAnimationDuration = Duration(milliseconds: 200);
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
