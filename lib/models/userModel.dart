// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'category.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String sex;
  final String phone;
  final String city;
  final String country;
  final bool isAdmin;
  final bool isAproved;
  final String? image;
  final String? token;
  final List<AppliedJob>? appliedJobs;
  final List<BookMark>? bookMarks;
  final List<Category>? categories;
  final String? bio;
  final List<WorkExperience>? workExperience;
  final List<Education>? education;
  final List<Certificate>? certificates;
  final List<Language>? languages;
  final List<Skill>? skills;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.sex,
    required this.phone,
    required this.city,
    required this.country,
    required this.isAdmin,
    required this.isAproved,
    this.image,
    this.token,
    this.appliedJobs,
    this.bookMarks,
    this.categories,
    this.bio,
    this.workExperience,
    this.education,
    this.certificates,
    this.languages,
    this.skills,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      sex: map['sex'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      isAproved: map['isAproved'] ?? false,
      image: map['image'] ?? '',
      token: map['token'] ?? '',
      appliedJobs: map['appliedJobs'] != null
          ? List<AppliedJob>.from(
              map['appliedJobs'].map((x) => AppliedJob.fromMap(x)))
          : [],
      bookMarks: map['bookMarks'] != null
          ? List<BookMark>.from(
              map['bookMarks'].map((x) => BookMark.fromMap(x)))
          : [],
      categories: map['categories'] != null
          ? List<Category>.from(
              map['categories'].map((x) => Category.fromMap(x)))
          : [],
      bio: map['bio'] ?? "",
      workExperience: map['workExperience'] != null
          ? List<WorkExperience>.from(
              map['workExperience'].map((x) => WorkExperience.fromMap(x)))
          : [],
      education: map['education'] != null
          ? List<Education>.from(
              map['education'].map((x) => Education.fromMap(x)))
          : [],
      certificates: map['certificates'] != null
          ? List<Certificate>.from(
              map['certificates'].map((x) => Certificate.fromMap(x)))
          : [],
      languages: map['languages'] != null
          ? List<Language>.from(
              map['languages'].map((x) => Language.fromMap(x)))
          : [],
      skills: map['skills'] != null
          ? List<Skill>.from(map['skills'].map((x) => Skill.fromMap(x)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'sex': sex,
      'phone': phone,
      'city': city,
      'country': country,
      'isAdmin': isAdmin,
      'isAproved': isAproved,
      'image': image,
      'token': token,
      'appliedJobs': appliedJobs?.map((x) => x.toMap()).toList(),
      'bookMarks': bookMarks?.map((x) => x.toMap()).toList(),
      'categories': categories?.map((x) => x.toMap()).toList(),
      'bio': bio,
      'workExperience': workExperience?.map((x) => x.toMap()).toList(),
      'education': education?.map((x) => x.toMap()).toList(),
      'certificates': certificates?.map((x) => x.toMap()).toList(),
      'languages': languages?.map((x) => x.toMap()).toList(),
      'skills': skills?.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? sex,
    String? phone,
    String? city,
    String? country,
    bool? isAdmin,
    bool? isAproved,
    String? token,
    String? image,
    List<AppliedJob>? appliedJobs,
    List<BookMark>? bookMarks,
    List<Category>? categories,
    String? bio,
    List<WorkExperience>? workExperience,
    List<Education>? education,
    List<Certificate>? certificates,
    List<Language>? languages,
    List<Skill>? skills,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      country: country ?? this.country,
      isAdmin: isAdmin ?? this.isAdmin,
      isAproved: isAproved ?? this.isAproved,
      image: image ?? this.image,
      token: token ?? this.token,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      bookMarks: bookMarks ?? this.bookMarks,
      categories: categories ?? this.categories,
      bio: bio ?? this.bio,
      workExperience: workExperience ?? this.workExperience,
      education: education ?? this.education,
      certificates: certificates ?? this.certificates,
      languages: languages ?? this.languages,
      skills: skills ?? this.skills,
    );
  }
}

class JobRef {
  String? id;
  String? title;
  String? company;
  String? jobType;
  String? companyLogoUrl;
  String? city;

  JobRef({this.id, this.jobType, this.company, this.title});

  JobRef.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    company = json['company'];
    companyLogoUrl = json['companyLogoUrl'];
    jobType = json['jobType'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['company'] = this.company;
    data['companyLogoUrl'] = this.companyLogoUrl;
    data['jobType'] = this.jobType;
    data['city'] = this.city;
    return data;
  }
}

// Example of nested model classes for applied jobs
class AppliedJob {
  final JobRef job;
  final String applicationStatus;

  AppliedJob({
    required this.job,
    required this.applicationStatus,
  });

  factory AppliedJob.fromMap(Map<String, dynamic> map) {
    return AppliedJob(
      job: JobRef.fromJson(map['job']),
      applicationStatus: map['applicationStatus'] ?? 'Applied',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'job': job,
      'applicationStatus': applicationStatus,
    };
  }
}

class BookMark {
  final JobRef job;

  BookMark({required this.job});

  factory BookMark.fromMap(Map<String, dynamic> map) {
    return BookMark(
      job: JobRef.fromJson(map['job']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'job': job,
    };
  }
}

class WorkExperience {
  final String title;
  final String category;
  final String employmentType;
  final String companyName;
  final String location;
  final bool currentlyWorking;
  final DateTime? startDate;
  final DateTime? endDate;
  final String description;

  WorkExperience({
    required this.title,
    required this.category,
    required this.employmentType,
    required this.companyName,
    required this.location,
    required this.currentlyWorking,
    this.startDate,
    this.endDate,
    required this.description,
  });

  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      employmentType: map['employmentType'] ?? '',
      companyName: map['companyName'] ?? '',
      location: map['location'] ?? '',
      currentlyWorking: map['currentlyWorking'] ?? false,
      startDate:
          map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'employmentType': employmentType,
      'companyName': companyName,
      'location': location,
      'currentlyWorking': currentlyWorking,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
    };
  }
}

class Education {
  final String school;
  final String degree;
  final String fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final String description;

  Education({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    this.startDate,
    this.endDate,
    required this.description,
  });

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      school: map['school'] ?? '',
      degree: map['degree'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      startDate:
          map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'school': school,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
    };
  }
}

class Certificate {
  final String title;
  final String organization;
  final DateTime? issueDate;
  final String certificateUrl;
  final String description;

  Certificate({
    required this.title,
    required this.organization,
    this.issueDate,
    required this.certificateUrl,
    required this.description,
  });

  factory Certificate.fromMap(Map<String, dynamic> map) {
    return Certificate(
      title: map['title'] ?? '',
      organization: map['organization'] ?? '',
      issueDate:
          map['issueDate'] != null ? DateTime.parse(map['issueDate']) : null,
      certificateUrl: map['certificateUrl'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'organization': organization,
      'issueDate': issueDate?.toIso8601String(),
      'certificateUrl': certificateUrl,
      'description': description,
    };
  }
}

class Language {
  final String language;
  final String level;

  Language({
    required this.language,
    required this.level,
  });

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      language: map['language'] ?? '',
      level: map['level'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'level': level,
    };
  }
}

class Skill {
  final String skill;
  final String level;

  Skill({
    required this.skill,
    required this.level,
  });

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      skill: map['skill'] ?? '',
      level: map['level'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skill': skill,
      'level': level,
    };
  }
}
