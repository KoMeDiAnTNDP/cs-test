import 'package:flutter/foundation.dart';
import 'package:cs_test/models/models.dart';

class DataStateRepository {
  final List<User> users;
  final List<Medication> medications;

  DataStateRepository({
    @required this.users,
    @required this.medications,
  });

  factory DataStateRepository.createEmpty() => DataStateRepository(
    users: [],
    medications: [],
  );

  @override
  int get hashCode => users.hashCode ^ medications.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is DataStateRepository &&
    other.users == users &&
    other.medications == medications;

  DataStateRepository copyWith({
    List<User> users,
    List<Medication> medications,
  }) => DataStateRepository(
    users: users ?? this.users,
    medications: medications ?? this.medications,
  );
}