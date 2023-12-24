import 'dart:developer';

import 'package:get/get.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';

class MailVerifyController extends GetxController{
  bool _mailverifyInProgress=false;
  bool get mailverifyInProgress=>_mailverifyInProgress;

  Future<bool>mailVerify(String mailVerify)async{
    _mailverifyInProgress=true;
    update();

    NetworkResponse response = await NetworkCaller().getRequest(Urls.verifyMail(mailVerify));
    _mailverifyInProgress=false;
    update();
    log(response.jsonResponse!['status'].toString());

    if(response.isSuccess){
      if(response.jsonResponse!['status']=='success'){
        return true;
      }

    }
    return false;
  }
}