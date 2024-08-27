import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/CoffeeItem.dart';

class CoffeeWidget extends StatefulWidget {
  final CoffeeItem coffeeItem;
  final int index;
  final VoidCallback onDelete; // 삭제 콜백 추가
  final VoidCallback onLike; // 좋아요 콜백 추가

  CoffeeWidget({
    required this.coffeeItem,
    required this.index,
    required this.onDelete,
    required this.onLike, // 좋아요 콜백 받기
    super.key,
  });

  @override
  _CoffeeWidgetState createState() => _CoffeeWidgetState();
}

class _CoffeeWidgetState extends State<CoffeeWidget> {

  bool isLiked = false; // 좋아요 상태 변수 추가

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: ElevatedButton(
        onPressed: () => print("네비게이션"),
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text("${widget.index}"),
              ),
              SizedBox(
                child: Image(
                  width: 80,
                  height: 100,
                  fit: BoxFit.fill,
                  image: AssetImage(widget.coffeeItem.url ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("제목 : ${widget.coffeeItem.title}"),
                    Text(
                      "내용 : ${widget.coffeeItem.description}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked; // 좋아요 상태 변경
                    });
                    widget.onLike(); // 좋아요 콜백 호출
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border, // 좋아요 상태에 따른 아이콘 변경
                    color: isLiked ? Colors.red : Colors.grey, // 좋아요 상태에 따른 색상 변경
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: widget.onDelete, // 삭제 버튼 클릭 시 onDelete 콜백 호출
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
