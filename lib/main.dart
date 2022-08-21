import 'package:flutter/material.dart';
import 'package:mymessage/screens/Chat_Screen.dart';
import 'package:mymessage/screens/Sign_In.dart';
import '../screens/Welcome_Screen.dart';
import 'screens/Registration_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.deepOrange)),
      //home: ChatScreen(),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.chatScreen
          : WelcomeScreen.welcomeScreen,
      routes: {
        WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
        SignIn.signIn: (context) => SignIn(),
        ChatScreen.chatScreen: (context) => ChatScreen(),
        ResgisterScreen.registrationScreen: (context) => ResgisterScreen(),
      },
    );
  }
}
