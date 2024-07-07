import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_findder_app/common/custom_Alertdailog.dart';
import 'package:job_findder_app/common/custom_textField.dart';
import 'package:job_findder_app/screens/admin/jobs/screens/add_jobs.dart';
import 'package:job_findder_app/screens/admin/jobs/screens/update_jobs.dart';
import 'package:job_findder_app/screens/admin/jobs/services/jobServices.dart';
import 'package:job_findder_app/screens/admin/jobs/widgets/jobWidget.dart';

import '../../../../constants/appColors.dart';
import '../../../../models/jobs.dart';

class JobsScreen extends StatefulWidget {
  static const routeName = '/jobs';
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final JobServices _jobServices = JobServices();
  final TextEditingController controller = TextEditingController();
  List<Job>? jobsList;

  void getAllJobs() async {
    jobsList = await _jobServices.getAllJobs(context: context);

    if (mounted) {
      setState(() {});
    }
  }

  void deleteJobs(String id, int index) async {
    _jobServices.delete(
        id: id,
        context: context,
        onSuccess: () {
          if (jobsList != null) {
            jobsList!.removeAt(index);
          }

          setState(() {});
        });

    if (context.mounted) {
      setState(() {});
    }
  }

  void navigateToAddJobScreen() async {
    var res = await Navigator.pushNamed(context, AddJobsScreen.routeName);

    if (res == 'refresh') {
      getAllJobs();
    }
  }

  void navigateToUpdateJobScreen(Job job) async {
    var res = await Navigator.pushNamed(context, UpdateJobsScreen.routeName,
        arguments: job);

    if (res == 'refresh') {
      getAllJobs();
    }
  }

  @override
  void initState() {
    getAllJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs(${jobsList != null ? jobsList!.length : 0})'),
        actions: [
          IconButton(
              onPressed: navigateToAddJobScreen,
              icon: const Icon(
                Icons.add_circle,
                color: AppColors.secondaryColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            CustomTextField(
                controller: controller, hintText: 'Search job by name'),
            const SizedBox(height: 10),
            Flexible(
              child: jobsList == null
                  ? const CardLoading(
                      height: 100,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: jobsList == null ? 0 : jobsList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var job = jobsList![index];
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: JobWidget(
                                job: job,
                                navigateToUpdateJobScreen: () {
                                  navigateToUpdateJobScreen(job);
                                },
                                deleteJobs: () {
                                  deleteJobs(job.id.toString(), index);
                                }));
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
