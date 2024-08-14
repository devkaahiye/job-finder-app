import 'package:flutter/material.dart';
import 'package:job_findder_app/models/jobs.dart';
import 'package:job_findder_app/screens/client/services/client_services.dart';
import 'package:provider/provider.dart';

import '../../../../constants/appColors.dart';
import '../../../../provider/userProvider.dart';

class AppliedJobsWidget extends StatefulWidget {
  final int index;
  const AppliedJobsWidget({super.key, required this.index});

  @override
  State<AppliedJobsWidget> createState() => _AppliedJobsWidgetState();
}

class _AppliedJobsWidgetState extends State<AppliedJobsWidget> {
  final ClientServices _clientServices = ClientServices();

  void removeItemCart(int index) {
    _clientServices.removeItem(
      context: context,
      index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobsList =
        context.watch<UserProvider>().user.appliedJobs![widget.index];
    final job = jobsList.job;

    return Card(
      surfaceTintColor: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 6),
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              job.companyLogoUrl,
              width: 25,
            ),
          ),
        ),
        title: Text(job.title,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColors.primarycolor)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ApplicationStatus: ${jobsList.applicationStatus}",
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(job.city,
                        style: const TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(job.jobType,
                        style: const TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
