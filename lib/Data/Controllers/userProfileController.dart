import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Auth_Controller/auth_controller.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/user_model.dart';

class UserProfileController extends GetxController{

   final TextEditingController  _emailTEController = TextEditingController();
   final TextEditingController  _firstNameTEController = TextEditingController();
   final TextEditingController  _lastNameTEController = TextEditingController();
   final TextEditingController  _phoneNumberTEController = TextEditingController();
   final TextEditingController  _passWordTEController = TextEditingController();
    get emailTEController=>_emailTEController;
    get firstNameTEController=>_firstNameTEController;
    get lastNameTEController=> _lastNameTEController;
    get phoneNumberTEController=>_phoneNumberTEController;
    get passWordTEController=>_passWordTEController;

  AuthController authController=Get.find<AuthController>();
  bool  _profileInProgress=false;
  bool get profileInProgress=>_profileInProgress;
  String? photoInController;

  Future<void> updateProfile() async {

      _profileInProgress=true;
     update();

      Map<String, dynamic> profileData = {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _phoneNumberTEController.text.trim(),
      };

       profileData['photo']=photoInController;

      if(_passWordTEController.text.isNotEmpty){
        profileData['password']= _passWordTEController.text;
      }

      NetworkResponse response = await NetworkCaller()
          .postRequest(Urls.updateProfile, body: profileData);


      if(response.isSuccess){
        await Get.find<AuthController>().updateProfileInfo(UserModel(
            email: _emailTEController.text.trim(),
            firstName: _firstNameTEController.text.trim(),
            lastName: _lastNameTEController.text.trim(),
            mobile: _phoneNumberTEController.text.trim(),
            photo: photoInController ?? authController.user?.photo??''  // ekhane local cache e rakha hocce cuz use picture from modal
        ));
      }

      _profileInProgress=false;
       update();
  }
}