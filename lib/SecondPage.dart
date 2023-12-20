import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomAppBar.dart';
import 'DrawerDemo.dart';
import 'QuestHPage.dart';
import 'QuestSPage.dart';
import 'QuestTPage.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: DrawerDemo(
          prefs: this.prefs,
        ),
        body: Center(
          child: MyPageViewContent(prefs: prefs),
        ));
  }
}

class MyPageViewContent extends StatefulWidget {
  const MyPageViewContent({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  _MyPageViewContentState createState() => _MyPageViewContentState();
}

class _MyPageViewContentState extends State<MyPageViewContent> {
  String category = "";

  void navigateToSelectedPage() {
    if (category == 'tech') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestTPage(
                  prefs: widget.prefs,
                )),
      );
    } else if (category == 'sp') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestSPage(
                  prefs: widget.prefs,
                )),
      );
    } else if (category == 'hist') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestHPage(
                  prefs: widget.prefs,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFD9D9D9),
                  border: Border.all(color: Color(0xFF70C0C0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Choose the category you want",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "tech",
                        groupValue: category,
                        onChanged: (val) {
                          setState(() {
                            category = val!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 4, 178, 190),
                      ),
                      Text("Technology")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "sp",
                        groupValue: category,
                        onChanged: (val) {
                          setState(() {
                            category = val!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 4, 178, 190),
                      ),
                      Text("Sport")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "hist",
                        groupValue: category,
                        onChanged: (val) {
                          setState(() {
                            category = val!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 4, 178, 190),
                      ),
                      Text("History")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            navigateToSelectedPage();
                          },
                          child: Text("begin "),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 4, 178, 190),
                              textStyle: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
