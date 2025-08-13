import 'dart:convert';

import 'package:delivery_app/common/const/color.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/service/auth_api.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_text_form_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService api = AuthService();

  late TextEditingController username_controller;
  late TextEditingController password_controller;

  String username = '';
  String password = '';

  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username_controller = TextEditingController();
    password_controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username_controller.dispose();
    password_controller.dispose();
  }

  void _LoginHandler() async{
    username = username_controller.text.trim();
    password = password_controller.text.trim();
    setState(() {
      isLoading = true;
    });
    final a = await api.Login(username, password);
    if(a){
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_)=>RootTab()),
          (route)=>false
      );
    }else{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(
                  height: 16,
                ),
                _Subtitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  scale: 1.3,
                ),
                CustomTextFormField(
                  autofocus: false,
                  hinText: '이메일을 입력해주세요.',
                  controller: username_controller,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  autofocus: false,
                  hinText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  controller: password_controller,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : _LoginHandler,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Primary_Color,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Primary_Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                    ),

                  ),
                  child: isLoading ? SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 3,)) : Text('로그인'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () async {

                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: Colors.black
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        color: Body_Text_Color,
        fontSize: 14
      ),
    );
  }
}
