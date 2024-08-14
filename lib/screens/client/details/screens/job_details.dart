import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:job_findder_app/constants/appColors.dart';
import 'package:provider/provider.dart';

import '../../../../models/jobs.dart';
import '../../../../provider/userProvider.dart';
import '../services/details_services.dart';
import '../widgets/circleImage.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;
  static const String routeName = '/job-details';

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isLoading = false;

  void applayJob(String userId) {
    setState(() {
      isLoading = true;
    });
    JobDetailsServices().createAppliedJob(
        context: context,
        userId: userId,
        jobId: "${widget.job.id}",
        onError: () {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().user;
    if (user.appliedJobs != null) {
      for (var element in user.appliedJobs!) {
        print(element);
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/gradient-wave-colorful.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_rounded,
                              color: Colors.white),
                        )
                      ],
                    )),
                Expanded(
                  flex: 26,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 40,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CircleImageWithBorder(
                            imageUrl: widget.job.companyLogoUrl,
                            borderWidth: 4.0,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 140,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Text(
                                    widget.job.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    widget.job.company,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            child: Icon(
                                              Icons.monetization_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: Text(
                                            'Salary',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '\$600 - \$800',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          leading: const CircleAvatar(
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            child: Icon(
                                              Icons.work_history,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: const Text(
                                            'Job type',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          subtitle: Text(
                                            widget.job.jobType,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Job Details",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.job.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Requirrments",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (var item
                                    in widget.job.experienceRequirements)
                                  Text(
                                    "* $item",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Resonsibilities",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (var item in widget.job.responsibilities)
                                  Text(
                                    "* $item",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Qualifications",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (var item in widget.job.qualifications)
                                  Text(
                                    "* $item",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white),
                onPressed: () => applayJob(user.id),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Apply Now'),
                )),
      ),
    );
  }
}
