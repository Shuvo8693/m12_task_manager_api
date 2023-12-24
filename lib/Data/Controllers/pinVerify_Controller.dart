import 'dart:developer';

import 'package:get/get.dart';

import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';

class PinVerifyController extends GetxController{
  bool _pinInProgress=false;
  bool get pinInProgress=>_pinInProgress;
  Future<bool>pinVerification(String email,String pinTEC)async{
    _pinInProgress=true;
   update();
    NetworkResponse response=await NetworkCaller().getRequest(Urls.pinVerify(email, pinTEC));
    log(response.isSuccess.toString());
    log(response.jsonResponse!['status']);
    _pinInProgress=false;
    update();
    if(response.isSuccess){
      if(response.jsonResponse!['status']=='success'){
        return true;
      }

    }
    return false;
  }
}