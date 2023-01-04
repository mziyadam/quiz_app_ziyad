import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_ziyad/data/repository/question_repository.dart';
import 'package:quiz_app_ziyad/ui/quiz/page/quiz_page.dart';
import 'package:quiz_app_ziyad/ui/style/font.dart';
import 'package:quiz_app_ziyad/ui/topics/provider/topics_provider.dart';

class TopicsPage extends StatelessWidget {
  static const routeName = '/topics';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TopicsProvider>(
      create: (context) =>
          TopicsProvider(questionRepository: QuestionRepository()),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Topics',
              style: textTheme.headline6,
            ),
          ),
          body: Consumer<TopicsProvider>(
              builder: (context, TopicsProvider data, widget) {
            if (data.topics.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          QuizPage.routeName,
                          arguments: data.topics[index] ?? "random",
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            data.topics[index] ?? "",
                            style: textTheme.subtitle1,
                          ),
                          trailing: const Icon(Icons.arrow_right),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: data.topics.length,
              );
            }
          })),
    );
  }
}
