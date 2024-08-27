import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  XFile? _image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _saveData() {
    String value1 = _controller1.text;
    String value2 = _controller2.text;

    print('입력된 값 1: $value1');
    print('입력된 값 2: $value2');

    if (_image != null) {
      print('선택된 이미지 경로: ${_image!.path}');
    } else {
      print('이미지가 선택되지 않았습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coffee Cards',
          style: TextStyle(color: Colors.white), // 텍스트 색상을 흰색으로 설정
        ),
        backgroundColor: Colors.blue, // 배경색을 파란색으로 설정
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼을 제거
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Icon(Icons.add_a_photo),
              ),
              SizedBox(height: 16.0),
              if (_image != null)
                Image.file(
                  File(_image!.path),
                  height: 200,
                )
              else
                Text('이미지를 선택하세요'),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controller1,
                decoration: InputDecoration(
                  labelText: '값을 입력하세요',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '값을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controller2,
                decoration: InputDecoration(
                  labelText: '값을 입력하세요',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '값을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveData();
                  }
                },
                child: Text('저장'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
