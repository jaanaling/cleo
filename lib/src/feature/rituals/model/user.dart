// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  int water; // вода в мл
  int food; // калории пищи
  Duration sleep; // время сна (часы и минуты)
  List<HistoryWater> waterHistory; // история потребления воды
  List<HistoryFood> foodHistory; // история потребления пищи
  List<HistorySleep> sleepHistory; // история сна

  User({
    required this.water,
    required this.food,
    required this.sleep,
    required this.waterHistory,
    required this.foodHistory,
    required this.sleepHistory,
  });

  User.init()
      : water = 0,
        food = 0,
        sleep = Duration.zero,
        waterHistory = [],
        foodHistory = [],
        sleepHistory = [];

  double getWaterPercentage() {
    return (water / 2000) * 100;
  }

  double getFoodPercentage() {
    return (food / 2500) * 100;
  }

  double getSleepPercentage() {
    final totalSleepInMinutes = sleep.inMinutes;
    final goalInMinutes = 8 * 60; // Переводим цель в минуты
    return (totalSleepInMinutes / goalInMinutes) * 100;
  }

  double getOverallStatus() {
    final waterStatus = getWaterPercentage();
    final foodStatus = getFoodPercentage();
    final sleepStatus = getSleepPercentage();

    return (waterStatus + foodStatus + sleepStatus) / 3;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      water: map['water'] as int,
      food: map['food'] as int,
      sleep: Duration(
        hours: map['sleep_hours'] as int,
        minutes: map['sleep_minutes'] as int,
      ),
      waterHistory: List<HistoryWater>.from(
        (map['waterHistory'] as List<dynamic>).map<HistoryWater>(
          (x) => HistoryWater.fromMap(x as Map<String, dynamic>),
        ),
      ),
      foodHistory: List<HistoryFood>.from(
        (map['foodHistory'] as List<dynamic>).map<HistoryFood>(
          (x) => HistoryFood.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sleepHistory: List<HistorySleep>.from(
        (map['sleepHistory'] as List<dynamic>).map<HistorySleep>(
          (x) => HistorySleep.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'water': water,
      'food': food,
      'sleep_hours': sleep.inHours,
      'sleep_minutes': sleep.inMinutes % 60,
      'waterHistory': waterHistory.map((x) => x.toMap()).toList(),
      'foodHistory': foodHistory.map((x) => x.toMap()).toList(),
      'sleepHistory': sleepHistory.map((x) => x.toMap()).toList(),
    };
  }

  User copyWith({
    int? water,
    int? food,
    Duration? sleep,
    List<HistoryWater>? waterHistory,
    List<HistoryFood>? foodHistory,
    List<HistorySleep>? sleepHistory,
  }) {
    return User(
      water: water ?? this.water,
      food: food ?? this.food,
      sleep: sleep ?? this.sleep,
      waterHistory: waterHistory ?? this.waterHistory,
      foodHistory: foodHistory ?? this.foodHistory,
      sleepHistory: sleepHistory ?? this.sleepHistory,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(water: $water, food: $food, sleep: $sleep, waterHistory: $waterHistory, foodHistory: $foodHistory, sleepHistory: $sleepHistory)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.water == water &&
        other.food == food &&
        other.sleep == sleep &&
        listEquals(other.waterHistory, waterHistory) &&
        listEquals(other.foodHistory, foodHistory) &&
        listEquals(other.sleepHistory, sleepHistory);
  }

  @override
  int get hashCode {
    return water.hashCode ^
        food.hashCode ^
        sleep.hashCode ^
        waterHistory.hashCode ^
        foodHistory.hashCode ^
        sleepHistory.hashCode;
  }
}

class HistoryWater {
  DateTime time;
  int water;

  HistoryWater({
    required this.time,
    required this.water,
  });

  factory HistoryWater.fromMap(Map<String, dynamic> map) {
    return HistoryWater(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      water: map['water'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'water': water,
    };
  }

  HistoryWater copyWith({
    DateTime? time,
    int? water,
  }) {
    return HistoryWater(
      time: time ?? this.time,
      water: water ?? this.water,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryWater.fromJson(String source) =>
      HistoryWater.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HistoryWater(time: $time, water: $water)';

  @override
  bool operator ==(covariant HistoryWater other) {
    if (identical(this, other)) return true;

    return other.time == time && other.water == water;
  }

  @override
  int get hashCode => time.hashCode ^ water.hashCode;
}

class HistoryFood {
  DateTime time;
  int food;

  HistoryFood({
    required this.time,
    required this.food,
  });

  factory HistoryFood.fromMap(Map<String, dynamic> map) {
    return HistoryFood(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      food: map['food'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'food': food,
    };
  }

  HistoryFood copyWith({
    DateTime? time,
    int? food,
  }) {
    return HistoryFood(
      time: time ?? this.time,
      food: food ?? this.food,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryFood.fromJson(String source) =>
      HistoryFood.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HistoryFood(time: $time, food: $food)';

  @override
  bool operator ==(covariant HistoryFood other) {
    if (identical(this, other)) return true;

    return other.time == time && other.food == food;
  }

  @override
  int get hashCode => time.hashCode ^ food.hashCode;
}

class HistorySleep {
  DateTime time;
  Duration sleep;

  HistorySleep({
    required this.time,
    required this.sleep,
  });

  factory HistorySleep.fromMap(Map<String, dynamic> map) {
    return HistorySleep(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      sleep: Duration(
        hours: map['sleep_hours'] as int,
        minutes: map['sleep_minutes'] as int,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'sleep_hours': sleep.inHours,
      'sleep_minutes': sleep.inMinutes % 60,
    };
  }

  HistorySleep copyWith({
    DateTime? time,
    Duration? sleep,
  }) {
    return HistorySleep(
      time: time ?? this.time,
      sleep: sleep ?? this.sleep,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistorySleep.fromJson(String source) =>
      HistorySleep.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HistorySleep(time: $time, sleep: $sleep)';

  @override
  bool operator ==(covariant HistorySleep other) {
    if (identical(this, other)) return true;

    return other.time == time && other.sleep == sleep;
  }

  @override
  int get hashCode => time.hashCode ^ sleep.hashCode;
}
