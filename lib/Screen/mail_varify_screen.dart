import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/user_model.dart';
import 'package:m12_task_manager_api/Screen/pin_varify_screen.dart';
import 'package:m12_task_manager_api/main.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class MailVerifyScreen extends StatefulWidget {
  const MailVerifyScreen({super.key});

  @override
  State<MailVerifyScreen> createState() => _MailVerifyScreenState();
}

class _MailVerifyScreenState extends State<MailVerifyScreen> {
  final TextEditingController _emailVerifyTEC=TextEditingController();
 bool _mailverifyInProgress=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBody(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailVerifyTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Visibility(
                        visible: _mailverifyInProgress==false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              mailVerify();
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" Have Account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                          }, child: const Text('Sign In')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
  Future<void>mailVerify()async{
    _mailverifyInProgress=true;
    if(mounted){
      setState(() {});
    }
      NetworkResponse response = await NetworkCaller().getRequest(Urls.verifyMail(_emailVerifyTEC.text.trim()));
      log(response.isSuccess.toString());
    if(response.isSuccess){
     AuthController().updateProfileInfo(UserModel.fromJson(response.jsonResponse!));
     _mailverifyInProgress=false;
     if(mounted){
       setState(() {});
     }
       Navigator.push(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=> PinVerifyScreen(email: _emailVerifyTEC.text,)));
    }
  }
}
