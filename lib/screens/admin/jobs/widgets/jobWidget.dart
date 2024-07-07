import 'package:flutter/material.dart';
import 'package:job_findder_app/models/jobs.dart';

import '../../../../common/custom_Alertdailog.dart';
import '../../../../constants/appColors.dart';

class JobWidget extends StatelessWidget {
  final Job job;
  final VoidCallback navigateToUpdateJobScreen;
  final VoidCallback deleteJobs;
  const JobWidget(
      {super.key,
      required this.job,
      required this.navigateToUpdateJobScreen,
      required this.deleteJobs});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyBackgroundCOlor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(
                job.companyLogoUrl,
                width: 60,
              ),
              title: Text(
                job.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: Text('\$${job.salary}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 6),
            Text(
                'Category: ${job.category is String ? 'null' : job.category['name']}'),
            const SizedBox(height: 6),
            Text(
              'SubCategory: ${job.subcategory is String ? 'null' : job.subcategory['name']}',
            ),
            const SizedBox(height: 6),
            Text('Country: ${job.country}'),
            const SizedBox(height: 10),
            Text('State: ${job.state}'),
            const SizedBox(height: 10),
            Text('JobType: ${job.jobType}'),
            const SizedBox(height: 10),
            Text(
              'Overview: ${job.jobOverview}',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${job.postedDate}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => navigateToUpdateJobScreen(),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  CustomAlertDailog(onTab: () => deleteJobs()),
                            ),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
