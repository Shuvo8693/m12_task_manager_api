import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Screen/pin_varify_screen.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class MailVerifyScreen extends StatefulWidget {
  const MailVerifyScreen({super.key});

  @override
  State<MailVerifyScreen> createState() => _MailVerifyScreenState();
}

class _MailVerifyScreenState extends State<MailVerifyScreen> {
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
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PinVerifyScreen()));
                          },
                          child:
                              const Icon(Icons.arrow_circle_right_outlined))),
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
}
