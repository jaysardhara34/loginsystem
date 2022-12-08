import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:loginsystem/screens/controller/homeController.dart';
import 'package:loginsystem/screens/modal/homeModal.dart';
import 'package:loginsystem/screens/view/login/loginScreen.dart';
import 'package:loginsystem/utils/fireBaseHelper.dart';
import 'package:loginsystem/utils/notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FlutterLocalNotificationsPlugin? flnp;

  HomeController _controller = Get.put(HomeController());
  TextEditingController _txtid = TextEditingController();
  TextEditingController _txtname = TextEditingController();
  TextEditingController _txtmobile = TextEditingController();
  TextEditingController _txtstd = TextEditingController();

  TextEditingController _utxtid = TextEditingController();
  TextEditingController _utxtname = TextEditingController();
  TextEditingController _utxtmobile = TextEditingController();
  TextEditingController _utxtstd = TextEditingController();


  List<Model> alldata = [];

  @override
  void initState() {
    super.initState();
    profile();
    initnotification();
    // fireNotification();
  }

  void profile() async {
    _controller.userDataList.value = await userprofile();
  }


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                  Get.offAll(LoginScreen());
                },
                icon: Icon(Icons.logout))
          ],
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
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/hbg.jpg'), fit: BoxFit.cover)),
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: _controller.userDataList[2] == null
                        ? CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                _controller.userDataList[2] as String),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: _controller.userDataList[1] == null
                        ? Text(
                            'User',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                            ),
                          )
                        : Text(
                            '${_controller.userDataList[1]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_controller.userDataList[0]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(thickness: 0.5, color: Colors.white54),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          onPressed: () async{
                            AndroidNotificationDetails androidn =
                            AndroidNotificationDetails(
                              "1",
                              "android",
                              priority: Priority.high,
                              importance: Importance.max,
                              sound: RawResourceAndroidNotificationSound('banana'),
                              playSound: true,
                            );

                            NotificationDetails nd = NotificationDetails(android: androidn);

                            await flnp!.show(1, "Tada", "Yoaimo Banana", nd);
                          },
                          child: Text(
                            'Show Notification',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
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
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      TextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: _txtid,
                        cursorColor: Color(0xff919191),
                        style: TextStyle(color: Color(0xff919191)),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.format_list_numbered_rounded,
                            color: Color(0xff919191),
                          ),
                          hintStyle: TextStyle(color: Color(0xff919191)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter Student Id',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: _txtname,
                        cursorColor: Color(0xff919191),
                        style: TextStyle(color: Color(0xff919191)),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            color: Color(0xff919191),
                          ),
                          hintStyle: TextStyle(color: Color(0xff919191)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter Student Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: _txtmobile,
                        cursorColor: Color(0xff919191),
                        style: TextStyle(color: Color(0xff919191)),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Color(0xff919191),
                          ),
                          hintStyle: TextStyle(color: Color(0xff919191)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter Student Mobile',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: _txtstd,
                        cursorColor: Color(0xff919191),
                        style: TextStyle(color: Color(0xff919191)),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.translate,
                            color: Color(0xff919191),
                          ),
                          hintStyle: TextStyle(color: Color(0xff919191)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter Student Std',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff919191)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    insertdata(_txtid.text, _txtname.text, _txtmobile.text,
                        _txtstd.text);
                    _txtstd.clear();
                    _txtmobile.clear();
                    _txtname.clear();
                    _txtid.clear();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.027,
                          color: Color(0xffd0d0d0),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add Student',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Color(0xffd0d0d0),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: readdata(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        var docList = snapshot.data!.docs;
                        alldata.clear();
                        for (QueryDocumentSnapshot x in docList) {
                          var finaldata = x.data() as Map<String, dynamic>;
                          Model m1 = Model(
                            id: finaldata['id'],
                            name: finaldata['name'],
                            mobile: finaldata['mobile'],
                            std: finaldata['std'],
                            unniqueid: x.id,
                          );
                          alldata.add(m1);
                        }

                        return ListView.builder(
                          itemCount: alldata.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(
                                "${alldata[index].id}",
                                style: TextStyle(color: Color(0xffb6b6b6)),
                              ),
                              title: Text(
                                "${alldata[index].name}",
                                style: TextStyle(color: Color(0xffb6b6b6)),
                              ),
                              subtitle: Text(
                                "${alldata[index].unniqueid}",
                                style: TextStyle(color: Color(0xffb6b6b6)),
                              ),
                              trailing: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _utxtid = TextEditingController(
                                              text: "${alldata[index].id}");
                                          _utxtname = TextEditingController(
                                              text: "${alldata[index].name}");
                                          _utxtmobile = TextEditingController(
                                              text:
                                              "${alldata[index].mobile}");
                                          _utxtstd = TextEditingController(
                                              text: "${alldata[index].std}");
                                          Get. 
                                          defaultDialog(
                                            title: "Update Data",
                                            titleStyle: TextStyle(
                                                color: Colors.black),
                                            backgroundColor: Colors.white,
                                            content: Column(
                                              children: [
                                                TextField(
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.number,
                                                  controller: _utxtid,
                                                  cursorColor: Color(0xff919191),
                                                  style: TextStyle(color: Color(0xff919191)),
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.format_list_numbered_rounded,
                                                      color: Color(0xff919191),
                                                    ),
                                                    hintStyle: TextStyle(color: Color(0xff919191)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    hintText: 'Update Student Id',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  textInputAction: TextInputAction.next,
                                                  controller: _utxtname,
                                                  cursorColor: Color(0xff919191),
                                                  style: TextStyle(color: Color(0xff919191)),
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.person,
                                                      color: Color(0xff919191),
                                                    ),
                                                    hintStyle: TextStyle(color: Color(0xff919191)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    hintText: 'Update Student Name',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.numberWithOptions(),
                                                  controller: _utxtmobile,
                                                  cursorColor: Color(0xff919191),
                                                  style: TextStyle(color: Color(0xff919191)),
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.phone,
                                                      color: Color(0xff919191),
                                                    ),
                                                    hintStyle: TextStyle(color: Color(0xff919191)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    hintText: 'Update Student Mobile',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.number,
                                                  controller: _utxtstd,
                                                  cursorColor: Color(0xff919191),
                                                  style: TextStyle(color: Color(0xff919191)),
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.translate,
                                                      color: Color(0xff919191),
                                                    ),
                                                    hintStyle: TextStyle(color: Color(0xff919191)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    hintText: 'Update Student Std',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Color(0xff919191)),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    updateData(
                                                        "${alldata[index].unniqueid}",
                                                        _utxtid.text,
                                                        _utxtname.text,
                                                        _utxtmobile.text,
                                                        _utxtstd.text);
                                                    Get.back();
                                                  },
                                                  child: Text("Update"),
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                      backgroundColor:
                                                      Colors.blue
                                                          .shade900),
                                                ),
                                              ],
                                            ),
                                          );},
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color(0xffb6b6b6),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            deleteData(
                                                "${alldata[index].unniqueid}");
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Color(0xffb24343),
                                          )),
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void initnotification() async {
    flnp = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidSetting =
    AndroidInitializationSettings("mugiwara");
    DarwinInitializationSettings iosSetting = DarwinInitializationSettings();

    InitializationSettings flutterSetting =
    InitializationSettings(android: androidSetting, iOS: iosSetting);

    tz.initializeTimeZones();

     flnp!.initialize(flutterSetting);
  }
}
