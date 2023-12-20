class QuizQuestion {
  final String question;
  final OptionQuizz option1;
  final OptionQuizz option2;
  final OptionQuizz option3;

  QuizQuestion(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.option3});
}

class OptionQuizz {
  final String option;
  final int value;

  OptionQuizz({required this.option, required this.value});
}
