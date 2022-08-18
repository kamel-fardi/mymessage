import 'package:flutter/material.dart';
import 'package:mymessage/screens/Chat_Screen.dart';
import 'package:mymessage/screens/Sign_In.dart';
import '../screens/Welcome_Screen.dart';
import 'screens/Registration_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.deepOrange)),
      //home: ChatScreen(),
      initialRoute: WelcomeScreen.welcomeScreen,
      routes: {
        WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
        SignIn.signIn: (context) => SignIn(),
        ChatScreen.chatScreen: (context) => ChatScreen(),
        ResgisterScreen.registrationScreen: (context) => ResgisterScreen(),
      },
    );
  }
}
