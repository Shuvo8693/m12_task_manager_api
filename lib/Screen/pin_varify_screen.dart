import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Screen/set_password_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
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
                    animationDuration: Duration(milliseconds: 500),
                    enableActiveFill: true,
                    backgroundColor: Colors.transparent,  // box er background e default white 1 ta bar show kore ,tai seta ke transparent korahoace.
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SetPasswordScreen()));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
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
}
