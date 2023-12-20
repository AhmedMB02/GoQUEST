import 'package:flutter/material.dart';
import 'package:q_project/DrawerDemo.dart';
import 'package:q_project/quizz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomAppBar.dart';
import 'QuizHistoryItem.dart';
import 'SecondPage.dart';

class QuestTPage extends StatefulWidget {
  const QuestTPage({super.key, required this.prefs});
  final SharedPreferences prefs;
  @override
  _QuestTPageState createState() => _QuestTPageState();
}

class _QuestTPageState extends State<QuestTPage> {
  // faire des objets de type QuizQuestion
  List<QuizQuestion> myQuestions = [
    QuizQuestion(
        question: "What year was the first UNIX operating system released?",
        option1: OptionQuizz(option: "1959", value: 0),
        option2: OptionQuizz(option: "1969", value: 1),
        option3: OptionQuizz(option: "1975", value: 2)),
    QuizQuestion(
        question:
            "Which area benefits the most from the Internet of Things (IoT)?",
        option1: OptionQuizz(option: "Streaming music", value: 3),
        option2: OptionQuizz(option: "Health Monitoring", value: 4),
        option3: OptionQuizz(option: "Online business", value: 5)),
    QuizQuestion(
        question:
            "What are the factors that influence the success of a technology startup?",
        option1: OptionQuizz(option: "Inadequate funding", value: 6),
        option2: OptionQuizz(option: "Solid business plan", value: 7),
        option3: OptionQuizz(option: "Technological innovation", value: 8)),
    QuizQuestion(
        question: "Which company developed the Android operating system?",
        option1: OptionQuizz(option: "Apple", value: 9),
        option2: OptionQuizz(option: "Microsoft", value: 10),
        option3: OptionQuizz(option: "Google", value: 11)),
    QuizQuestion(
        question:
            "What is the term used to describe the automation of tasks using robots?",
        option1: OptionQuizz(option: "Blockchain", value: 12),
        option2: OptionQuizz(option: "Robotique", value: 13),
        option3: OptionQuizz(option: "Machine learning", value: 14)),
    QuizQuestion(
        question:
            "What type of technology is used for contactless payment with a credit card?",
        option1: OptionQuizz(option: "NFC", value: 15),
        option2: OptionQuizz(option: "RFID", value: 16),
        option3: OptionQuizz(option: "WiFi", value: 17)),
    QuizQuestion(
        question: "What does 'URL' stand for in the context of web addresses?",
        option1: OptionQuizz(option: "Universal Record Locator", value: 18),
        option2: OptionQuizz(option: "Uniform Resource Locator", value: 19),
        option3: OptionQuizz(option: "User Registration Link", value: 20)),
    QuizQuestion(
        question:
            "What are the important criteria to consider when choosing an operating system for a personal computer?",
        option1: OptionQuizz(option: "Software available", value: 21),
        option2: OptionQuizz(option: "Preferred user interface", value: 22),
        option3: OptionQuizz(option: "Desired level of security", value: 23)),
    QuizQuestion(
        question:
            "What is the primary function of a CPU (Central Processing Unit) in a computer?",
        option1: OptionQuizz(option: "To display graphics", value: 24),
        option2: OptionQuizz(
            option: " To execute instructions and perform calculations",
            value: 25),
        option3: OptionQuizz(option: "To store data", value: 26)),
    QuizQuestion(
        question:
            "Which programming language is often used for developing web applications and websites?",
        option1: OptionQuizz(option: "Python", value: 27),
        option2: OptionQuizz(option: "Java", value: 28),
        option3: OptionQuizz(option: "JavaScript", value: 29)),
  ];

  List<List<bool>> userAnswers = [];
  List<String> userHistory = [];

  List<int> groupValues = [];
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


   // méthode qui vérifie si toute les réponses sont répondus
  bool areAllQuestionsAnswered(List<int> groupValues) {
    return !groupValues.contains(-1);
  }


  // List contient tout les réponses correcte
  List<int> myResults = [1, 4, 8, 11, 13, 15, 19, 23, 25, 29];
  int score = 0;

  //stocker les éléments de l'historique
  List<QuizHistoryItem> quizHistory = [];

  //méthode pour ajouter les infos du Quiz à passé
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
      drawer: DrawerDemo(prefs: widget.prefs),
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
                  addToQuizHistory(score, "Technology");
                  userHistory.add(
                        "\nName : Technology \nScore: ${score} \nDate: ${DateTime.now().toString()}");
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
