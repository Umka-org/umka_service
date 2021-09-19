import 'dart:io';
import 'dart:convert';

import 'package:umka_proto/generated/umka.pb.dart';

final List<Question> questionsDb = _readDb();

List _getQuestionsList() {
  final jsonString = File('db/questions_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

List<Question> _readDb() => _getQuestionsList()
    .map((entry) => Question()
      ..id = entry['id']
      ..text = entry['text'])
    .toList();

String? getCorrectAnswerById(int questionId) {
  final jsonList = _getQuestionsList();

  final correctAnswer = jsonList.firstWhere(
    (element) => element['id'] == questionId,
    orElse: () => null,
  );

  return correctAnswer?['answer'];
}
