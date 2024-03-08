import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../database/db.dart';
import '../model/user.dart';

class ControllerRegister extends GetxController {
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    fullname.dispose();
    username.dispose();
    phone.dispose();
    password.dispose();
    // SQLHelper().close();
  }

  Future<bool> register(String fullname, String username, String phone, String password) async {
    User user = User(fullname, username, phone, password);
    var check = await SQLHelper().insertUser(user);
    print("1 $check");
    if (check != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkUsername(String username) async {
    List check = await SQLHelper().getUsername(username);
    if (check.isEmpty) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }
}
