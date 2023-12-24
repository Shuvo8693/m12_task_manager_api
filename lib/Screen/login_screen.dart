import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/logIn_Controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Screen/signup_screen.dart';
import 'package:m12_task_manager_api/Widget/SnackMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/pojo_model_class/user_model.dart';
import '../Widget/background_picture.dart';
import 'mail_varify_screen.dart';
import 'main_bottomNavBar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _passwordTEC=TextEditingController();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();

 final LoginController _loginController= Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBody(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _emailTEC,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty??true){
                          return 'Enter your Mail';
                        }return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _passwordTEC,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if(value?.isEmpty??true){
                         return 'Enter your Password';
                        }return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: GetBuilder<LoginController>(
                          builder: (loginController) {
                            return Visibility(
                              visible: !loginController.logInProgress,
                              replacement: const Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                  onPressed: signIn,
                                  child:
                                      const Icon(Icons.arrow_circle_right_outlined)),
                            );
                          }
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MailVerifyScreen()));
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't Have Account ?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                            }, child: const Text('Sign Up')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
  Future<void>signIn()async{
    if(!_formKey.currentState!.validate()){  /// not validate jodi true hoy then
      return;      ///  ekhane null return korbe ,then next codding e agabena, next coding e block of code else rakhleo expected condition apply hobe.
    }
    final netResponse= await _loginController.getToSignIn(_emailTEC.text.trim(), _passwordTEC.text);
    if(netResponse){
      clearField();
      Get.off(const BottomNavBar());
    }else{
      if(mounted) {
        snackMessage(context,_loginController.failureMessage, true);

      }
    }
  }
  void clearField(){
   _emailTEC.clear();
   _passwordTEC.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }
}
