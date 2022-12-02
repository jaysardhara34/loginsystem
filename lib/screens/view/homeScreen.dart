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
  }

  void profile() async {
    _controller.userDataList.value = await userprofile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    logout();
                    Get.offAll(LoginScreen());
                  },
                  icon: Icon(Icons.logout)),
            )
          ],
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
          title: Text('HomeScreen'),
        ),
        body: Center(
          child: Obx(
            () => Column(
              children: [
                Text('${_controller.userDataList}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
