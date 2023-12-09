import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
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
 bool loginProgress=false;

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
                        child: Visibility(
                          visible: !loginProgress,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                              onPressed: signIn,
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined)),
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
    loginProgress=true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse netResponse= await NetworkCaller().postRequest(Urls.logIn, body: {
      "email":_emailTEC.text.trim(),
      "password":_passwordTEC.text},
      isLogIn: true,
    );
    loginProgress=false;
    if(mounted){
      setState(() {});
    }
    if(netResponse.isSuccess){
      clearField();
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     await AuthController().saveUserInfo(netResponse.jsonResponse!['token'],  // await dear reason: ekhane api respone complete na hoa porjonto next code e jabe na. eta na dele screen eduke loading hota thake or back kore login e chole ashe
             UserModel.fromJson(netResponse.jsonResponse!['data']));
      if(mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
      }
    }else{
      if(mounted) {
        if (netResponse.statusCode == 401) {
          snackMessage(context, 'Enter Valid Email Or Password', true);
        }else{
          snackMessage(context, 'Unknown error');
        }
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
    _emailTEC.clear();
    _passwordTEC.clear();
  }
}
