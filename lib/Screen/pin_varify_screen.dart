import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/user_model.dart';
import 'package:m12_task_manager_api/Screen/set_password_screen.dart';
import 'package:m12_task_manager_api/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class PinVerifyScreen extends StatefulWidget {
 const  PinVerifyScreen({super.key,required this.email});
  final String email;
  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  final TextEditingController _pinTEController= TextEditingController();
 bool _pinInProgress=false;
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
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'A 6 Digit Verification Pin will Send to Your Email Address',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PinCodeTextField(
                    controller: _pinTEController,
                    animationType: AnimationType.fade,
                    obscureText: false,
                    appContext: (context),
                    length: 6,
                    pinTheme:  PinTheme.defaults(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(6),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                     // activeColor: Colors.black,
                      selectedFillColor: Colors.black12,
                      inactiveFillColor: Colors.white, //box er vitorer color
                    ),
                    animationDuration: const Duration(milliseconds: 500),
                    enableActiveFill: true,
                    backgroundColor: Colors.transparent,  // box er background e default white 1 ta bar show kore ,tai seta ke transparent korahoace.
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Visibility(
                        visible: _pinInProgress==false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              pinVerification();
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text('Sign In')),
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
   Future<void>pinVerification()async{
    _pinInProgress=true;
    if(mounted){
      setState(() {});
    }
     NetworkResponse response=await NetworkCaller().getRequest(Urls.pinVerify(widget.email, _pinTEController.text));
     log(response.isSuccess.toString());
     if(response.isSuccess){
       _pinInProgress=false;
       if(mounted){
         setState(() {});
       }
       Navigator.push(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>SetPasswordScreen()));
     }
   }
}
