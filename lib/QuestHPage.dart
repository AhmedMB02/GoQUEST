import 'package:flutter/material.dart';
import 'CustomAppBar.dart';
import 'DrawerDemo.dart';
import 'Question.dart';
import 'SecondPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestHPage extends StatefulWidget {
  const QuestHPage({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  _QuestHPageState createState() => _QuestHPageState();
}

class _QuestHPageState extends State<QuestHPage> {
  List<Question> questions = [
    Question(
      "What were the causes of World War I?",
      [
        Option('Militarism', false),
        Option('Invention of the telephone', false),
        Option('Nationalism', false),
      ],
      [0, 2], // Indice des réponses correctes
    ),
    Question(
      "Who were the key figures in the American Revolution?",
      [
        Option('John Adams', false),
        Option('Benjamin Franklin', false),
        Option('George Washington', false),
        Option('Albert Einstein', false),
      ],
      [0, 1, 2], // Indice de la réponse correcte
    ),
    Question(
      "When did Tunisia become independent?",
      [
        Option('March 20, 1956', false),
        Option('March 20, 1966', false),
        Option('January 14, 2011', false),
      ],
      [0], // Indice de la réponse correcte
    ),
    Question(
      "Who were significant leaders during the French Revolution?",
      [
        Option('Cleopatra', false),
        Option('Marie Antoinette', false),
        Option('King Louis XVI', false),
        Option('Julius Caesar', false),
      ],
      [1, 2], // Indice de la réponse correcte
    ),
    Question(
      "What were the contributing factors to the fall of the Berlin Wall in 1989?",
      [
        Option('Changes in Soviet policy', false),
        Option('Invention of the internet', false),
        Option('Discovery of extraterrestrial life', false),
        Option('Peaceful protests', false),
      ],
      [0, 3], // Indice de la réponse correcte
    ),
    Question(
      "Who was the first president of the United States?",
      [
        Option('George Washington', false),
        Option('Benjamin Franklin', false),
        Option('Thomas Jefferson', false),
      ],
      [0], // Indice de la réponse correcte
    ),
    Question(
      "Who was the founder of Islam and the last prophet according to Islamic belief?",
      [
        Option('Caliph Umar', false),
        Option('Prophet Muhammad (peace be upon him)', false),
        Option('Sultan Saladin', false),
      ],
      [1], // Indice de la réponse correcte
    ),
    Question(
      "Which empire was responsible for the construction of the Great Wall of China?",
      [
        Option('The Roman Empire', false),
        Option('The Chinese Qin Dynasty', false),
        Option('The British Empire', false),
        Option('The Ming Dynasty', false),
      ],
      [1, 3], // Indice de la réponse correcte
    ),
  ];

//----------------------------------------------------------
  List<List<bool>> userAnswers = [];
  List<String> userHistory = [];

  @override
  void initState() {
    super.initState();
    // Initialiser userAnswers avec des valeurs par défaut
    userAnswers = List.generate(
      questions.length,
      (questionIndex) =>
          List.generate(questions[questionIndex].options.length, (_) => false),
    );
    //mettre dans le shared preferences
    getList();
  }

  getList() {
    userHistory = widget.prefs.getStringList("list") ?? [];
  }

//---------------Methode Calcule Score
  int _calculateScore() {
    int score = 0;

    for (int i = 0; i < questions.length; i++) {
      bool isCorrect = true;

      for (int j = 0; j < questions[i].correctAnswers.length; j++) {
        final correctIndex = questions[i].correctAnswers[j];

        if (userAnswers[i][correctIndex] != true) {
          isCorrect = false;
          break;
        }
      }

      if (isCorrect) {
        score++;
      }
    }
    return score;
  }

  bool areAllQuestionsAnswered(List<List<bool>> userAnswers) {
    for (var answers in userAnswers) {
      if (!answers.contains(true)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print("${userHistory}");
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerDemo(
        prefs: widget.prefs,
      ),
      body: Column(
        children: [
          SizedBox(
            width: screenSize.width * 1,
            height: screenSize.height * 0.825,
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 320,
                    width: 400,
                    color: Colors.white,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                questions[index].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              for (int i = 0;
                                  i < questions[index].options.length;
                                  i++)
                                CheckboxListTile(
                                  activeColor: Color.fromARGB(255, 4, 178, 190),
                                  title: Text(questions[index].options[i].text),
                                  value: userAnswers[index][i],
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswers[index][i] = value!;
                                    });
                                  },
                                ),
                            ])));
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (areAllQuestionsAnswered(userAnswers)) {
                    int score = _calculateScore();
                    userHistory.add(
                        "\nName : History \nScore: ${score} \nDate: ${DateTime.now().toString()}");
                    saveList(userHistory);
                    print("${userHistory}");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Result"),
                          content: Text(
                              "Your score : $score points in ${questions.length}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondPage(
                                              prefs: widget.prefs,
                                            )));
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  color: Color(0xFF70C0C0),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Please answer all questions."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                                style: TextButton.styleFrom(
                                    primary: Color(0xFF70C0C0))),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(primary: Color(0xFF70C0C0))),
          )
        ],
      ),
    );
  }

  void saveList(List<String> userHistory) {
    widget.prefs.setStringList("list", userHistory);
  }
}
