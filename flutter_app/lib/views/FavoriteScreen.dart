import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteCoffees = [    {      'title': 'Black Coffee',      'description': 'A strong, bold coffee with a deep flavor.',      'imagePath': 'assets/images/black_coffee.jpg',    },    {      'title': 'Latte',      'description': 'A smooth blend of espresso and steamed milk.',      'imagePath': 'assets/images/latte.jpg',    },    // 좋아요 목록에 추가된 커피만 포함  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Favorite Coffees'),
    ),
    body: favoriteCoffees.isEmpty
        ? Center(child: Text('좋아하는 커피가 없습니다.'))
        : ListView.builder(
      itemCount: favoriteCoffees.length,
      itemBuilder: (context, index) {
        final item = favoriteCoffees[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            leading: Image.asset(
              item['imagePath'] ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item['title'] ?? 'Unknown'),
            subtitle: Text(item['description'] ?? 'No description'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.coffee), // 좋아요 아이콘
                  onPressed: () {
                    // 좋아요 버튼 기능 추가
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove_shopping_cart), // 삭제 아이콘
                  onPressed: () {
                    // 삭제 버튼 기능 추가
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
}
