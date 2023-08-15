import 'package:flutter/material.dart';
import 'package:vofz_app5/Subgroups.dart';
import 'package:vofz_app5/articles.dart';
import 'package:vofz_app5/creatives.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Groups(),
    articles(),
    creatives(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mic,
            ),
            title: Text(
              'Podcast',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article_outlined ,
            ),
            title: Text(
              'Articles',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_photo_alternate_outlined,
            ),
            title: Text(
              'Creatives',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}