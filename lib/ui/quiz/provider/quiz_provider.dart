import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:quiz_app_ziyad/data/model/question.dart';
import 'package:quiz_app_ziyad/data/repository/question_repository.dart';

class QuizProvider extends ChangeNotifier {
  final QuestionRepository questionRepository;
  final String topic;
  final List<Question> questions = [];
  final List<String> myAnswers = [];
  bool finish = false;
  int counter = 30;
  int currentQuestionCount = 1;
  late Timer timer;

  void saveAnswer(String answer) {
    try {
      myAnswers.add(answer);
      if (currentQuestionCount == questions.length) {
        finish = true;
        timer.cancel();
        notifyListeners();
        return;
      }
      currentQuestionCount++;
      counter = 30;
      notifyListeners();
    } catch (e) {
      // print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void determinateIndicator() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      print(counter);
      try {
        if (counter == 0) {
          saveAnswer("No Answer");
        } else {
          counter--;
          notifyListeners();
        }
      }catch(e){
        // print(e);
      }
    });
  }

  QuizProvider({required this.questionRepository, required this.topic}) {
    _getAllQuestion();
    determinateIndicator();
  }

  Future<dynamic> _getAllQuestion() async {
    try {
      if (topic == "random") {
        final questionsList = await questionRepository.getAllQuestion();
        if (questionsList.isNotEmpty) {
          questions.addAll(questionsList);
          notifyListeners();
        } else {
          print("empty");
        }
      } else {
        final questionsList =
            await questionRepository.getAllQuestionByTopics(topic);
        if (questionsList.isNotEmpty) {
          questions.addAll(questionsList);
          notifyListeners();
        } else {
          print("empty");
        }
      }
    } catch (e) {
      notifyListeners();
      print(e);
    }
  }
}
