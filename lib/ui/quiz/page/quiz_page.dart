import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app_ziyad/data/repository/question_repository.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_ziyad/ui/home/page/home_page.dart';
import 'package:quiz_app_ziyad/ui/quiz/provider/quiz_provider.dart';
import 'package:quiz_app_ziyad/data/model/result_arguments.dart';
import 'package:quiz_app_ziyad/ui/result/page/result_page.dart';
import 'package:quiz_app_ziyad/ui/style/font.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz';
  final String topic;

  QuizPage({required this.topic});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return ChangeNotifierProvider<QuizProvider>(
      create: (context) => QuizProvider(
          questionRepository: QuestionRepository(), topic: widget.topic),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Quiz Page',
              style: textTheme.headline6,
            ),
            actions: [
              TextButton(
                  style: style,
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(HomePage.routeName));
                  },
                  child: Text(
                    "Exit",
                    style: textTheme.subtitle2,
                  )),
            ],
          ),
          body: Consumer<QuizProvider>(
              builder: (context, QuizProvider data, widget) {
            if (data.finish) {
              Future.delayed(Duration.zero, () {
                Navigator.popAndPushNamed(context, ResultPage.routeName,
                    arguments: ResultArguments(
                        myAnswer: data.myAnswers, myQuestion: data.questions));
              });
            }
            return data.questions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.red,
                          color: Colors.greenAccent,
                          minHeight: 10,
                          value: data.counter / 30.0,
                        ),
                      ),
                      Expanded(
                          child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16.0,0.0,16.0,16.0),
                                child: Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        data
                                                .questions[
                                                    data.currentQuestionCount -
                                                        1]
                                                .question ??
                                            "",
                                        textAlign: TextAlign.center,
                                        style: textTheme.bodyText1,
                                      ),
                                      data
                                                      .questions[
                                                          data.currentQuestionCount -
                                                              1]
                                                      .questionImg ==
                                                  "" ||
                                              data
                                                      .questions[
                                                          data.currentQuestionCount -
                                                              1]
                                                      .questionImg ==
                                                  null
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                data
                                                    .questions[
                                                        data.currentQuestionCount -
                                                            1]
                                                    .questionImg!,
                                                fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, left: 16.0),
                                child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data
                                        .questions[
                                            data.currentQuestionCount - 1]
                                        .choices
                                        ?.length,
                                    itemBuilder: (context, choiceIndex) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          minimumSize:
                                              const Size.fromHeight(10), // NEW
                                        ),
                                        onPressed: () => {
                                          data.saveAnswer(data
                                              .questions[
                                                  data.currentQuestionCount - 1]
                                              .choices![choiceIndex])
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            data
                                                .questions[
                                                    data.currentQuestionCount -
                                                        1]
                                                .choices![choiceIndex],
                                            style: textTheme.bodyText2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      )),
                    ],
                  );
          })),
    );
  }
}
