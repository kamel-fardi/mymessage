import 'package:flutter/material.dart';
import '../Widgets/my_Button.dart';

class ResgisterScreen extends StatefulWidget {
  static const String registrationScreen = '/registration_screen';
  //const ResgisterScreen({Key? key}) : super(key: key);

  @override
  State<ResgisterScreen> createState() => _ResgisterScreenState();
}

class _ResgisterScreenState extends State<ResgisterScreen> {
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
            SizedBox(
              height: 180,
              child: Image.asset('images/Logo.png'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: ((value) {}),
              decoration: const InputDecoration(
                hintText: 'Enter your Email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(241, 120, 107, 1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.pink, width: 3),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              autocorrect: false,
              enableSuggestions: false,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: ((value) {}),
              decoration: const InputDecoration(
                hintText: 'Enter your Password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(241, 120, 107, 1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.pink, width: 3),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              color: const Color.fromRGBO(241, 120, 107, 1),
              title: 'Resgister',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
