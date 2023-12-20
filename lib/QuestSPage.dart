import 'package:flutter/material.dart';
import 'package:q_project/quizz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomAppBar.dart';
import 'DrawerDemo.dart';
import 'QuizHistoryItem.dart';
import 'SecondPage.dart';

class QuestSPage extends StatefulWidget {
  const QuestSPage({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  _QuestSPageState createState() => _QuestSPageState();
}

class _QuestSPageState extends State<QuestSPage> {
  List<QuizQuestion> myQuestions = [
    QuizQuestion(
        question: "Who won the first football world cup in 1930 ?",
        option1: OptionQuizz(option: "Brazil", value: 0),
        option2: OptionQuizz(option: "Uruguay", value: 1),
        option3: OptionQuizz(option: "Germany", value: 2)),
    QuizQuestion(
        question:
            "In which sport might you encounter terms like 'backhand' and 'volley'?",
        option1: OptionQuizz(option: "Volleyball", value: 3),
        option2: OptionQuizz(option: "Cycling", value: 4),
        option3: OptionQuizz(option: "Tennis", value: 5)),
    QuizQuestion(
        question:
            "How many players are there on a standard volleyball team on the court at one time?",
        option1: OptionQuizz(option: "5", value: 6),
        option2: OptionQuizz(option: "6", value: 7),
        option3: OptionQuizz(option: "7", value: 8)),
    QuizQuestion(
        question: "Who is the player who wins the most Ballon d'Or?",
        option1: OptionQuizz(option: "Leo Messi", value: 9),
        option2: OptionQuizz(option: "Cristiano Ronaldo", value: 10),
        option3: OptionQuizz(option: "Diego Maradona", value: 11)),
    QuizQuestion(
        question: "In the game of chess, what piece can move diagonally?",
        option1: OptionQuizz(option: "Knight", value: 12),
        option2: OptionQuizz(option: "Pawn", value: 13),
        option3: OptionQuizz(option: "Bishop", value: 14)),
    QuizQuestion(
        question:
            "Which country is known for popularizing the sport of sumo wrestling?",
        option1: OptionQuizz(option: "China", value: 15),
        option2: OptionQuizz(option: "Japan", value: 16),
        option3: OptionQuizz(option: "India", value: 17)),
    QuizQuestion(
        question: "What nationality does Usain Bolt have?",
        option1: OptionQuizz(option: "Senegalese", value: 18),
        option2: OptionQuizz(option: "American", value: 19),
        option3: OptionQuizz(option: "Jamaican", value: 20)),
    QuizQuestion(
        question:
            "What is the term for a perfect score in a gymnastics routine?",
        option1: OptionQuizz(option: "A 'perfect 10'", value: 21),
        option2: OptionQuizz(option: "A flawless finish", value: 22),
        option3: OptionQuizz(option: "A gymnastic genius", value: 23)),
    QuizQuestion(
        question: "Which club won the champions league in 2000s?",
        option1: OptionQuizz(option: "Bayern Munich", value: 24),
        option2: OptionQuizz(option: "Valence Fc", value: 25),
        option3: OptionQuizz(option: "Real Madrid", value: 26)),
    QuizQuestion(
        question: "In which sport is 'the puck' a key element?",
        option1: OptionQuizz(option: "Track and Field", value: 27),
        option2: OptionQuizz(option: "Ice Hockey", value: 28),
        option3: OptionQuizz(option: "Basketball", value: 29)),
  ];

  List<int> groupValues = [];

  List<List<bool>> userAnswers = [];
  List<String> userHistory = [];
  @override
  void initState() {
    super.initState();
    // Initialiser groupValues avec des valeurs par défaut
    groupValues = List<int>.filled(myQuestions.length, -1);
    userAnswers = List.generate(
      myQuestions.length,
      (questionIndex) =>
          List.generate(myQuestions[questionIndex].option1.value, (_) => false),
    );
    getList();
  }

  // List contient tout les réponses correcte
  List<int> myResults = [1, 5, 7, 9, 14, 16, 20, 21, 26, 28];
  int score = 0;

  // méthode qui vérifie si toute les réponses sont répondus
  bool areAllQuestionsAnswered(List<int> groupValues) {
    return !groupValues.contains(-1);
  }

  //stocker les éléments de l'historique
  List<QuizHistoryItem> quizHistory = [];

  void addToQuizHistory(int score, String quizName) {
    final now = DateTime.now();
    final formattedDate = "${now.year}-${now.month}-${now.day}";
    final historyItem = QuizHistoryItem(
      date: formattedDate,
      score: score,
      quizName: quizName,
    );
    setState(() {
      quizHistory.add(historyItem);
    });
  }

  getList() {
    userHistory = widget.prefs.getStringList("list") ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: myQuestions.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 260,
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
                            myQuestions[index].question,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                              child: Column(children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color.fromARGB(255, 4, 178, 190),
                                  value: myQuestions[index].option1.value,
                                  groupValue: groupValues[index],
                                  onChanged: (value) {
                                    if (myResults.contains(value)) {
                                      score++;
                                    }
                                    setState(() {
                                      groupValues[index] = value!;
                                    });
                                  },
                                ),
                                Text(myQuestions[index].option1.option),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color.fromARGB(255, 4, 178, 190),
                                  value: myQuestions[index].option2.value,
                                  groupValue: groupValues[index],
                                  onChanged: (value) {
                                    if (myResults.contains(value)) {
                                      score++;
                                    }
                                    setState(() {
                                      groupValues[index] = value!;
                                    });
                                  },
                                ),
                                Text(myQuestions[index].option2.option),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color.fromARGB(255, 4, 178, 190),
                                  value: myQuestions[index].option3.value,
                                  groupValue: groupValues[index],
                                  onChanged: (value) {
                                    if (myResults.contains(value)) {
                                      score++;
                                    }
                                    setState(() {
                                      groupValues[index] = value!;
                                    });
                                  },
                                ),
                                Text(myQuestions[index].option3.option),
                              ],
                            ),
                          ])),
                        ]),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  addToQuizHistory(score, "Sport");
                  userHistory.add("\nName : Sport \nScore: ${score} \nDate: ${DateTime.now().toString()}");
                  saveList(userHistory);
                  if (areAllQuestionsAnswered(groupValues)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Result"),
                          content: Text("Your score : $score points in ${myQuestions.length}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SecondPage(prefs: widget.prefs)));
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
                                  Navigator.of(context)
                                      .pop(SecondPage(prefs: widget.prefs));
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
