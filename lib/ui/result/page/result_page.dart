import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app_ziyad/data/model/question.dart';
import 'package:quiz_app_ziyad/data/model/result_arguments.dart';
import 'package:quiz_app_ziyad/ui/home/page/home_page.dart';
import 'package:quiz_app_ziyad/ui/style/font.dart';
import 'package:share_plus/share_plus.dart';

final Uri _downloadUrl = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.ziyad.quiz_app_ziyad');

class ResultPage extends StatelessWidget {
  static const routeName = '/result';
  late final List<String> myAnswer;
  late final List<Question> myQuestion;

  ResultPage({required ResultArguments resultArguments}) {
    myAnswer = resultArguments.myAnswer;
    myQuestion = resultArguments.myQuestion;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName(HomePage.routeName));
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Your Score',
              style: textTheme.headline6,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularPercentIndicator(
                    radius: 72.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 10.0,
                    percent:
                        (countCorrectness() / myQuestion.length).toDouble(),
                    center: Text(
                      "${countCorrectness()}/${myQuestion.length}",
                      style: textTheme.bodyText1,
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: Colors.redAccent,
                    progressColor: Colors.greenAccent,
                  ),
                ),
                ElevatedButton(
                    onPressed: shareScore,
                    child: Text(
                      "Share your score",
                      style: textTheme.button,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Report",
                    style: textTheme.headline6,
                  ),
                ),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    myQuestion[index].question ?? "",
                                    style: textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            myQuestion[index].answer == myAnswer[index]
                                ? Row(children: [
                                    const Icon(Icons.check_outlined,
                                        color: Colors.green),
                                    Expanded(
                                      child: Text(
                                        myAnswer[index],
                                        style: textTheme.bodyText2,
                                      ),
                                    )
                                  ])
                                : myAnswer[index].length >= 30
                                    ? Column(children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.close_outlined,
                                              color: Colors.red,
                                            ),
                                            Expanded(
                                              child: Text(
                                                myAnswer[index],
                                                style: textTheme.bodyText2,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.check_outlined,
                                                color: Colors.green),
                                            Expanded(
                                              child: Text(
                                                myQuestion[index].answer ?? "",
                                                style: textTheme.bodyText2,
                                              ),
                                            )
                                          ],
                                        )
                                      ])
                                    : Row(children: [
                                        const Icon(
                                          Icons.close_outlined,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          myAnswer[index],
                                          style: textTheme.bodyText2,
                                        ),
                                        const Icon(Icons.check_outlined,
                                            color: Colors.green),
                                        Text(
                                          myQuestion[index].answer ?? "",
                                          style: textTheme.bodyText2,
                                        )
                                      ])
                          ],
                        ));
                  },
                  itemCount: myQuestion.length,
                ),
              ],
            ),
          )),
    );
  }

  int countCorrectness() {
    int score = 0;
    for (int i = 0; i < myAnswer.length; i++) {
      if (myAnswer[i] == myQuestion[i].answer) {
        score++;
      }
    }
    return score;
  }

  shareScore() {
    Share.share(
        'I get ${countCorrectness()}/${myQuestion.length} correct in Quiz App.\n Download this app now! $_downloadUrl');
  }
}
