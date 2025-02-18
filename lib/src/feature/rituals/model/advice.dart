// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Advice {
  int id;
  String title;
  String content;

  Advice({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Advice.fromMap(Map<String, dynamic> map) {
    return Advice(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
    };
  }

  Advice copyWith({
    int? id,
    String? title,
    String? content,
  }) {
    return Advice(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advice.fromJson(String source) => Advice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Advice(id: $id, title: $title, content: $content)';

  @override
  bool operator ==(covariant Advice other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.content == content;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ content.hashCode;
}
