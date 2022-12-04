import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginsystem/screens/view/homeScreen.dart';
import 'package:loginsystem/screens/view/login/loginScreen.dart';
import 'package:loginsystem/utils/fireBaseHelper.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool msg = false;

  void initState() {
    super.initState();
    msg = checkUser();
  }
  @override
  Widget build(BuildContext context) {
    isLogin();
    return SafeArea(
        child: Scaffold(
          body:Center(
            child:  Container(
              height: 450,
              width: 450,

              child: Lottie.asset('assets/login.json'),
            ),
          ),
        ));
  }
  void isLogin(){
    Timer(Duration(seconds: 3),()=>msg?Get.offAll(HomeScreen()):Get.offAll(LoginScreen()), );
  }

}
