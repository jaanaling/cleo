// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Rituals {
  int id;
  String title;
  String description;
  String category;
  List<RitualStage> stages;
  int daytime;

  Rituals({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.stages,
    required this.daytime,
  });

  factory Rituals.fromMap(Map<String, dynamic> map) {
    return Rituals(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      daytime: map['daytime'] as int,
      stages: List<RitualStage>.from(
        (map['stages'] as List<dynamic>).map<RitualStage>(
          (x) => RitualStage.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'daytime': daytime,
      'stages': stages.map((x) => x.toMap()).toList(),
    };
  }

  Rituals copyWith({
    int? id,
    String? title,
    String? description,
    int? daytime,
    String? category,
    List<RitualStage>? stages,
  }) {
    return Rituals(
      id: id ?? this.id,
      daytime: daytime ?? this.daytime,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      stages: stages ?? this.stages,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rituals.fromJson(String source) =>
      Rituals.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rituals(id: $id, title: $title, description: $description, category: $category, stages: $stages)';
  }

  @override
  bool operator ==(covariant Rituals other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.daytime == daytime &&
        other.description == description &&
        other.category == category &&
        listEquals(other.stages, stages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        daytime.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        stages.hashCode;
  }
}

class RitualStage {
  int number;
  String title;
  String description;

  RitualStage({
    required this.number,
    required this.title,
    required this.description,
  });

  factory RitualStage.fromMap(Map<String, dynamic> map) {
    return RitualStage(
      number: map['number'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'title': title,
      'description': description,
    };
  }

  RitualStage copyWith({
    int? number,
    String? title,
    String? description,
  }) {
    return RitualStage(
      number: number ?? this.number,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  String toJson() => json.encode(toMap());

  factory RitualStage.fromJson(String source) => RitualStage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RitualStage(number: $number, title: $title, description: $description)';

  @override
  bool operator ==(covariant RitualStage other) {
    if (identical(this, other)) return true;
  
    return 
      other.number == number &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => number.hashCode ^ title.hashCode ^ description.hashCode;
}
