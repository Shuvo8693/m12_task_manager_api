import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Screen/login_screen.dart';
import 'package:m12_task_manager_api/main.dart';

import 'NetworkResponse.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {required Map<dynamic, dynamic>? body,bool isLogIn=false}) async {
    log(url);
    log(body.toString());
    try {
      final Response response = await post(Uri.parse(url), body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'token': AuthController.token.toString()
          });
      log(response.headers.toString());
      log(response.statusCode.toString());
      debugPrint(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode==401){ //response condition hisebe use korle return hisebe etar NetRes class use korte hobe
         if(isLogIn==false){backToLogIn();}   //eta toh future async type constructor ty eta ke return kora jabe na ,ty ----
         return NetworkResponse( // ---ty NetworkResponse class ta ke use kora hoace ,ekhane data 401 against e jeta ashbe seta ei class e ---
             isSuccess: false,   // ei class e stored hoy ,& NetworkCaller class ta NetworkResponse class hold kore ty ei class ta return hisebe dete hobe,noyto error dekhabe.
             jsonResponse: jsonDecode(response.body),
             statusCode: response.statusCode);
      }else{
        return NetworkResponse(
      isSuccess: false,
      jsonResponse: jsonDecode(response.body),
      statusCode: response.statusCode);
      }
    } catch (error) {
      return NetworkResponse(isSuccess: false, eRRor: error.toString());
    }
  }


  Future<NetworkResponse> getRequest(String url) async {
    log(url);
    try {
      final Response response = await get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'token': AuthController.token.toString()
          });
      log(response.headers.toString());
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      }else{
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }
    } catch (error) {
      return NetworkResponse(isSuccess: false, eRRor: error.toString());
    }
  }
  Future<void>backToLogIn()async {

    await AuthController.clearCache();
    Navigator.pushAndRemoveUntil(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);

  }
}
