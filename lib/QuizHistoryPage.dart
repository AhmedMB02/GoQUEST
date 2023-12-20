import 'package:flutter/material.dart';
import 'CustomAppBar.dart';
import 'DrawerDemo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QuizHistoryPage extends StatefulWidget {
  const QuizHistoryPage({super.key, required this.prefs});
  final SharedPreferences prefs;
  _QuizHistoryPageState createState() => _QuizHistoryPageState();
}

class _QuizHistoryPageState extends State<QuizHistoryPage> {
  List<String> userHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    //get min shared preference
    super.initState();
    GetData();
  }

   GetData() async {
    final pref = await SharedPreferences.getInstance();
    final savedDataList = pref.getStringList('list') ?? [];
    pref.getStringList("list") ?? [];
    setState(() {
      userHistory = savedDataList ;
    });
  }


  getList() {
    userHistory = widget.prefs.getStringList("list") ?? []; 
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerDemo(prefs: widget.prefs),
      body: ListView.builder(
        itemCount: userHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userHistory[index]),
            // Vous pouvez ajouter d'autres fonctionnalités aux ListTile ici
          );
        },
      ),
    );
  }
}
