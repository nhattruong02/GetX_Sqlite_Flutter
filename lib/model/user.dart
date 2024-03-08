import 'package:getx_sqlite/database/db.dart';

class User{
    late int? id;
    late String fullname;
    late String username;
    late String phonenumber;
    late String password;

    User(this.fullname, this.username, this.phonenumber, this.password,[this.id]);
    Map<String, Object?> toMap(){
        var map = <String, dynamic>{
            'id' : id,
            'fullname' : fullname,
            'username' : username,
            'phone' : phonenumber,
            'password' : password

        };
        return map;
    }
    User.fromMap(Map<dynamic, dynamic> map){
        id= map['id'];
        fullname = map['fullname'];
        username = map['username'];
        phonenumber = map['phone'];
        password = map['password'];
    }
}