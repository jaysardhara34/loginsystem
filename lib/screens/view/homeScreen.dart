import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginsystem/screens/controller/homeController.dart';
import 'package:loginsystem/screens/view/login/loginScreen.dart';
import 'package:loginsystem/utils/fireBaseHelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    profile();
  }

  void profile() async {
    _controller.userDataList.value = await userprofile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          toolbarHeight: 65,
          flexibleSpace: Container(
            child: Image.asset(
              scale: 1,
              'assets/ap.jpg',
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          elevation: 00,
          centerTitle: true,
          title: Text('Homepage'),
        ),
        drawer: Drawer(
          child: Container(height: double.infinity,width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/hbg.jpg'),fit: BoxFit.cover)),
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(backgroundColor: Colors.transparent,
                      radius: MediaQuery.of(context).size.width * 0.13,
                      backgroundImage:
                          NetworkImage('${_controller.userDataList[2]}')),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${_controller.userDataList[1]}',
                    style: TextStyle(color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_controller.userDataList[0]}',
                    style: TextStyle(color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              scale: 1,
              'assets/hbg.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }

  void showDrawer() {}
}
