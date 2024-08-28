import 'package:flutter/cupertino.dart'; // Flutter의 Cupertion 디자인 위젯을 사용하기 위한 패키지 임포트
import 'package:flutter/foundation.dart'; // Flutter의 기본 기능을 위한 패키지 임포트
import 'package:flutter/material.dart'; //Flutter의 Material디자인 위젯을 사용하기 위한 패키지 임포트
import 'package:h_flutter_example_project/models/NumberItem.dart'; // NumberItem모델을 사용하기 위한 임포트
import 'package:h_flutter_example_project/services/CoffeeService.dart';// CoffeeService를 사용하기 위한 임포트
import 'package:h_flutter_example_project/views/NumberDetailScreen.dart';// NumberDetailScreen을 사용하기 위한 임포트
import '../services/CoffeeService.dart';// Coffeeservice를 다시 임포트 (중복)

class NumberViewModel extends ChangeNotifier { //NumberViewModel 클래스 정의, ChangMotifier상속
  List<NumberItem> _numberItems = []; // NumberItem 객체를 담는 리스트, 초기값은 빈 라스트

  List<NumberItem> get numberItems => _numberItems; //_numberitems 리스틑 반환하는 getter

  NumberItem? _numberItem = NumberItem.empty();//선택된 NumberItem 객체, 초기값은 빈 객체
  NumberItem? get numberItem => _numberItem; // _numberItem을 반환하는 getter

  final NumberService _numberService; // NumberService 인스턴스를 위한 변수 선언

  NumberViewModel(this._numberService) { // 생성자, NumberService 인스턴스를 초기화
    _initializeHive(); // Hive 초기화 메서드 호출
  }

  Future<void> _initializeHive() async { // Hive를 초기화하는 비동기 메서드
    _numberItems = (await _numberService.initializeHive())!; // NumberService의 initializeHive 호출, 결과를 _numberItems에 저장
    notifyListeners(); // 상태 변경을 알리기 위해 리스너에게 통지
  }


  Future<void> detailsNumberItem(BuildContext context, int index) async { // 특정 인덱스의 NumberItem 상세 정보를 보여주는 비동기 메서드
    _numberItem = _numberItems[index];// 선택된 NumberItem을 _numberItem에 저장
    Navigator.push(// 새로운 화면으로 이동

        context,
        MaterialPageRoute( //Material스타일의 페이지 전환
            builder: (context) => NumberDetailScreen(numberItem: _numberItem))); // NumberDetailScreen을 생성

    notifyListeners(); // 상태 변경을 알리기 위해 리스너에게 통지
  }

  void deleteItem(BuildContext context, int index) { // 특정 인텍스의 항모글 삭제하는 메서드
    showDialog( // 대화 상자 표시
        context: context,
        builder: (context) => AlertDialog( // AlertDialog생성
              title: Text("삭제 확인"),//대화 상자의 제목
              content: Text("정말로 이 항목을 삭제하시겠습니까?"),// 대화 상자의 내용
              actions: [ // 대화 상자의 버튼들
                TextButton( // 취소 버튼
                    onPressed: () {
                      Navigator.of(context).pop(); // 대화 상자 닫기
                    },
                    child: Text("취소")), // 버튼의 텍스트
                TextButton( //삭제 버튼
                    onPressed: () async { // 비동기 메서드
                      try {
                        await _numberService.deleteCoffeeItem(index);// CoffeeService에서 항목 삭제

                        _numberItems.removeAt(index);//리스트에서 항목 제거
                        notifyListeners();// 상태 변경을 알리기 위해 리스너에게 통지
                        Navigator.of(context).pop(); // 대화 상자 닫기
                      } catch (e) { //오류 처리
                        print("삭제 중 오류 발생 : $e"); // 오류 메시지 출력
                      }
                    },
                    child: Text("삭제")) // 버튼의 텍스트
              ],
            ));
  }

  void setImage(String? path) { // 이미지 경로를 설정하는 메서드
    if (path != null) { // 경로가 null이 아닐 경우
      _numberItem?.image = path; //_numberitem의 이미지 속성 설정
    } else { // 경로가 null일 경우
      _numberItem?.image = null; // 이미지 속성을 null로 설정
    }

    notifyListeners(); // 상태 변경을 알리기 위해 리스너에게 통지
  }

  void setTitle(String? title) { // 제목을 설정하는 메서드
    _numberItem?.title = title; //_numberItem의 제목 속성 설정
  }

  void setDescription(String? description) { // 설명을 설정하는 메서드
    _numberItem?.description = description; //_numberItem의 설명 속성 설정
  }

  void setPhoneNumber(String? phoneNumber){ // 전화번호를 설정하는 메서드
    _numberItem?.phoneNumber = phoneNumber; //_numberitem의 전화번호 속성 설정
  }

  bool validateForm(GlobalKey<FormState> formKey) { // 폼 유효성을 검사하는 메서드
    return formKey.currentState!.validate(); // 현재 폼 상태의 유효성 검사 결과 반환
  }

  void saveForm(GlobalKey<FormState> formKey, BuildContext context) async { // 폼 데이터를 저장하는 비동기 메서드
    if (validateForm(formKey)) { // 폼 유효성 검사
      formKey.currentState!.save(); // 폼 데이터 저장

      if (_numberItem != null) { //_numberItem이 유효할 경우
        try {
          await _numberService.addCoffeeItem(_numberItem!); // hive에 저장 //CofeeServiced에 _numberItem저장
          _numberItems.add(_numberItem!); //리스트에 _numerItem 추가
          formKey.currentState!.reset(); // 폼 리셋
          _numberItem = NumberItem.empty(); // _numberlitem을 빈 객체로 초기화
          notifyListeners(); // 상태 변경을 알리기 위해 리스너에게 통지
          Navigator.pushNamed(context, "/"); // 홈 화면으로 이동
        } catch (e) { // 오류 처리
          print("hive에 데이터를 저장하는 과정에서 오류 발생 : $e"); // 오류 메시지 출력
        }
      } else { //_numerItem이 유효하지 않을 경우
        print("coffeeItem이 유효하지 않습니다.");// 오류 메시지 출력
      }
    }
  }
}
