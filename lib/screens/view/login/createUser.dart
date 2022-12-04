import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginsystem/screens/view/login/loginScreen.dart';
import 'package:loginsystem/utils/fireBaseHelper.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  TextEditingController _txtemail = TextEditingController();
  TextEditingController _txtpassword = TextEditingController();

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
                      "Create",
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: MediaQuery.of(context).size.width * 0.13,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "User",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).size.width * 0.06),
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
                        String msg =
                            await Createac(_txtemail.text, _txtpassword.text);
                        Get.snackbar('User', '${msg}',
                            duration: Duration(seconds: 1));
                        if (msg == "Success") {
                          Get.offAll(LoginScreen());
                        }
                      },
                      child: Text(
                        'Create User',
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
                      height: 80,
                    )
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
