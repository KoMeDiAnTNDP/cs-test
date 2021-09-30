abstract class Entity<T> {
  Entity();
  Entity<T> copyWith();
  bool get isValid;
  bool get isNotValid;
  Entity.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  Entity.createEmpty();

  static bool parseJsonBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value == 1;
    if (value is String) return value.toLowerCase() == 'true';
    return null;
  }

  static DateTime parseJsonDate(dynamic value) {
    if (value is DateTime) return value;
    if (value is num) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is String) return DateTime.parse(value);
    return null;
  }

  static num parseJsonNum(dynamic value) {
    if (value is num) return value;
    if (value is String) return num.parse(value);
    if (value is bool) return value ? 1 : 0;
    return null;
  }
}