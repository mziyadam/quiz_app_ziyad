import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:quiz_app_ziyad/ui/quiz/page/quiz_page.dart';
import 'package:quiz_app_ziyad/ui/style/font.dart';
import 'package:quiz_app_ziyad/ui/topics/page/topics_page.dart';
import 'package:share_plus/share_plus.dart';

final Uri _downloadUrl = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.ziyad.quiz_app_ziyad');

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
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
                      onPressed: onRateUs,
                      child: Row(
                        children: const [
                          Icon(Icons.star_rate),
                          Text("Rate Us")
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  void onPlay(BuildContext context) {
    Navigator.pushNamed(context, QuizPage.routeName, arguments: "random");
  }

  void onTopics(BuildContext context) {
    Navigator.pushNamed(context, TopicsPage.routeName);
  }

  void onShare(BuildContext context) {
    Share.share('Download this app now! $_downloadUrl');
  }

  void onRateUs() async {
    LaunchReview.launch(androidAppId: "com.ziyad.quiz_app_ziyad");
  }
}
