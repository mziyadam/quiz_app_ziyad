import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_ziyad/data/model/question.dart';

class QuestionRepository {
  var db = FirebaseFirestore.instance;

  void injectData() async {
    final questions = [
      Question(
          topic: 'animals',
          question: 'Which is the fastest animal on the land?',
          questionImg:
              'https://zoo.sandiegozoo.org/sites/default/files/2021-09/thumb_cheetah.jpg',
          answer: 'Cheetah',
          choices: ['Lion', 'Tiger', 'Cheetah', 'Wolf']),
      Question(
          topic: 'animals',
          question:
              'Which mammal is known to have the most powerful bite in the world?',
          questionImg: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Nijlpaard.jpg/800px-Nijlpaard.jpg',
          answer: 'Hippopotamus',
          choices: ['Lion', 'Hippopotamus', 'Snake', 'Dog']),
      Question(
          topic: 'animals',
          question:
              'What object does a male penguin often gift to a female penguin to win her over?',
          questionImg: 'https://oceana.org/wp-content/uploads/sites/18/david_moir-reuters.jpg',
          answer: 'A pebble',
          choices: ['A car', 'An egg', 'A pebble', 'A blue vespa']),
      Question(
          topic: 'animals',
          question: 'How many hearts does an octopus have?',
          questionImg:
              'https://thecornishfishmonger.co.uk/media/catalog/product/_/p/_ptcreative_thecornishfishmonger-octopus-3080.jpg?width=900&height=600&store=default&image-type=image',
          answer: '3',
          choices: ['1', '2', '3', '4']),
      Question(
          topic: 'animals',
          question: 'What is a group of crows called?',
          questionImg:
              'https://www.birdspot.co.uk/wp-content/uploads/2019/12/group-crows.jpg',
          answer: 'A murder',
          choices: ['A murder', 'A crows zero', 'A crows group', 'A crowds']),
      Question(
          topic: 'sports',
          question: 'What sporting event has a strict dress code of all white?',
          questionImg:
              'https://www.mykhel.com/img/2022/07/wimbledon-trophy-1657198000.jpg',
          answer: 'Wimbledon',
          choices: [
            'Wimbledon',
            'Chennai Open',
            'Delhi Half Marathon',
            'Indian Masters'
          ]),
      Question(
          topic: 'sports',
          question: 'What height is a regulation NBA basket?',
          questionImg:
              'https://www.dictionary.com/e/wp-content/uploads/2022/03/20220322_basketball_1000x700-790x310.jpg',
          answer: '10 feet',
          choices: ['10 feet', '9 feet', '8 feet', '11 feet']),
      Question(
          topic: 'sports',
          question: 'What is the national sport of Japan?',
          questionImg: 'https://www.japan-guide.com/g21/2080_02.jpg',
          answer: 'Sumo Wrestling',
          choices: ['Wrestling', 'Karate', 'Sumo Wrestling', 'Taekwondo']),
      Question(
          topic: 'sports',
          question:
              'What was the first name of Argentinian soccer star Maradona?',
          questionImg:
              'https://www.realmadrid.com/img/horizontal_940px/maradona_gettyimages-537157025_20201229025034.jpg',
          answer: 'Diego',
          choices: ['Diego', 'David', 'Muhammad', 'Ramadhan']),
      Question(
          topic: 'sports',
          question: 'What does FIFA stand for in English?',
          questionImg:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/FIFA_logo_without_slogan.svg/800px-FIFA_logo_without_slogan.svg.png',
          answer: 'International Federation of Association Football',
          choices: [
            'Federation Association Football International',
            'Football Association Federation International',
            'International Federation of Association Football',
            'Football International Federation Association'
          ]),
      Question(
          topic: 'food and drink',
          question: 'What famous TV chef is noted for his use of swear words?',
          questionImg:
              'https://www.mashed.com/img/gallery/the-double-life-of-gordon-ramsay/intro.jpg',
          answer: 'Gordon Ramsay',
          choices: [
            'Gordon Ramsay',
            'Arnold Poernomo',
            'Tretan Muslim',
            'Coki Pardede'
          ]),
      Question(
          topic: 'food and drink',
          question: 'Where did sushi originate?',
          questionImg: 'https://www.pbs.org/food/files/2012/09/Sushi-1-1.jpg',
          answer: 'China',
          choices: ['Turkey', 'Korea', 'Japan', 'China']),
      Question(
          topic: 'food and drink',
          question:
              'Which of the following sauces is NOT traditionally vegan - Hoisin, Worcestershire, Mustard, Wasabi?',
          questionImg: 'https://www.webstaurantstore.com/images/products/large/594269/2141567.jpg',
          answer: 'Worcestershire',
          choices: ['Wasabi', 'Worcestershire', 'Mustard', 'Hoisin']),
      Question(
          topic: 'food and drink',
          question: 'What is the world’s best-selling stout beer?',
          questionImg:
              'https://www.liquor.com/thmb/g8j81x1BLqWicFenwikKnVWbtQg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-910481830-3c75cb0cfadb4e868961a02e748c2b27.jpg',
          answer: 'Guinness',
          choices: ['Bir Bintang', 'Anggur Merah', 'Guinness', 'Anggur Putih']),
      Question(
          topic: 'food and drink',
          question: 'What country drinks the most coffee?',
          questionImg:
              'https://media.istockphoto.com/id/1349239413/photo/shot-of-coffee-beans-and-a-cup-of-black-coffee-on-a-wooden-table.jpg?b=1&s=170667a&w=0&k=20&c=0bVq4jWM5d6r4Klp0si4um7QjZIQkMjYLtuDU7oWUps=',
          answer: 'Finland',
          choices: ['Finland', 'Ireland', 'Indonesia', 'USA']),
    ];
    for (var question in questions) {
      final docRef = db
          .collection("questions")
          .withConverter(
            fromFirestore: Question.fromFirestore,
            toFirestore: (Question question, options) => question.toFirestore(),
          )
          .doc();
      await docRef.set(question);
    }
  }

