import 'package:fitness/screens/home_screen.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');

  SharedPreferences preferences1 = await SharedPreferences.getInstance();
  var password = preferences1.getString('password');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '100% Motivation',
    theme: ThemeData(
      //primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color.fromARGB(115, 49, 49, 49),
      textTheme: const TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        subtitle1: TextStyle(),
      ).apply(
        bodyColor: Colors.lightBlue,
        // displayColor: Colors.red,
      ),
    ),
    home: email == null && password == null
        ? const LoginScreen()
        : const HomeScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '100% Motivation',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(115, 49, 49, 49),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          subtitle1: TextStyle(),
        ).apply(
          bodyColor: Colors.lightBlue,
          displayColor: Colors.red,
        ),
      ),
    );
  }
}
