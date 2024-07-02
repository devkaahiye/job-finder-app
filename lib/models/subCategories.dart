// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubCategory {
  final String id;
  final String name;
  final dynamic category;

  SubCategory({
    required this.id,
    required this.name,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      category: map['category'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
