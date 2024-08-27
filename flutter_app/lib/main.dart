import 'package:flutter/material.dart';
import 'package:flutter_app/views/CoffeeScreen.dart'; // CoffeeScreen import
import 'package:flutter_app/views/FavoriteScreen.dart'; // FavoriteScreen import
import 'package:flutter_app/views/MainScreen.dart'; // MainScreen import
import 'package:flutter_app/views/RegistrationPage.dart'; // RegistrationPage import 추가

void main() {
  runApp(const RootScreen());
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스 저장

  // 좋아요 커피 목록
  final List<Map<String, String>> favoriteCoffees = [
    {
      'title': 'Black Coffee',
      'description': 'A strong, bold coffee with a deep flavor.',
      'imagePath': 'assets/images/black_coffee.jpg',
    },
    {
      'title': 'Latte',
      'description': 'A smooth blend of espresso and steamed milk.',
      'imagePath': 'assets/images/latte.jpg',
    },
  ];

  // 각 탭에서 보여줄 화면을 리스트로 정의
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      CoffeeScreen(), // Home 화면
      FavoriteScreen(favoriteCoffees: favoriteCoffees), // Favorite 화면
      MainScreen(), // Main 화면
    ]);
  }

  // 탭 선택시 호출될 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 탭의 인덱스로 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Coffee App'),
        ),
        body: _pages[_selectedIndex], // 현재 선택된 탭에 따라 보여질 화면 결정
        floatingActionButton: _selectedIndex == 2 // 플로팅 액션 버튼이 Main 탭에서만 보이도록 설정
            ? FloatingActionButton(
          onPressed: () {
            // 등록 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()), // RegistrationPage로 이동
            );
          },
          child: const Icon(Icons.add),
        )
            : null, // 다른 탭에서는 플로팅 액션 버튼이 보이지 않음
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home', // 'Home' -> 'home'으로 수정
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'favorite', // 'Favorite' -> 'favorite'으로 수정
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'main', // 'Main' -> 'main'으로 수정
            ),
          ],
          currentIndex: _selectedIndex, // 현재 선택된 인덱스
          onTap: _onItemTapped, // 탭 선택시 호출될 함수
        ),
      ),
    );
  }
}
