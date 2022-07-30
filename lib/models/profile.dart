import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Profile {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? description;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool logged;

  Profile({
    String? id,
    required this.name,
    this.email,
    required this.photo,
    this.phone,
    this.description,
    this.logged = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Profile.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      name = map["name"],
      email = map["email"],
      phone = map["phone"],
      description = map["description"],
      photo = map["photo"],
      logged = map["logged"],
      createdAt = DateFormat("yyyy-MM-dd HH:mm:ss").parse(map["createdAt"]),
      updatedAt = DateFormat("yyyy-MM-dd HH:mm:ss").parse(map["updatedAt"]);

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "description": description,
    "photo": photo,
    "logged": logged,
    "createdAt": DateFormat("yyyy-MM-dd HH:mm:ss").format(createdAt),
    "updatedAt": DateFormat("yyyy-MM-dd HH:mm:ss").format(updatedAt),
  };

  Profile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? description,
    String? photo,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? logged,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      logged: logged ?? this.logged,
    );
  }
}
