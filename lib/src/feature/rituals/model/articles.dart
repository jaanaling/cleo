// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Articles {
  int id;
  String title;
  String content;

  Articles({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Articles.fromMap(Map<String, dynamic> map) {
    return Articles(
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

  Articles copyWith({
    int? id,
    String? title,
    String? content,
  }) {
    return Articles(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  String toJson() => json.encode(toMap());

  factory Articles.fromJson(String source) => Articles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Articles(id: $id, title: $title, content: $content)';

  @override
  bool operator ==(covariant Articles other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.content == content;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ content.hashCode;
}
