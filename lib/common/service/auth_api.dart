import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService{
  final String _baseUrl = 'https://gitea.yumkar.online';

  final ACCESSTOKEN_KEY = 'access-token';
  final REFRESHTOKEN_KEY = 'refresh-token';

  Future<void> saveAccessToken(String access) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('access-token', access);
  }

  Future<void> saveRefreshToken(String refresh) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('refresh-token', refresh);
  }

  Future<String?> getToken(String type) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == 'access'){
      final accessToken = prefs.getString('access-token');
      return accessToken;
    }else{
      final refreshToken = prefs.getString('refresh-token');
      return refreshToken;
    }
  }

  Future<void> deleteToken() async{
    final pref = await SharedPreferences.getInstance();
    await pref.remove('access-token');
    await pref.remove('refresh-token');
  }
  
  Future<bool> Login(String username, password) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    final Rawstring = '$username:$password';
    Codec<String,String> toBase64 = utf8.fuse(base64);
    String token = toBase64.encode(Rawstring);
    try{
      final response = await http.post(
          url,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : 'Basic $token'
          },
      );
      print(response.statusCode);
      if(response.statusCode == 201){
        final jsonData = jsonDecode(response.body);
        final accessToken = jsonData['accessToken'];
        final refreshToken = jsonData['refreshToken'];
        await saveAccessToken(accessToken);
        await saveRefreshToken(refreshToken);
        return true;
      }else{
        return false;
      }
    }catch(e){
      print('error : ${e}');
      return false;
    }

  }

  Future<bool> refreshToken() async {
    final url = Uri.parse('$_baseUrl/auth/token');
    final refreshToken = await getToken('refresh');
    try{
      final response = await http.post(
          url,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : 'Bearer $refreshToken'
          }
      );
      if (response.statusCode ==201){
        final data = jsonDecode(response.body);
        final accessToken = data['accessToken'];
        await saveAccessToken(accessToken);
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<List> paginateRestaurant() async{
    final url = Uri.parse('$_baseUrl/restaurant');
    final accessToken = await getToken('access');

    try{
      final response = await http.get(
          url,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : 'Bearer $accessToken'
          }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return data['data'];
      }else{
        return [response.statusCode];
      }
    }catch(e){
      'error : $e';
      return [e];
    }
  }

}