import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:getx_sqlite/screen/login_screen.dart';
import 'package:getx_sqlite/screen/main_screen.dart';
Future main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove();
    runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
    );
  }
}
