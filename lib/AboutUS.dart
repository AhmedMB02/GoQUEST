import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomAppBar.dart';
import 'DrawerDemo.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({super.key,required this.prefs});
  final SharedPreferences prefs;

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        drawer:DrawerDemo(prefs: widget.prefs),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/astrolab.png'),
            radius: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'Astrolab Agency',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'For more details',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () async {
              final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'contact@astrolab-agency.com', // Remplacez par l'adresse e-mail que vous souhaitez ouvrir
                queryParameters: {
                  'subject': 'Sujet de l\'e-mail', // Facultatif, définissez le sujet de l'e-mail si nécessaire
                },
              );
            final String _emailUri = _emailLaunchUri.toString();
            if (await canLaunch(_emailUri)) {
              await launch(_emailUri);
            } else {
              throw 'Impossible d\'ouvrir l\'e-mail.';
            }
            },
            child: Text('contact@astrolab-agency.com', 
              style: TextStyle(
              color: Color.fromARGB(255, 4, 178, 190), 
              decoration: TextDecoration.underline, 
              ),
            ),
          )
        ],
      ),
        )
    );
  }
}







/*



class AboutUS extends StatelessWidget {
  const AboutUS({super.key,required this.prefs});
  final SharedPreferences prefs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        drawer:DrawerDemo(prefs: prefs,),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/astrolab.png'),
            radius: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'Astrolab Agency',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'For more details',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () async {
              final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'contact@astrolab-agency.com', // Remplacez par l'adresse e-mail que vous souhaitez ouvrir
                queryParameters: {
                  'subject': 'Sujet de l\'e-mail', // Facultatif, définissez le sujet de l'e-mail si nécessaire
                },
              );
            final String _emailUri = _emailLaunchUri.toString();
            if (await canLaunch(_emailUri)) {
              await launch(_emailUri);
            } else {
              throw 'Impossible d\'ouvrir l\'e-mail.';
            }
            },
            child: Text('contact@astrolab-agency.com', 
              style: TextStyle(
              color: Color.fromARGB(255, 4, 178, 190), 
              decoration: TextDecoration.underline, 
              ),
            ),
          )
        ],
      ),
        )
    );
  }
}*/