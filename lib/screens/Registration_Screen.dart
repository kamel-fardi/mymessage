import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mymessage/screens/Chat_Screen.dart';
import '../Widgets/my_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResgisterScreen extends StatefulWidget {
  static const String registrationScreen = '/registration_screen';
  //const ResgisterScreen({Key? key}) : super(key: key);

  @override
  State<ResgisterScreen> createState() => _ResgisterScreenState();
}

class _ResgisterScreenState extends State<ResgisterScreen> {
  final _auth = FirebaseAuth.instance;
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool showSpinner = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                controller: _email,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                // onChanged: ((value) {
                //   email = value;
                // }),
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
                  labelText: 'Email',
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
                controller: _password,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                textAlign: TextAlign.center,
                // onChanged: ((value) {
                //   password = value;
                // }),
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
                  labelText: 'Password',
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
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    // ignore: non_constant_identifier_names
                    final UserCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (UserCredential != null) {
                      Navigator.of(context).pushNamed(ChatScreen.chatScreen);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    if (e.code == 'user-not-found') {
                      print('User not found');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong Password');
                    }
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    print('Something bad happened');
                    print(e.runtimeType);
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
