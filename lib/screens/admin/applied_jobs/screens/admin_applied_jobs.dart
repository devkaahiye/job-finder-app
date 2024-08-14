import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/utils.dart';
import 'package:job_findder_app/models/appliedJobsModel.dart';
import 'package:job_findder_app/screens/admin/applied_jobs/services/admin_applied_jobs_services.dart';
import 'package:job_findder_app/screens/admin/applied_jobs/widgets/applied_job_widget.dart';

import '../../../../constants/appColors.dart';

class AdminAppliedJobs extends StatefulWidget {
  static const routeName = '/admin-applied-jobs';
  const AdminAppliedJobs({super.key});

  @override
  State<AdminAppliedJobs> createState() => _AdminAppliedJobsState();
}

class _AdminAppliedJobsState extends State<AdminAppliedJobs> {
  List<String> types = [
    "Applied",
    "Reviewed",
    "Interviewed",
    "Offered",
    "Rejected",
  ];
  List<AppliedJob> appliedJobsList = [];
  bool isLoading = true;
  final AdminAppliedJobsServices _adminAppliedJobsServices =
      AdminAppliedJobsServices();

  String? _selectedStatus;

  void loadAppliedJob() async {
    appliedJobsList =
        await _adminAppliedJobsServices.getAppliedJobs(context: context);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    loadAppliedJob();
    super.initState();
  }

  void _updateAppliedJob(String jobId) async {
    if (_selectedStatus != null) {
      await _adminAppliedJobsServices
          .updateAppliedJob(context, jobId, _selectedStatus!, () {
        appliedJobsList = [];
        loadAppliedJob();
      });
    } else {
      showSnackBar(context, 'Please select a status');
    }
  }

  void _showUpdateDialog(AppliedJob appliedJob) {
    setState(() {
      // Initialize _selectedStatus with the current status of the job
      _selectedStatus = appliedJob.applicationStatus;
    });

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Update"),
            content: DropdownButton<String>(
              value: _selectedStatus,
              hint: const Text('Select Application Status'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
              items: types.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateAppliedJob(appliedJob.id);
                  },
                  child: const Text('Update'))
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied Jobs'),
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const CardLoading(
                  height: 100,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                );
              })
          : ListView.builder(
              itemCount: appliedJobsList.length,
              itemBuilder: (BuildContext context, int index) {
                var appliedJob = appliedJobsList[index];
                return RefreshIndicator(
                  onRefresh: () async {
                    appliedJobsList = [];
                    loadAppliedJob();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'User Info: ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${appliedJob.user!.name ?? "Not found"}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Email: ${appliedJob.user!.email ?? "Not found"}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Phone: ${appliedJob.user!.phone ?? "Not found"}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Job Info: ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Title: ${appliedJob.job!.title ?? "Not found"}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Company: ${appliedJob.job!.company ?? "Not found"}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "JobType: ${appliedJob.job!.jobType ?? "Not found"}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    'ApplicationStatus: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    appliedJob.applicationStatus,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          _showUpdateDialog(appliedJob),
                                      icon: const Icon(
                                        Icons.change_circle,
                                        color: Colors.blue,
                                        size: 30,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                      )),
                );
              },
            ),
    );
  }
}
