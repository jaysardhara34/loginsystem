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
        title: Text('Sign up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Create",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: MediaQuery.of(context).size.width * 0.13,

                    fontWeight: FontWeight.bold),
              ),
              Text(
                "User",
                style: TextStyle(color: Colors.blue, fontSize: MediaQuery.of(context).size.width * 0.06),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                child: TextField(
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
                child: TextField(
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
              SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () async{
                  String msg = await Createac(_txtemail.text, _txtpassword.text);
                  Get.snackbar('User','${msg}',duration: Duration(seconds: 1));
                  if(msg == "Success")
                  {
                    Get.offAll(LoginScreen());
                  }

                },
                child: Text(
                  'Create User',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.040,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.30,
                      MediaQuery.of(context).size.height * 0.05),
                  backgroundColor: Colors.blue.shade900,
                ),
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
