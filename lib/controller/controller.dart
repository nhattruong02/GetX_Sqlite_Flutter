import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqlite/database/db.dart';
import 'package:getx_sqlite/model/player.dart';

class Controller extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController club = TextEditingController();
  TextEditingController photo = TextEditingController();
  var itemcount = 0.obs;
  RxList<Player> players = <Player>[].obs;

  @override
  void onInit() {
    getPlayer();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    name.dispose();
    age.dispose();
    club.dispose();
    photo.dispose();
    // SQLHelper().close();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getPlayer() async {
    players = RxList<Player>(await SQLHelper().getPlayer());
    itemcount.value = players.value.length;
    players.refresh();
    itemcount.refresh();
  }

  void addPlayer(String name, String age, String club, String photo) {
    Player player = Player(name, int.parse(age), club, photo);
    SQLHelper().insertPlayer(player);
    getPlayer();
  }

  removePlayer(int index) {
    SQLHelper().delete(players[index].id!);
    getPlayer();
  }

  Future updatePlayer(
      String name, int age, String club, String photo, int id) async {
    Player player = Player(name, age, club, photo, id);
    await SQLHelper().updatetPlayer(player);
    await getPlayer();
  }

  void searchPlayer(String txt) async {
    List<Player> result = <Player>[];
    result = players.toList();
    if (txt.isEmpty) {
      getPlayer();
    } else {
      await getPlayer();
      result = players
          .where((e) =>
              e.name.toString().toLowerCase().contains(txt.toLowerCase()) ||
              e.age.toString().toLowerCase().contains(txt.toLowerCase()) ||
              e.club.toString().toLowerCase().contains(txt.toLowerCase()))
          .toList();
      players.value = result;
      itemcount.value = players.length;
    }
  }
}
