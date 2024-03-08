import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqlite/controller/controller_login.dart';
import 'package:getx_sqlite/screen/main_screen.dart';
import 'package:getx_sqlite/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  ControllerLogin controller = Get.put(ControllerLogin());
  Widget textFiel(String text, IconData icon, TextEditingController controller) {
    if (text == "Password") {
      return Container(
        padding: EdgeInsets.all(10),
        child: TextField(
          obscureText: true,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: text,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: text,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
          ),
        ),
      );
    }
  }

  Future check(bool result, BuildContext context) async {
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Center(child: Text("Success!",style: TextStyle(color: Colors.black),)),
            backgroundColor: Colors.white,duration: Duration(seconds: 1),));
      await Future.delayed(Duration(seconds: 1) ,() => Get.to(const MainScreen(),));
      Navigator.pop(context);
    } else {
      await ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Center(child: Text("Fail!",style: TextStyle(color: Colors.black),)),
            backgroundColor: Colors.white,duration: Duration(seconds: 1),));
      Navigator.pop(context);
    }
  }

  Future<void> checkTextFiel (BuildContext context) async {
    if ((controller.username.text.length < 10) && (!controller.username.text.isEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
              'username > 10 chars or is Email',
              style: TextStyle(color: Colors.black),
            )),
        backgroundColor: Colors.white,
      ));
    } else if ( controller.password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
              'password > 6 chars',
              style: TextStyle(color: Colors.black),
            )),
        backgroundColor: Colors.white,
      ));
    
    }else{
     showDialog(context: context, builder: (context) => Center(
         child: CircularProgressIndicator(
           valueColor: AlwaysStoppedAnimation(Colors.blue),)
     ),);
      await controller.getUser(
          controller.username.text.toString().trim(),
          controller.password.text.toString().trim())
          ? check(true, context)
          : check(false, context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background_login.jpg'),
                        fit: BoxFit.cover)),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      child: const Icon(
                        Icons.account_circle,
                        size: 100,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: const Text('WELCOME!!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white)),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          textFiel('Username/Email', Icons.mail_outline,
                              controller.username),
                          textFiel('Password', Icons.vpn_key_outlined,
                              controller.password),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            height: 50,
                            width: 170,
                            child: ElevatedButton(
                                onPressed: () => checkTextFiel(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)))),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have a Account?'),
                              GestureDetector(
                                onTap: () => Get.to(RegisterScreen()),
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => Get.to(RegisterScreen()),
            backgroundColor: Colors.white,
            child: const Icon(Icons.arrow_forward_ios_outlined,
                color: Colors.orange),
          )),
    );
  }
}
