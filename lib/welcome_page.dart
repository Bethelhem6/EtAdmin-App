
import 'package:flutter/material.dart';

import 'auth/login_admin.dart';
import 'auth/signup_admin.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/landing-screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // final List<String> _images = [
  //   'assets/front.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: Image.asset(
          //     'assets/emptycart.png',
          //     fit: BoxFit.cover,
          //     // alignment: FractionalOffset(_animation.value, 0),
          //   ),
          // ),
          Container(
            color: Colors.deepPurple[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                ),
                Center(
                  child: Text(
                    'BJ Etherbal Shop',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 45),
                  ),
                ),
                Center(
                  child: Text(
                    ' Admin Page',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}
