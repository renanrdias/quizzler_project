class Question {
  String _question;
  bool _answer;

  // Constructor Function. Good practice.
  Question(this._question, this._answer);

  String get questionText {
    return _question;
  }

  bool get questionAnswer {
    return _answer;
  }
}
