import 'package:another_flushbar/flushbar.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqlite/model/player.dart';
import 'package:getx_sqlite/screen/detail_screen.dart';
import 'package:getx_sqlite/screen/map_screen.dart';
import 'package:getx_sqlite/screen/youtube_screen.dart';

import '../controller/controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Controller c = Get.put(Controller());


  Widget _textFiel(
      String text, IconData icon, TextEditingController controller) {
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

  Future<void> checkTextFiel(BuildContext context, String txt,
      [int? index]) async {
    try {
      if (txt == 'Cancel') {
        Get.back();
      } else if (c.name.text.length < 10 || c.name.text.isNum) {
        Flushbar(
          backgroundColor: Colors.white,
          message: 'Name > 10 chars',
          messageColor: Colors.black,
          duration: Duration(seconds: 2),
        ).show(context);
      } else if ((int.parse(c.age.text) < 0) && (int.parse(c.age.text) < 100)) {
        Flushbar(
          backgroundColor: Colors.white,
          message: 'age > 0 ',
          messageColor: Colors.black,
          duration: Duration(seconds: 2),
        ).show(context);
      } else if (c.club.text.length < 10 || c.club.text.isNum) {
        Flushbar(
          backgroundColor: Colors.white,
          message: 'club > 10 chars',
          messageColor: Colors.black,
          duration: Duration(seconds: 2),
        ).show(context);
      } else if (!c.photo.text.contains("/images") || c.photo.text.isEmpty) {
        Flushbar(
          backgroundColor: Colors.white,
          message: 'photo is an url',
          messageColor: Colors.black,
          duration: Duration(seconds: 2),
        ).show(context);
      } else {
        if (txt == 'Add') {
          c.addPlayer(c.name.text, c.age.text, c.club.text, c.photo.text);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
                child: Text(
              'Added ${c.name.text}',
              style: TextStyle(color: Colors.black),
            )),
            backgroundColor: Colors.white,
          ));
          Get.back();
        }
        if (txt == 'Update') {
          c.updatePlayer(c.name.text, int.parse(c.age.text), c.club.text,
              c.photo.text, c.players[index!].id!);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
                child: Text(
              'Updated ${c.name.text}',
              style: TextStyle(color: Colors.black),
            )),
            backgroundColor: Colors.white,
          ));
          Get.back();
        }
      }
    } catch (error) {
      Flushbar(
        backgroundColor: Colors.white,
        message: 'age is number',
        messageColor: Colors.black,
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  Widget _Button(String txt, [int? index]) {
    return ElevatedButton(
        onPressed: () => {checkTextFiel(context, txt, index)},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
        child: Text(
          txt,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));
  }

  Future _MainAlerDialog(BuildContext context, String title, [int? index]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(title),
            content: Column(
              children: [
                _textFiel('Name', Icons.person, c.name),
                _textFiel('Age', Icons.accessibility, c.age),
                _textFiel('Club', Icons.account_balance, c.club),
                _textFiel('Image', Icons.photo, c.photo)
              ],
            ),
            actions: [_Button(title, index), _Button('Cancel')],
          ),
        );
      },
    );
  }

  Future<bool> confirmRemove(BuildContext context, int index) async {
    if (await confirm(
      context,
      title: const Text('Confirm'),
      content: Text('Would you like to remove ${c.players[index].name} ?'),
      textOK: const Text('Yes'),
      textCancel: const Text('No'),
    )) {
      return true;
    }
    return false;
  }

  void deleteSuccess(int index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: Text(
        'Deleted ${c.name.text}',
        style: TextStyle(color: Colors.black),
      )),
      backgroundColor: Colors.white,
    ));
    c.removePlayer(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
             Row(
              children: [
                InkWell(
                  onTap: () => Get.to(MapScreen()),
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                      child: Icon(Icons.map)),
                ),
                InkWell(
                  onTap: () => Get.to(YoutubeScreen()),
                  child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(Icons.video_collection_outlined)),
                ),
              ],
            ),
        ],
        title: Text("Main"),
        centerTitle: true,
      ),
      body:  Column(
          children: [
            Container(
              child: TextField(
                onChanged: (value) => c.searchPlayer(value),
                  decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              )),
            ),
            Expanded(
              child: Obx( () => ListView.builder(
                      itemCount: c.itemcount.value,
                      padding: EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.to(Detail(),arguments: "${c.players[index].name.toString()}"),
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(c.players[index].photo),
                                    )),
                                Expanded(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Name: ${c.players[index].name}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Age: ${c.players[index].age}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Club: ${c.players[index].club}'),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () => {
                                              c.name.text = c.players[index!].name,
                                              c.age.text =
                                                  c.players[index!].age.toString(),
                                              c.club.text = c.players[index!].club,
                                              c.photo.text = c.players[index!].photo,
                                              _MainAlerDialog(context, 'Update', index)
                                            },
                                        child: Icon(Icons.update)),
                                    TextButton(
                                        onPressed: () async =>
                                            await confirmRemove(context, index)
                                                ? deleteSuccess(index)
                                                : (),
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            _MainAlerDialog(context, 'Add');
            print(c.players.length);
          },
          child: Icon(Icons.add)),
    );
  }
}
