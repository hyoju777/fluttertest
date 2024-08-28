import 'package:flutter/material.dart'; //Flutter의 기본UI 구성 요소를 사용하기 위한 패키지
import 'package:flutter/services.dart';// 시스템 관련 기능을 사용하기 위한 패키지
import 'package:h_flutter_example_project/controllers/NumberViewModel.dart';// Number관련 뷰 모델
import 'package:h_flutter_example_project/controllers/FavoriteViewModel.dart';// 즐겨 착기 관련 뷰 모델
import 'package:h_flutter_example_project/models/NumberItem.dart';// Numberitem 모델 클래스
import 'package:h_flutter_example_project/models/FavoriteItem.dart';// FavoriteItem 모델 클래스
import 'package:h_flutter_example_project/services/CoffeeService.dart';// coffee관련 서비스
import 'package:h_flutter_example_project/services/FavoriteService.dart';// 즐겨찾기 관련 서비스
import 'package:h_flutter_example_project/themes/NumberTheme.dart';// 테마 설정 파일
import 'package:h_flutter_example_project/widgets/Layout.dart';//레이아옷 위젯
import 'package:hive/hive.dart';// Hive 데이터베이스 패키지
import 'package:path_provider/path_provider.dart';// 앱의 문서 디렉토리 경로를 취득하기 위한 패키지
import 'package:provider/provider.dart';// 상태 관리를 위한 Provider패키지

/*
* 임포트 lib 목록
* $flutter pub add hive           : 경량 nosql
* $flutter pub add http           : api 요청
* $flutter pub add provider       : 상태 관리
* $flutter pub add path_provider  : 어플리케이션의 경로를 취득하기 위함.
* $flutter pub add camera         : 카메라 모듈
* $flutter pub add build_runner   : 클래스의 반복적인 부분을 하나의 코드로 변환함
* $flutter pub add hive_generator : hive에 model을 저장할 때 직렬화를 위해서 사용됨
* */
void main() async{ // 메인 함수 시작, 비동기 함수
  WidgetsFlutterBinding.ensureInitialized(); //Flutter엔진 초기화
  final directory = await getApplicationDocumentsDirectory();// 애플리케이션 문서 디렉토리 경로 가져오기
  Hive.init(directory.path);//Hive 초기화

  Hive.registerAdapter(NumberItemAdapter());//NumberItem 어댑터 등록
  Hive.registerAdapter(FavoriteItemAdapter());//FavoriteItem 어댑터 등록
  
  // box 열기
  await Hive.openBox<FavoriteItem>("favoriteBox"); // FavoriteItem을 저장할 box열기

  runApp(MultiProvider( // 다중 Providr로 상태 관리 시작
      providers: [
        ChangeNotifierProvider( //ChangeNotifierProvider 생성
            create: (context) => NumberViewModel(NumberService())// NumberViewModel 인스턴스 생성
        ),
        ChangeNotifierProvider( //ChangeNotifierProvider 생성
            create: (context) => FavoriteViewModel(FavoriteService())// FavoriteViewModel 인스턴스 생성
        ),
      ],
    child: const MainApp(),// MainApp위젯을 자식으로 설정
  ));
}

class MainApp extends StatelessWidget{ //MainApp클래스 정의 StateLessWidget상속

  const MainApp({super.key});// 생성자

  @override
  Widget build(BuildContext context) { // UI 구성 메서드
    // 화면의 가장 자리까지 공간을 차지하겠다
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // 전체 화면 모드 설정

    return MaterialApp( //MateriaApp위젯 반환
      debugShowCheckedModeBanner: false, // 오른쪽 상단의 띠를 제거함.// 디버그 배너 숨기기
      title: "my number",// 앱제목
      theme: Numbertheme.lightTheme,// 밝은 테마 설정
      darkTheme: Numbertheme.darkTheme,// 어두운 테마 설정
      initialRoute: "/",// 초기 경로 설정
      routes: { //경로 설정
        "/" : (context) =>  Layout()// "/" 경로에 layout위젯 설정
      },
    );
  }
}