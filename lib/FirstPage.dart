import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SecondPage.dart';
import 'dart:async';

class FirstPage extends StatefulWidget {
  SharedPreferences prefs;
  FirstPage({super.key, required this.prefs});
  
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    // Utilise Timer pour déclencher la navigation après 3 secondes
    Timer(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SecondPage(prefs: widget.prefs,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Color.fromARGB(255, 4, 178, 190),
      child: Text("Go QUEST ",
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontFamily: 'Calistoga')),
    )));
  }
}
