import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Controllers/mailVerify_Controller.dart';
import 'package:m12_task_manager_api/Screen/pin_varify_screen.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class MailVerifyScreen extends StatefulWidget {
  const MailVerifyScreen({super.key});

  @override
  State<MailVerifyScreen> createState() => _MailVerifyScreenState();
}

class _MailVerifyScreenState extends State<MailVerifyScreen> {
  final TextEditingController _emailVerifyTEC = TextEditingController();
 final GlobalKey<FormState>_formKey= GlobalKey<FormState>();
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
                      validator: (String? value){
                        if(value?.trim().isEmpty??true){
                          return 'Enter Valid Email';
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
                        child: GetBuilder<MailVerifyController>(
                            builder: (mailVerifyController) {
                          return mailVerifyController.mailverifyInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    mailVerify();
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
        ),
      )),
    );
  }

  Future<void> mailVerify() async {
    if(!_formKey.currentState!.validate()){
      return;
    }
    final response = await Get.find<MailVerifyController>().mailVerify(_emailVerifyTEC.text.trim());
    if (response){
      Get.to(() => PinVerifyScreen(email: _emailVerifyTEC.text.trim())); // i can also put it TEController into GetX to use it another class
    }
  }
}
