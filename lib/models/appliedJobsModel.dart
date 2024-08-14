import 'dart:convert';
import 'package:job_findder_app/models/jobs.dart';

class AppliedJob {
  final String id;
  final UserRef? user;
  final JobRef? job;
  final String applicationStatus;
  final DateTime appliedAt;

  AppliedJob({
    required this.id,
    required this.user,
    required this.job,
    required this.applicationStatus,
    required this.appliedAt,
  });

  factory AppliedJob.fromMap(Map<String, dynamic> map) {
    return AppliedJob(
      id: map['_id'] ?? '',
      user: map['userId'] != null ? UserRef.fromJson(map['userId']) : null,
      job: map['jobId'] != null ? JobRef.fromJson(map['jobId']) : null,
      applicationStatus: map['applicationStatus'] ?? '',
      appliedAt: DateTime.parse(map['appliedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user': user,
      'job': job,
      'applicationStatus': applicationStatus,
      'appliedAt': appliedAt.toIso8601String(),
    };
  }

  factory AppliedJob.fromJson(String source) =>
      AppliedJob.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

class UserRef {
  String? id;
  String? name;
  String? phone;
  String? email;

  UserRef({this.id, this.name, this.email, this.phone});

  UserRef.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    name = json['phone'];
    name = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class JobRef {
  String? id;
  String? title;
  String? company;
  String? jobType;

  JobRef({this.id, this.jobType, this.company, this.title});

  JobRef.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    company = json['company'];
    jobType = json['jobType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['company'] = this.company;
    data['jobType'] = this.jobType;
    return data;
  }
}
