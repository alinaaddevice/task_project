import 'package:flutter/material.dart';
import 'package:task_project/screens/age/age_screen.dart';
import 'package:task_project/screens/name/name_screen.dart';
import 'package:task_project/shared/repositories/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => const NameScreen(),
          '/ageRange': (context) => const AgeRangeScreen()
        },
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color.fromRGBO(84, 19, 216, 1.0),
            fontFamily: 'OpenSans'));
  }
}
