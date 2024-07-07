import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_findder_app/constants/appColors.dart';

import '../../../../models/jobs.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;
  static const String routeName = '/job-details';

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        actions: const [
          Icon(
            Icons.bookmark_add,
          ),
          SizedBox(width: 8)
        ],
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.4,
            child: Stack(children: [
              Positioned(
                left: 20,
                right: 20,
                top: 50,
                child: Container(
                  height: size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.network(
                      widget.job.companyLogoUrl,
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: size.width * 0.84,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                Text(
                                  widget.job.title,
                                  style: const TextStyle(
                                      color: AppColors.primarycolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(widget.job.company,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.job.city,
                                  style: const TextStyle(
                                      color: AppColors.primarycolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.job.city,
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        DateFormat.yMMMMd('en_US')
                                            .format(widget.job.postedDate!),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.job.jobType,
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                )
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Mogadishu, Somalia',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                Text('\$900/month',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppColors.primarycolor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarycolor),
                    tabs: [
                      Tab(text: 'Overview'),
                      Tab(text: 'Experience'),
                      Tab(text: 'More'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Content for Tab 1
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.job.jobOverview,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                        // Content for Tab 2
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ListView.builder(
                            itemCount: widget.job.experienceRequirements.length,
                            itemBuilder: (BuildContext context, int index) {
                              var req =
                                  widget.job.experienceRequirements[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      req,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        // Content for Tab 3
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.job.qualifications.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var qualifications =
                                        widget.job.qualifications[index];
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "*",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            qualifications,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Responsibilities'),
                              Flexible(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.job.responsibilities.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var responsibilities =
                                        widget.job.responsibilities[index];
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "*",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            responsibilities,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: Colors.white),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Apply Now'),
            )),
      ),
    );
  }
}
