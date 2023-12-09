
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pojo_model_class/user_model.dart';

class AuthController{
 static String? token;
 //static UserModel? user;
 static ValueNotifier<UserModel?> user = ValueNotifier<UserModel?>(UserModel()); // for instant result update

  Future<void>saveUserInfo(String? tok, UserModel model,{bool t=false} )async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     await sharedPreferences.setString('token',tok!);
     await sharedPreferences.setString('user',jsonEncode(model.toJson()));
    token=tok;
    user.value=model;

  } Future<void>updateProfileInfo( UserModel model )async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString('user',jsonEncode(model.toJson()));
    user.value=model;
  }
  
 Future<void>userCache()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   token= sharedPreferences.getString('token');
   user.value = UserModel.fromJson(jsonDecode(sharedPreferences.getString('user')?? '{}'));
 }
 
 Future<bool>authCheck()async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String? token=sharedPreferences.getString('token');
   if(token != null){
     userCache();
     return true;

   }return false;
 }

 static Future<void>clearCache()async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences.clear();
  token=null;
 }

}