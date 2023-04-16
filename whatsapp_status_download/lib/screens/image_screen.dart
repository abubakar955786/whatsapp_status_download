import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_download/screens/view_image.dart';
import 'package:whatsapp_status_download/services/app_provider.dart';
import 'package:whatsapp_status_download/utils/common_toast.dart';

import '../utils/app_style.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {


  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, file, child) {


          if(isFetched == false){
            file.getStatus(".jpg");
            Future.delayed(const Duration(microseconds: 1),(){
              isFetched == true;
            });
          }


          return file.isWhatsappAvailable == false?
               Center( child: Text("No Whatsapp available", style: Style.headline2,),):

              file.getImage.isEmpty?
              Center( child: Text("No Image Found", style: Style.headline2),):

          Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GridView.builder(
            itemCount: file.getImage.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.6,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index){
              return Card(
                elevation: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewImage(image : file.getImage[index].path,)));},
                      child: Container(
                        height: MediaQuery.of(context).size.width*0.6,
                        width: MediaQuery.of(context).size.width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                              image: FileImage(File(file.getImage[index].path)))
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){FlutterNativeApi.shareImage(file.getImage[index].path); },
                            icon: const Icon(Icons.share)),
                        IconButton(onPressed: (){ImageGallerySaver.saveFile(file.getImage[index].path).then((value){
                          commToast("Saved Successfully", context);
                        });},
                            icon: const Icon(Icons.file_download_outlined)),
                      ],
                    )
                  ],
                ),
              );
              }),
          );
        }
      ),
    );
  }
}
