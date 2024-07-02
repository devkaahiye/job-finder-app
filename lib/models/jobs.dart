import 'dart:convert';

import '/models/category.dart';
import '/models/subCategories.dart';

class Job {
  final String? id;
  final String title;
  final dynamic category;
  final dynamic subcategory;
  final String company;
  final String city;
  final String state;
  final String country;
  final String description;
  final DateTime? postedDate;
  final List<String> responsibilities;
  final List<String> qualifications;
  final int salary;
  final String companyLogoUrl;
  final List<String> experienceRequirements;
  final String jobOverview;
  final String jobType;

  Job({
    this.id,
    required this.title,
    this.category,
    this.subcategory,
    required this.company,
    required this.city,
    required this.state,
    required this.country,
    required this.description,
    this.postedDate,
    required this.responsibilities,
    required this.qualifications,
    required this.salary,
    required this.companyLogoUrl,
    required this.experienceRequirements,
    required this.jobOverview,
    required this.jobType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category,
      'subcategory': subcategory,
      'company': company,
      'city': city,
      'state': state,
      'country': country,
      'description': description,
      'postedDate': postedDate!.millisecondsSinceEpoch,
      'responsibilities': responsibilities,
      'qualifications': qualifications,
      'salary': salary,
      'companyLogoUrl': companyLogoUrl,
      'experienceRequirements': experienceRequirements,
      'jobOverview': jobOverview,
      'jobType': jobType,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['_id'] ?? "",
      title: map['title'] ?? "",
      category: map['category'] ?? "",
      subcategory: map['subcategory'] ?? "",
      company: map['company'] ?? "",
      city: map['city'] ?? "",
      state: map['state'] ?? "",
      country: map['country'] ?? "",
      description: map['description'] ?? "",
      postedDate: map['postedDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['postedDate'])
          : map['postedDate'] is String
              ? DateTime.parse(map['postedDate'])
              : DateTime.now(),
      responsibilities: List<String>.from(
          (map['responsibilities'] ?? []).map((item) => item.toString())),
      qualifications: List<String>.from(
          (map['qualifications'] ?? []).map((item) => item.toString())),
      salary: map['salary'].toInt() ?? 0,
      companyLogoUrl: map['companyLogoUrl'] ?? "",
      experienceRequirements: List<String>.from(
          (map['experienceRequirements'] ?? []).map((item) => item.toString())),
      jobOverview: map['jobOverview'] ?? "",
      jobType: map['jobType'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) =>
      Job.fromMap(json.decode(source) as Map<String, dynamic>);
}
