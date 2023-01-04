import 'package:flutter/foundation.dart';
import 'package:quiz_app_ziyad/data/repository/question_repository.dart';

class TopicsProvider extends ChangeNotifier{
  final QuestionRepository questionRepository;
  List<String> topics=[];

  TopicsProvider({required this.questionRepository}){
    _getTopicsList();
  }

  Future<dynamic> _getTopicsList() async {
    try {
        final topicsList = await questionRepository.getTopicsList();
        if (topicsList.isNotEmpty) {
          topics.addAll(topicsList);
          notifyListeners();
        } else {
          print("empty");
        }
    } catch (e) {
      notifyListeners();
      print(e);
    }
  }
}