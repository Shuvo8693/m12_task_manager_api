
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../pojo_model_class/user_model.dart';

class AuthController{
 static String? token;
 static UserModel? user;
  
 static Future<void>saveUserInfo(String? tok, UserModel model,{bool t=false} )async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     await sharedPreferences.setString('token',tok!);
     await sharedPreferences.setString('user',jsonEncode(model.toJson()));
    token=tok;
    user=model;
  }
  
static Future<void>userCache()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   token= sharedPreferences.getString('token');
   user = UserModel.fromJson(jsonDecode(sharedPreferences.getString('user')?? '{}'));
 }
 
static Future<bool>authCheck()async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String? token=sharedPreferences.getString('token');
   if(token != null){
     userCache();
     return true;

   }return false;
 }

 static Future<void>clearCache()async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences.remove('token');
  token=null;
 }
}