class Player {
  late int ?id;
  late String name;
  late int age;
  late String club;
  late String photo;

  Player(this.name, this.age, this.club, this.photo,[this.id]);
  // Player(this.name, this.age, this.club, this.photo);
  Map<String, Object?> toMap() {
    var map = <String, dynamic>{
      // 'id' : id,
      'name': name,
      'age': age,
      'club': club,
      'photo': photo
    };
    return map;
  }

  Player.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    age = map['age'];
    club = map['club'];
    photo = map['photo'];
  }

  @override
  String toString() {
    return 'Player{id: $id, name: $name, age: $age, club: $club, photo: $photo}';
  }
}
