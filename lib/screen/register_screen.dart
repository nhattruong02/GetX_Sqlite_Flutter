import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqlite/controller/controller_register.dart';

class RegisterScreen extends StatelessWidget {
  final ControllerRegister c = Get.put(ControllerRegister());

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
        padding: EdgeInsets.all(10),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          "Success!",
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 1),
      ));
      await Future.delayed(
        Duration(seconds: 1),
        () => Get.back(),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          "Fail!",
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ));
    }
  }

  Future<void> checkTextFiel(BuildContext context) async {
    if (c.fullname.text.length < 10 || c.fullname.text.isNum) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'Fullname > 10 chars',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ));
    } else if ((c.username.text.length < 10) && (!c.username.text.isEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'username > 10 chars or is Email',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ));
    } else if (!c.phone.text.isPhoneNumber) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'is phone number',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ));
    } else if (c.password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'password > 6',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ));
    } else {
      showDialog(
        context: context,
        builder: (context) => Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        )),
      );
      bool username = await c.checkUsername(c.username.text);
      print("main $username");
      if (username) {
        await c.register(c.fullname.text.trim(), c.username.text.trim(),
                c.phone.text.trim(), c.password.text.trim())
            ? check(true, context)
            : check(false, context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
              child: Text(
            'username existed',
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: Colors.white,
        ));
        Navigator.pop(context);
      }
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
                    height: 30,
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
                    child: const Text('REGISTER',
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
                            height: 30,
                          ),
                          textFiel('Full Name', Icons.person, c.fullname),
                          textFiel(
                              'Username/Email', Icons.mail_outline, c.username),
                          textFiel(
                              'Phone Number', Icons.phone_android, c.phone),
                          textFiel(
                              'Password', Icons.vpn_key_outlined, c.password),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 50,
                            width: 170,
                            child: ElevatedButton(
                              onPressed: () => checkTextFiel(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already A Member?'),
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(color: Colors.deepOrange),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => Get.back(),
            backgroundColor: Colors.white,
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
          )),
    );
  }
}
