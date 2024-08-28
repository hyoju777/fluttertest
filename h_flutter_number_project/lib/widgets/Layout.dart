import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/views/AddNumberScreen.dart';
import 'package:h_flutter_example_project/views/FavoriteNumberListScreen.dart';
import 'package:h_flutter_example_project/views/RootScreen.dart';

class Layout extends StatefulWidget{
  Layout({super.key});

  @override
  LayoutState createState() => LayoutState();
}


class LayoutState extends State<Layout>{
  int _currunIndex = 0;


  void _onItemTapped(int index){
    setState(() {
      _currunIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Rootscreen(),
    FavoriteNumberListScreen(),
    AddNumberScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold로 변경
        appBar: AppBar(title: const Text("전화번호")), // AppBar 추가
        body: _pages[_currunIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.coffee),
                label: "Favorite"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "main"
            ),
          ],
          currentIndex: _currunIndex,
          onTap: _onItemTapped,
        )
    );
  }
}