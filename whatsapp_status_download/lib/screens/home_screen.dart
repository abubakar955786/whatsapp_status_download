import 'package:flutter/material.dart';
import 'package:whatsapp_status_download/screens/videos_screen.dart';
import 'package:whatsapp_status_download/utils/app_style.dart';
import 'image_screen.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _permission() async{
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if(result[Permission.storage] == PermissionStatus.granted && result[Permission.manageExternalStorage] == PermissionStatus.granted){

    }
  }


  @override
  void initState() {
    _permission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text("Save Status", style: Style.headline2,),
            backgroundColor: primary,
            bottom: TabBar(
                labelColor: secondary,
                indicatorColor: secondary,
                unselectedLabelColor: whiteColor,
                labelStyle: Style.headline1,
                indicatorWeight: 3,
                labelPadding: const EdgeInsets.all(15),
                tabs:const [
                  Text("Images"),
                  Text("Videos")
                ]),
          ),

          body: TabBarView(
              children: [
                ImageScreen(),
                VideosScreen(),
              ]),
        ));
  }
}
