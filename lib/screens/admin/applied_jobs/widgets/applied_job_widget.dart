import 'package:flutter/material.dart';
import 'package:job_findder_app/models/appliedJobsModel.dart';

class AppliedJobWidget extends StatelessWidget {
  final AppliedJob appliedJob;
  final VoidCallback? onPressed;
  const AppliedJobWidget({super.key, required this.appliedJob, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'User Info: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed:null ,
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
    );
  }
}
