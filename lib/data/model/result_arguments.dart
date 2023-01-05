import 'package:quiz_app_ziyad/data/model/question.dart';

class ResultArguments {
  final List<String> myAnswer;
  final List<Question> myQuestion;

  ResultArguments({required this.myAnswer, required this.myQuestion});
}
