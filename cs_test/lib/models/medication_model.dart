import 'package:meta/meta.dart';
import 'package:cs_test/models/entity.dart';

@immutable
class Medication extends Entity<Medication> {
  /// Name of the medication
  final String name;        
  /// Dosage of the medication
  final String dosage;      
  /// Measurement or format of the medication
  final String dosageType;  
  /// Count of the medication dosage
  final int dosageSize;     
  /// Total times per day to take medication
  final int timesPerDay;    
  /// Beginning of prescribed time
  final DateTime start;     
  /// End of prescribed time
  final DateTime expiry;    
  /// Enable/disable expiry notification
  final bool reminder;      
  /// Times of day to administer medication
  final String interval;    
  /// Notes about medication
  final String notes;       
  /// Associated address string (alternative to locationId)
  final String address;     
  /// Unique ID
  final int id;             
  /// Associated user ID
  final int userId;          
  /// Last database entry update time
  final DateTime updatedAt; 
  /// Initial database entry time
  final DateTime createdAt; 

  Medication({
    @required this.name,
    @required this.dosage,
    @required this.dosageType,
    @required this.dosageSize,
    @required this.timesPerDay,
    @required this.start,
    @required this.expiry,
    @required this.reminder,
    @required this.interval,
    @required this.notes,
    @required this.address,
    @required this.id,
    @required this.userId,
    @required this.updatedAt,
    @required this.createdAt
  });

  @override
  Medication copyWith({ 
    String name,
    String dosage,
    String dosageType,
    int dosageSize,
    int timesPerDay,
    DateTime start,
    DateTime expiry,
    bool reminder,
    String interval,
    String notes,
    String address,
    int id,
    int userId,
    DateTime updatedAt,
    DateTime createdAt}) {
    return Medication(
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      dosageType: dosageType ?? this.dosageType,
      dosageSize: dosageSize ?? this.dosageSize,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      start: start ?? this.start,
      expiry: expiry ?? this.expiry,
      reminder: reminder ?? this.reminder,
      interval: interval ?? this.interval,
      notes: notes ?? this.notes,
      address: address ?? this.address,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt
    );
  }

  List<DateTime> get timeIntervals {
    List<DateTime> timeIntervals = [];
    var now = new DateTime.now();
    var timesToTake = this.interval.split(',');
    for (var time in timesToTake) {
      var timeParts = time.split(":");
      timeIntervals.add(new DateTime(
          now.year, now.month, now.day, int.parse(timeParts[0]),
          int.parse(timeParts[1])));
    }
    return timeIntervals;
  }

  DateTime get closestTimeIntervalToNow {
    var timeIntervals = this.timeIntervals;
    var now = new DateTime.now();
    DateTime closestTime;
    Duration duration;
    for(var time in timeIntervals) {
      var durationTemp = now.difference(time);
      if (closestTime == null || durationTemp.abs().compareTo(duration) < 0) {
        closestTime = time;
        duration = durationTemp;
      }
    }
    return closestTime;
  }

  String get remainingTime {
    var timeRemainingDuration = this.expiry.difference(DateTime.now().toUtc());
    if (!timeRemainingDuration.isNegative) {
      if (timeRemainingDuration.inDays / 30 > 1) {
        return "${(timeRemainingDuration.inDays / 30).ceil()} months remaining";
      }
      if (timeRemainingDuration.inHours / 24 > 1) {
        return "${(timeRemainingDuration.inHours /24).ceil()} days remaining";
      }
      if (timeRemainingDuration.inMinutes / 60 > 1) {
        return "${(timeRemainingDuration.inHours / 60).ceil()} hours remaining";
      }
    }
    return "Expired";
  }

  @override
  int get hashCode => name.hashCode ^ dosage.hashCode ^ dosageType.hashCode ^ dosageSize.hashCode ^ timesPerDay.hashCode ^
    start.hashCode ^ expiry.hashCode ^ reminder.hashCode ^ interval.hashCode ^ notes.hashCode ^
    address.hashCode ^ id.hashCode ^ userId.hashCode ^ updatedAt.hashCode ^ createdAt.hashCode;
  
  @override
  bool get isValid =>  this.id != null && userId != null;

  @override
  bool get isNotValid => !isValid;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is Medication &&
      other.name == name &&
      other.dosage == dosage &&
      other.dosageType == dosageType &&
      other.dosageSize == dosageSize &&
      other.timesPerDay == timesPerDay &&
      other.start == start &&
      other.expiry == expiry &&
      other.reminder == reminder &&
      other.interval == interval &&
      other.notes == notes &&
      other.address == address &&
      other.id == id &&
      other.userId == userId &&
      updatedAt == other.updatedAt &&
      createdAt == other.createdAt;

  @override
  Medication.fromJson(Map<String, dynamic> json) :
    name = json['name'] ?? null,
    dosage = json['dosage'] ?? null,
    dosageType = json['dosageType'] ?? null,
    dosageSize = json['dosageSize'] ?? null,
    timesPerDay = json['timesPerDay'] ?? null,
    start = Entity.parseJsonDate(json['start']),
    expiry = Entity.parseJsonDate(json['expiry']),
    reminder = Entity.parseJsonBool(json['reminder']),
    interval = json['interval'] ?? null,
    notes = json['notes'] ?? null,
    address = json['address'] ?? null,
    id = json['id'],
    userId = json['userId'],
    updatedAt = Entity.parseJsonDate(['updatedAt']) ?? null,
    createdAt = Entity.parseJsonDate(['createdAt']) ?? null;

  @override
  Map<String, dynamic> toJson() => {
    'name': name ?? null,
    'dosage': dosage ?? null,
    'dosageType': dosageType ?? null,
    'dosageSize': dosageSize ?? null,
    'timesPerDay': timesPerDay ?? null,
    'start': start != null ? start.toIso8601String() : null,
    'expiry': expiry != null ? expiry.toIso8601String() : null,
    'reminder': reminder ?? null,
    'interval': interval ?? null,
    'notes': notes ?? null,
    'address': address ?? null,
    'id': id ?? null,
    'userId': userId ?? null,
    'updatedAt': updatedAt != null ? updatedAt.toIso8601String() : null,
    'createdAt': createdAt != null ? createdAt.toIso8601String() : null
  };

  @override
  factory Medication.createEmpty() =>
    Medication(name: null, dosage: null, dosageType: null, dosageSize: null, timesPerDay: null, start: null, 
      expiry: null, reminder: null, interval: null, notes: null, address: null, id: null, userId: null, 
      createdAt: null, updatedAt: null);
}
