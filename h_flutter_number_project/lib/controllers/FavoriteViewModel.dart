import 'dart:async';// 비동기 프로그래밍츨 위한 Dart의 asyno 패키지 임포트

import 'package:flutter/cupertino.dart';// Flutter의 Cupertino 디자인 위젯을 사용하기 위한 패키지 임포트
import 'package:h_flutter_example_project/services/FavoriteService.dart';//FavoriteService를 사용하기 위한 임포트

class FavoriteViewModel extends ChangeNotifier{ //FavoriiteViewModel 클래스 정의,ChangeNotifier 상속
  final FavoriteService _favoriteService;// FavoriteService 인스턴스를 위한 변수 선언

  FavoriteViewModel(this._favoriteService); // 생성자,FavoriteService 인스턴스를 초기화

  bool isFavorite(int index) { // 특정 인텍스의 즐겨찾기 여부를 확인하는 메서드
   return _favoriteService.isFavorite(index);//FavoriteService의 isFavorite 메서드 호출
    notifyListeners(); // 싱태 변경을 알리기 위해 리스너에게 통지
  }

  void toggleFavorite(int index){ // 특정 인덱스의 즐겨찾기 상태를 토글하는 메서드
    _favoriteService.toggleFavorite(index);//FavoriteService의 toggleFavorite메서드 호출
    notifyListeners(); // 상태 변경을 알리기 위해 리스너에게 통지
  }

  List<int> getFavoriteIndices(){ // 즐겨찾기 인덱스 목록을 반환하는 메서드
    return _favoriteService.getFavoriteIndices(); //FavoriteService의 getFavoriteIndices메서드 호출
  }
}