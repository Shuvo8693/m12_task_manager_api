import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:m12_task_manager_api/Data/Controllers/setPassWord_Controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen(
      {super.key, required this.pinTEC, required this.email});

  final String pinTEC;
  final String email;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _newPasswordTEC = TextEditingController();
  final TextEditingController _confirmPasswordTEC = TextEditingController();
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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Minimum Length of Password 8 characters with letter & number Combination',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _newPasswordTEC,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: ' Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _confirmPasswordTEC,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return ' Confirm Your Password';
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
                        child: GetBuilder<SetPassWordController>(
                            builder: (setPassWordController) {
                          return setPassWordController.setPasswordInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    setPassword();
                                  },
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined));
                        })),
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
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text('Sign In')),
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

  Future<void> setPassword() async {
    if (_formKey.currentState!.validate() &&
        _newPasswordTEC.text == _confirmPasswordTEC.text) {
      final response = await Get.find< SetPassWordController>()
          .setPassword(widget.email, widget.pinTEC, _confirmPasswordTEC.text);
      if (response) {}
    }
  }
}
