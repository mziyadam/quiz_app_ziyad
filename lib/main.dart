import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_ziyad/firebase_options.dart';
import 'package:quiz_app_ziyad/ui/home/page/home_page.dart';
import 'package:quiz_app_ziyad/ui/quiz/page/quiz_page.dart';
import 'package:quiz_app_ziyad/data/model/result_arguments.dart';
import 'package:quiz_app_ziyad/ui/result/page/result_page.dart';
import 'package:quiz_app_ziyad/ui/topics/page/topics_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        TopicsPage.routeName: (context) => TopicsPage(),
        QuizPage.routeName: (context) => QuizPage(
            topic: ModalRoute.of(context)?.settings.arguments as String),
        ResultPage.routeName: (context) => ResultPage(
            resultArguments:
                ModalRoute.of(context)?.settings.arguments as ResultArguments),
      },
    );
  }
}
