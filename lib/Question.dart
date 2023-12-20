class Option {
  final String text;
  bool isSelected;

  Option(this.text, this.isSelected);
}

class Question {
  final String title;
  final List<Option> options;
  final List<int> correctAnswers;

  Question(this.title, this.options,this.correctAnswers);
  
}