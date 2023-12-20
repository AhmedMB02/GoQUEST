import 'package:flutter/material.dart';
import 'package:q_project/QuizHistoryPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AboutUS.dart';
import 'SecondPage.dart';

class DrawerDemo extends StatelessWidget {
  const DrawerDemo({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF70C0C0),
            ),
            child: Center(
              // Utilisation de Center pour centrer le texte
              child: Text(
                'Go QUEST',
                style: TextStyle(
                    color: Colors.white, fontSize: 32, fontFamily: 'Calistoga'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black, // Couleur de l'icône
            ),
            title: Text('Home Page'),
            onTap: () {
              // Action lorsque l'option 1 est sélectionnée
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondPage(prefs:prefs)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.black, // Couleur de l'icône
            ),
            title: Text('About us'),
            onTap: () {
              // Action lorsque l'option 1 est sélectionnée
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutUS(
                            prefs: prefs,
                          )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.black, // Couleur de l'icône
            ),
            title: Text('Historic'),
            onTap: () {
              // Action lorsque l'option 3 est sélectionnée
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizHistoryPage(
                            prefs: prefs,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
