import 'package:delivery_app/common/const/color.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/service/auth_api.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final AuthService auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkedToken();

  }

  void  _checkedToken() async{
    try{
      final response = await auth.refreshToken();

      if (response){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>RootTab()), (route)=>false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>LoginScreen()), (route)=>false);
      }
    }catch(e){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>LoginScreen()), (route)=>false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Primary_Color,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(height: 16,),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
