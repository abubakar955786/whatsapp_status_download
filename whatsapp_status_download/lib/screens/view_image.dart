import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp_status_download/utils/app_style.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:whatsapp_status_download/utils/common_toast.dart';

class ViewImage extends StatefulWidget {
  final String? image;
  const ViewImage({Key? key, this.image}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: FileImage(File(widget.image!))
          )
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: primary,
            heroTag: "Saved Image",
              onPressed: (){
              ImageGallerySaver.saveFile(widget.image!).then((value){
                commToast("Saved Successfully", context);
              }).onError((error, stackTrace){
                commToast("Error", context);
              });
              },
            child: Icon(Icons.file_download_outlined,color: whiteColor,)),


          const SizedBox(height: 10,),

          FloatingActionButton(
              backgroundColor: primary,
              heroTag: "Share Image",
              onPressed: (){
                FlutterNativeApi.shareImage(widget.image!);
              },
              child: Icon(Icons.share,color: whiteColor,)),
        ],
      ),
    );
  }
}
