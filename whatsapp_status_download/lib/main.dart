import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_download/screens/home_screen.dart';
import 'package:whatsapp_status_download/services/app_provider.dart';
import 'package:whatsapp_status_download/utils/app_style.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primary));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Save Status',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen()
      ),
    );
  }
}
