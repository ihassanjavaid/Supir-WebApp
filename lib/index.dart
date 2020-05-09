import 'package:flutter/material.dart';
import 'package:supir/constants.dart';

class Index extends StatefulWidget {
  Index({this.screens});

  static const String id = 'index_screen';
  final List<Widget> screens;
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: kHomeIcon,
            title: Text(
              'Home',
            ),
            activeIcon: kHomeIconActive,
          ),
          BottomNavigationBarItem(
            icon: kPersonIcon,
            title: Text(
              'Gigs',
            ),
            activeIcon: kPersonIconActive,
          ),
          BottomNavigationBarItem(
            icon: kSettingsIcon,
            title: Text(
              'Tools',
            ),
            activeIcon: kSettingsIconActive,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}