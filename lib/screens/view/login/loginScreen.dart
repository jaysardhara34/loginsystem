import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginsystem/screens/controller/homeController.dart';
import 'package:loginsystem/screens/view/homeScreen.dart';
import 'package:loginsystem/screens/view/login/createUser.dart';
import 'package:loginsystem/utils/fireBaseHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  HomeController _controller = Get.put(HomeController());
  TextEditingController _txtemail = TextEditingController();
  TextEditingController _txtpassword = TextEditingController();
  TextEditingController _txtname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              scale: 1,
              'assets/bg.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Here",
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 25, right: 25, top: 15, bottom: 15),
                      child: TextFormField(
                        cursorColor: Colors.white38,
                        style: TextStyle(color: Colors.white70),
                        controller: _txtemail,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightBlueAccent)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlueAccent),
                          ),
                          border: OutlineInputBorder(),
                          label: Text(
                            "E-mail",
                            style: TextStyle(color: Colors.white60),
                          ),
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 25, right: 25, top: 15, bottom: 15),
                      child: TextFormField(
                        cursorColor: Colors.white38,
                        style: TextStyle(color: Colors.white70),
                        controller: _txtpassword,
                        decoration: InputDecoration(
                          fillColor: Colors.lightBlueAccent,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightBlueAccent)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlueAccent),
                          ),
                          border: OutlineInputBorder(),
                          label: Text(
                            "Password",
                            style: TextStyle(color: Colors.white60),
                          ),
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String msg = await Loginep(
                            _txtemail.text, _txtpassword.text, _txtname.text);
                        Get.snackbar('User', '$msg',
                            duration: Duration(seconds: 1));
                        if (msg == "Success") {
                          Get.offAll(HomeScreen());
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: MediaQuery.of(context).size.width * 0.040,
                        ),
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width * 0.30,
                                MediaQuery.of(context).size.height * 0.05),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlueAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(thickness: 0.9, color: Colors.white54),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        iconSize: MediaQuery.of(context).size.height * 0.045,
                        onPressed: () async {
                          bool msg = await googlelogin();

                          if (msg) {
                            Get.snackbar('Google Login', 'Successfully',
                                duration: Duration(seconds: 1));
                            Get.offAll(HomeScreen());
                          }
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/gl.webp'),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have Account ?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(CreateUserScreen());
                          },
                          child: Text('Get One.',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.040,
                                  color: Colors.lightBlueAccent)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
