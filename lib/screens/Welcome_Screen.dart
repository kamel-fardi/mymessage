import 'package:flutter/material.dart';
import 'package:mymessage/screens/Registration_Screen.dart';
import 'package:mymessage/screens/Sign_In.dart';

import '../Widgets/my_Button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String welcomeScreen = '/Welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset('images/Logo.png'),
                ),
                const Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(241, 120, 107, 1),
                  ),
                ),
                const SizedBox(height: 30),
                MyButton(
                  color: const Color.fromRGBO(241, 120, 107, 1),
                  title: 'Sign In',
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignIn.signIn);
                  },
                ),
                MyButton(
                  color: const Color.fromARGB(177, 78, 33, 28),
                  title: 'Register',
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ResgisterScreen.registrationScreen);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
