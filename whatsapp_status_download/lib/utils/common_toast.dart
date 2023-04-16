import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_status_download/utils/app_style.dart';


commToast(String message, BuildContext context){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: secondary,
    backgroundColor: CupertinoColors.black,
    fontSize: 16,
  );
}