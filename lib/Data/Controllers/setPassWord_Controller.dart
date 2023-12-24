import 'dart:developer';

import 'package:get/get.dart';
import '../../Screen/login_screen.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';

class SetPassWordController extends GetxController{
  bool setPasswordInProgress=false;
  Future<bool>setPassword(String email,String pinTEC,String confirmPassword)async{
    setPasswordInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(
          Urls.resetPassword, body: {
        "email": email,
        "OTP": pinTEC,
        "password": confirmPassword
      });
    setPasswordInProgress=false;
    update();
      log(response.isSuccess.toString());
      log(response.jsonResponse!['status']);
      if(response.isSuccess){
        if(response.jsonResponse!['status']=='success'){
          Get.to(()=>const LoginScreen());
          return true;
        }

      }
    return false;
  }
}