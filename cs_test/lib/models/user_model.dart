import 'package:meta/meta.dart';
import 'package:cs_test/models/entity.dart';

@immutable
class User extends Entity<User> {
  final int id;
  final String name;
  final String email;
  final DateTime updatedAt;

  User({
    @required this.id, 
    @required this.name, 
    @required this.email,
    @required this.updatedAt
  });

  @override
  Entity<User> copyWith({int id, String name, String email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode ^ updatedAt.hashCode;

  @override
  bool get isValid => id != null;

  @override
  bool get isNotValid => !isValid;

  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is User &&
      id == other.id &&
      name == other.name &&
      email == other.email &&
      updatedAt == other.updatedAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

  @override
  User.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    name = json['name'],
    email = json['email'],
    updatedAt = Entity.parseJsonDate(json['updatedAt']);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'updatedAt': updatedAt != null ? updatedAt.toIso8601String() : null
  };

  @override
  factory User.createEmpty() => User(id: null, name: null, email: null, updatedAt: null);
}