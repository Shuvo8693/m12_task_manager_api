
import 'package:get/get.dart';
import '../Auth_Controller/auth_controller.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/user_model.dart';

class LoginController extends GetxController {
  bool _loginProgress = false;
  String _failureMessage = '';
  bool get logInProgress => _loginProgress;
  String get failureMessage => _failureMessage;

  Future<bool> getToSignIn(String email, String password) async {
    bool isSuccess = false;
    _loginProgress = true;
    update();
    NetworkResponse netResponse = await NetworkCaller().postRequest(Urls.logIn, body: {
      "email": email,
      "password": password},
      isLogIn: true,
    );
    _loginProgress = false;
    update();

    if (netResponse.isSuccess) {
      await Get.find<AuthController>().saveUserInfo(netResponse.jsonResponse?['token'], // await dear reason: ekhane api respone complete na hoa porjonto next code e jabe na. eta na dele screen eduke loading hota thake or back kore login e chole ashe
          UserModel.fromJson(netResponse.jsonResponse!['data']));
      return isSuccess = true;
    } else {
      if (netResponse.statusCode == 401) {
        _failureMessage = 'Enter Valid Email Or Password';
        true;
      } else {
        _failureMessage = 'Unknown error';
      }
    }
     return false;
  }
}
