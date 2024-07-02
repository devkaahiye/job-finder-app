// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String sex;
  final bool isAdmin;
  final bool isAproved;
  final String city;
  final String country;
  final String token;
  final String? bio;
  final List<dynamic>? appliedJobs;
  final List<dynamic>? bookMarks;
  final List<dynamic>? categories;
  final List<dynamic>? workExperience;
  final List<dynamic>? education;
  final List<dynamic>? certificates;
  final List<dynamic>? languages;
  final List<dynamic>? skills;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.sex,
    required this.phone,
    required this.isAdmin,
    required this.isAproved,
    required this.city,
    required this.country,
    required this.token,
    this.bio,
    this.appliedJobs,
    this.bookMarks,
    this.categories,
    this.workExperience,
    this.education,
    this.certificates,
    this.languages,
    this.skills,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'sex': sex,
      'phone': phone,
      'isAdmin': isAdmin,
      'isAproved': isAproved,
      'city': city,
      'country': country,
      'token': token,
      'bio': bio,
      'appliedJobs': appliedJobs,
      'bookMarks': bookMarks,
      'categories': categories,
      'workExperience': workExperience,
      'education': education,
      'certificates': certificates,
      'languages': languages,
      'skills': skills,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      sex: map['sex'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      isAproved: map['isAproved'] ?? false,
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      token: map['token'] ?? '',
      bio: map['bio'] ?? '',
      appliedJobs: List<Map<String, dynamic>>.from(
        map['appliedJobs']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      bookMarks: List<Map<String, dynamic>>.from(
        map['bookMarks']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      categories: List<Map<String, dynamic>>.from(
        map['categories']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      workExperience: List<Map<String, dynamic>>.from(
        map['workExperience']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      education: List<Map<String, dynamic>>.from(
        map['education']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      certificates: List<Map<String, dynamic>>.from(
        map['certificates']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      languages: List<Map<String, dynamic>>.from(
        map['languages']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      skills: List<Map<String, dynamic>>.from(
        map['skills']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? sex,
    bool? isAdmin,
    bool? isAproved,
    String? city,
    String? country,
    String? token,
    String? bio,
    List<dynamic>? appliedJobs,
    List<dynamic>? bookMarks,
    List<dynamic>? categories,
    List<dynamic>? workExperience,
    List<dynamic>? education,
    List<dynamic>? certificates,
    List<dynamic>? languages,
    List<dynamic>? skills,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      sex: sex ?? this.sex,
      isAdmin: isAdmin ?? this.isAdmin,
      isAproved: isAproved ?? this.isAproved,
      city: city ?? this.city,
      country: country ?? this.country,
      token: token ?? this.token,
      bio: bio ?? this.bio,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      bookMarks: bookMarks ?? this.bookMarks,
      categories: categories ?? this.categories,
      workExperience: workExperience ?? this.workExperience,
      education: education ?? this.education,
      certificates: certificates ?? this.certificates,
      languages: languages ?? this.languages,
      skills: skills ?? this.skills,
    );
  }
}
