class CoffeeItem {
  String? title;
  String? description;
  String? url;
  bool isLiked; // 좋아요 상태 추가

  CoffeeItem({
    required this.title,
    required this.description,
    required this.url,
    this.isLiked = false, // 기본값은 false
  });
}
