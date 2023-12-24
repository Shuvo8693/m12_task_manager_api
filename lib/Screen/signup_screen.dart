
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:m12_task_manager_api/Data/Controllers/signUp_Controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Widget/SnackMessage.dart';
import 'package:m12_task_manager_api/main.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _phoneNulTEC = TextEditingController();
  final TextEditingController _passWordTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
                      'Join With Us',
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
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter The Email';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                        controller: _firstNameTEC,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter The First name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                        controller: _lastNameTEC,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter Last Name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                        controller: _phoneNulTEC,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter The Phone Number';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _passWordTEC,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Password';
                        }
                        if (value!.length < 6) {
                          return 'the Password must be above 6 character ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 45,
                        child:  GetBuilder<SignUpController>(
                          builder: (signUpController) {
                            return Visibility( /// visible true hola ,replacement widget Show kora, ar visible false thakle child show kore.
                              visible: signUpController.inProgress==false,
                              replacement: const Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                      onPressed: signUp, //<-----
                                      child: const Icon(
                                          Icons.arrow_circle_right_outlined)),
                            );
                          }
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
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                  (route) => false);
                            },
                            child: const Text('Sign in')),
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

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
     final response= await SignUpController().signUp(
         _emailTEC.text.trim(),
         _firstNameTEC.text.trim(),
         _lastNameTEC.text.trim(),
         _phoneNulTEC.text.trim(),
         _passWordTEC.text);
      if (response) {
        _clearField();
        if (mounted) {
          // mounted reason hocce ei toast message onno screen e show korbe na only ei screen porjonto thakbe.
          snackMessage(context, SignUpController().failureMessage);
        }
        Navigator.push(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      }
    }
  }

  void _clearField() {
    _passWordTEC.clear();
    _emailTEC.clear();
    _phoneNulTEC.clear();
    _firstNameTEC.clear();
    _lastNameTEC.clear();
  }

  validatorThis(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Enter The value';
    }
    return null;
  }
}
