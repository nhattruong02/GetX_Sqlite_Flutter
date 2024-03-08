import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqlite/database/db.dart';

import '../model/user.dart';

class ControllerLogin extends GetxController{
  TextEditingController username = TextEditingController();
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
    username.dispose();
    password.dispose();
    // SQLHelper().close();
  }
  Future<bool> getUser(String username,String password) async{
    var check = await SQLHelper().getUser(username, password);
    if(check == true){
      print("check true: $check");
      return true;
    }
    else{
      print("check false: $check");
      return false;
    }
  }
}