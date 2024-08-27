import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/CoffeeItem.dart';
import 'package:flutter_app/widgets/CoffeeWidget.dart';

class CoffeeScreen extends StatefulWidget {
  CoffeeScreen({super.key});

  @override
  _CoffeeScreenState createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  List<CoffeeItem> coffees = [
    CoffeeItem(title: "1번 커피", description: "1번 설명", url: "assets/image.png"),
    CoffeeItem(title: "2번 커피", description: "2번 설명", url: "assets/image.png"),
    CoffeeItem(title: "3번 커피", description: "3번 설명", url: "assets/image.png"),
    CoffeeItem(title: "4번 커피", description: "4번 설명", url: "assets/image.png"),
  ];

  // 좋아요 상태를 저장할 리스트
  List<bool> likedCoffees = List.generate(4, (index) => false);

  // 커피 항목을 삭제하는 함수
  void _removeCoffeeItem(int index) {
    setState(() {
      coffees.removeAt(index);
      likedCoffees.removeAt(index);
    });
  }

  // 좋아요 상태를 변경하는 함수
  void _toggleLike(int index) {
    setState(() {
      likedCoffees[index] = !likedCoffees[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee Cards"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: coffees.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CoffeeWidget(
                coffeeItem: coffees[index],
                index: index,
                onDelete: () => _removeCoffeeItem(index),
                onLike: () => _toggleLike(index), // 좋아요 콜백 추가
                isLiked: likedCoffees[index], // 좋아요 상태 전달
              ),
            ),
          );
        },
      ),
    );
  }
}