  Future<List<Question>> getAllQuestion() async {
    List<Question> questions = [];
    await db.collection("questions").get().then(
      (res) {
        List<Question> allQuestions = [];
        for (var i in res.docs) {
          allQuestions.add(Question.fromNonDataFirestore(i.data()));
        }
        var l = List.generate(allQuestions.length, (i) => i);
        l.shuffle();
        print(l);
        for(int i=0;i<5;i++){
          questions.add(allQuestions[l[i]]);
        }
        return questions;
      },
      onError: (e) => print("Error completing: $e"),
    );
    if (questions.isNotEmpty) {
      return questions;
    } else {
      throw Exception("empty");
    }
  }

  Future<List<Question>> getAllQuestionByTopics(String topic) async {
    List<Question> questions = [];
    await db
        .collection("questions")
        .where("topic", isEqualTo: topic)
        .get()
        .then(
      (res) {
        for (var i in res.docs) {
          questions.add(Question.fromNonDataFirestore(i.data()));
        }
        return questions;
      },
      onError: (e) => print("Error completing: $e"),
    );
    if (questions.isNotEmpty) {
      return questions;
    } else {
      throw Exception("empty");
    }
  }

  Future<List<String>> getTopicsList() async {
    Set<String> topicsSet = {};
    await db.collection("questions").get().then(
      (res) {
        for (var i in res.docs) {
          topicsSet.add(Question.fromNonDataFirestore(i.data()).topic ?? "");
        }
        return topicsSet.toList();
      },
      onError: (e) => print("Error completing: $e"),
    );
    if (topicsSet.isNotEmpty) {
      return topicsSet.toList();
    } else {
      throw Exception("empty");
    }
  }
}
