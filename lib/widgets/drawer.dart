import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey,
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Todo App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse("https://www.google.com/"));
              },
              leading: Icon(Icons.person),
              title: Text(
                'About Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse("https://id.wikipedia.org/wiki/Monyet"));
              },
              leading: Icon(Icons.email_rounded),
              title: Text(
                'Contact Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
  }
}