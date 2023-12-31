import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Widget/SnackMessage.dart';
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
  bool _inProgress = false;

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
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 45,
                        child:  Visibility( /// visible true hola ,replacement widget Show kora, ar visible false thakle child show kore.
                          visible: _inProgress==false,
                          replacement: Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                                  onPressed: signUp, //<-----
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined)),
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
                                      builder: (context) => LoginScreen()),
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
      _inProgress = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "email": _emailTEC.text.trim(),
        "firstName": _firstNameTEC.text.trim(),
        "lastName": _lastNameTEC.text.trim(),
        "mobile": _phoneNulTEC.text.trim(),
        "password": _passWordTEC.text,
        "photo": ""
      });
      _inProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _clearField();
        if (mounted) {
          // mounted reason hocce ei toast message onno screen e show korbe na only ei screen porjonto thakbe.
          snackMessage(
              context, 'Your Account Has been Created, Please Sign in');
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      } else {
        if (mounted) {
          snackMessage(
              context,
              'Your Account Creation Has been Failed, please Try again !',
              true);
        }
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
