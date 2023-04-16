import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:chewie/chewie.dart';
import '../utils/app_style.dart';
import '../utils/common_toast.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  final String? video;
  const ViewVideo({Key? key, this.video}) : super(key: key);

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {


   ChewieController? _chewieController;

   @override
  void initState() {
    _chewieController = ChewieController(
      autoInitialize: true,
        looping: true,
        aspectRatio: 6/7,
        errorBuilder: ((context, errorMessage){
          return commToast(errorMessage, context);
        }),
        videoPlayerController: VideoPlayerController.file(File(widget.video!),
  
       )) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

     body: Chewie(controller: _chewieController!),
      
      

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: primary,
              heroTag: "Saved Image",
              onPressed: (){
                ImageGallerySaver.saveFile(widget.video!).then((value){
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
                FlutterNativeApi.shareImage(widget.video!);
              },
              child: Icon(Icons.share,color: whiteColor,)),
        ],
      ),
    );
  }
}
