import 'package:get/get.dart';

import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';

class SignUpController extends GetxController{
  bool _inProgress = false;
  String _failureMessage='';
  bool get inProgress=>_inProgress;
  String get failureMessage=>_failureMessage;
  Future<bool> signUp(String email,String firstName,String lastName,String mobile,String password) async {
      bool isSuccess=false;
    _inProgress = true;
     update();
      NetworkResponse response =
      await NetworkCaller().postRequest(Urls.registration, body: {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "password": password,
        "photo": ""
      });
      _inProgress = false;
      update();
      if (response.isSuccess) {
        // mounted reason hocce ei toast message onno screen e show korbe na only ei screen porjonto thakbe.
          _failureMessage= 'Your Account Has been Created, Please Sign in';
          return isSuccess=true;
      } else {
          _failureMessage= 'Your Account Creation Has been Failed, please Try again !'; true;

      }
      return false;
  }
}