import 'package:flutter/material.dart';
import 'package:job_findder_app/models/jobs.dart';
import 'package:job_findder_app/screens/client/bookmark/widgets/recommendedProduct.dart';
import 'package:provider/provider.dart';

import '../../../../constants/appColors.dart';
import '../../../../provider/userProvider.dart';
import '../../details/screens/job_details.dart';
import '../widgets/appliedJobsWidget.dart';

class AppliedJobsScreen extends StatefulWidget {
  const AppliedJobsScreen({super.key});

  @override
  State<AppliedJobsScreen> createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends State<AppliedJobsScreen> {
  List<Job> jobsList = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final jobsList = context.watch<UserProvider>().user.appliedJobs;
    print(jobsList);
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            elevation: 3,
            automaticallyImplyLeading: false,
            title: const Text('Applied Jobs'),
          ),
          body: jobsList == []
              ? const Center(
                  child: Text('No'),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: jobsList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var job = jobsList[index];
                    print("job $job");
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: AppliedJobsWidget(index: index));
                  },
                )),
    );
  }
}
