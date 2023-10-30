import 'package:flutter/material.dart';
import 'package:vocabulario/screens/check_phrase_screen/vc_check_phrase_screen.dart';
import 'package:vocabulario/screens/vocabulary_list_screen/vc_vocabulary_list_screen.dart';

/// This is the main screen of the app containg a bottom navigation bar to
/// navigate between the different core screen of the app.
class VcMainScreen extends StatefulWidget {
  const VcMainScreen({super.key});

  @override
  State<VcMainScreen> createState() => _VcMainScreenState();
}

class _VcMainScreenState extends State<VcMainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    VcCheckPhraseScreen(),
    VcVocabularyListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Vocabulario'),
          backgroundColor: Theme.of(context).focusColor),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_sharp),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Vocabulary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
