import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginsystem/screens/view/homeScreen.dart';
import 'package:loginsystem/screens/view/login/createUser.dart';
import 'package:loginsystem/utils/fireBaseHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _txtemail = TextEditingController();
  TextEditingController _txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        primary: false,
        toolbarHeight: 65,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.shade900),
        ),
        elevation: 00,
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "to",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              Text(
                "account",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                child: TextFormField(
                  controller: _txtemail,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade900),
                    ),
                    border: OutlineInputBorder(),
                    label: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    suffixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                child: TextFormField(
                  controller: _txtpassword,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade900),
                    ),
                    border: OutlineInputBorder(),
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () async{
                  String msg = await Loginep(_txtemail.text, _txtpassword.text);
                  Get.snackbar('User','$msg',duration: Duration(seconds: 1));
                  if(msg == "Success")
                  {
                    Get.offAll(HomeScreen());
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.040,
                  ),
                ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),

                          )
                      )
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(thickness: 1.5),
              IconButton(
                  iconSize: MediaQuery.of(context).size.height * 0.045,
                  onPressed: () async{
                   bool msg  = await googlelogin();

                   if(msg){
                     Get.snackbar('Google Login','Successfully',duration: Duration(seconds: 1));
                     Get.offAll(HomeScreen());
                   }

                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/gl.webp'),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have Account ?"),
                  TextButton(
                    onPressed: () {
                      Get.to(CreateUserScreen());
                    },
                    child: Text('Get One.',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.040,
                            color: Colors.blue.shade900)),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
