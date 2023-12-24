
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pojo_model_class/user_model.dart';

//ei AuthController ta shudu UserModel er jonno create kora hoace, & Token er jonno.
class AuthController extends GetxController{
 static String? token;
  UserModel? user;
  //ValueNotifier<UserModel?> user = ValueNotifier<UserModel?>(UserModel()); // for instant result update

  Future<void>saveUserInfo(String? tok, UserModel model,{bool t=false} )async{   // String & UserModel pojo class e data nea seta SharedPreferences cache hoy
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     await sharedPreferences.setString('token',tok!); //token nam e tok! set hoace, then ei nam e get korte hobe
     await sharedPreferences.setString('user',jsonEncode(model.toJson())); // user nam e model ti set kora hoace, pore ei nam e get korte hobe
     token=tok;
     user=model; // ekhan theke Direct Decode data get korci LogIn Theke, setString theke variable dea data get kora jayna, particular vabe UserModel theke data nea hocce
   update();
  }

  Future<void>updateProfileInfo( UserModel model )async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString('user',jsonEncode(model.toJson()));
    user=model;
    update();
  }
  
 Future<void>userCache()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   token= sharedPreferences.getString('token');
   user = UserModel.fromJson(jsonDecode(sharedPreferences.getString('user')?? '{}')); //ei Cache e User infromation ta Ui te Show kora hocce
    update();
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