import 'package:flutter/material.dart';
import 'package:quiz_app_ziyad/data/repository/question_repository.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_ziyad/ui/quiz/page/quiz_page.dart';
import 'package:quiz_app_ziyad/ui/style/font.dart';
import 'package:quiz_app_ziyad/ui/topics/page/topics_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 72.0),
            child: Icon(
              Icons.emoji_objects_outlined,
              size: 96.0,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Flutter Quiz App", style: textTheme.headline4),
          ),
          Text("Learn◾Take Quiz◾Repeat", style: textTheme.subtitle2),
          const SizedBox(height: 54),
          ElevatedButton(
              onPressed: () {
                onPlay(context);
              },
              child: SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    "PLAY",
                    style: textTheme.button,
                  ),
                ),
              )),
          OutlinedButton(
              onPressed: () {
                onTopics(context);
              },
              child: SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    "TOPICS",
                    style: textTheme.button,
                  ),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      onShare(context);
                    },
                    child: Row(
                      children: const [Icon(Icons.share), Text("Share")],
                    )),
              ),
              const SizedBox(
                width: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      onRateUs(context);
                    },
                    child: Row(
                      children: const [Icon(Icons.star_rate), Text("Rate Us")],
                    )),
              )
            ],
          )
        ],
      ),
    ));
  }

  void onPlay(BuildContext context) {
    print("onPlay");
    Navigator.pushNamed(context, QuizPage.routeName, arguments: "random");
  }

  void onTopics(BuildContext context) {
    print("onTopics");
    Navigator.pushNamed(context, TopicsPage.routeName);
  }

  void onShare(BuildContext context) {
    print("onShare");
  }

  void onRateUs(BuildContext context) {
    print("onRateUs");
  }
}
