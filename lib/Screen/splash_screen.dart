import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Screen/main_bottomNavBar_screen.dart';
import '../Widget/background_picture.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> gotoLogin() async {
  final bool isLogin =await AuthController().authCheck();
    Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>isLogin ? const BottomNavBar():const LoginScreen())));
  }

  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBody(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 160,
          ),
        ),
      ),
    );
  }
}
